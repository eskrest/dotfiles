-- imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local widget = {}
local timer = nil

local sound_widget = wibox.widget({
	text = "󰖁  ",
	font = "14",
	widget = wibox.widget.textbox,
	set_volume = function(self, val)
		self.text = val
	end,
})

widget.widget = sound_widget

sound_widget:connect_signal("mouse::enter", function()
	-- enter
end)

local icons = {
	"󰝟  ", "󰕿  ", "󰖀  ", "󰕾  "
}

local update = function()
	awful.spawn.easy_async({ "sh", "-c", "pactl get-sink-volume 0" }, function(out)
	-- naughty.notify({ text = out })
	local vol = out:match("(%d%d?%d?)%%")

	if vol == nil then
		return
	end

	local index = vol / 25
	index = tostring(index):match("(%d)%.")
	-- naughty.notify({ text = vol .. " " .. index })
	local icon = icons[math.min(index+1, 4)]
	sound_widget.volume = icon
	end)
end

local volume_up = function()
	awful.spawn.easy_async("pactl -- set-sink-volume 0 +10%", function()
		-- naughty.notify({ text = "volume +10%" })
		update()
	end)
end
widget.volume_up = volume_up

local volume_down = function()
	awful.spawn.easy_async("pactl -- set-sink-volume 0 -10%", function()
		-- naughty.notify({ text = "volume -10%" })
		update()
	end)
end
widget.volume_down = volume_down

sound_widget:connect_signal("button::press", function(c, _, _, button)
	-- wheel up
	if button == 4 then
		volume_up()
		return
	end
	-- wheel down
	if button == 5 then
		volume_down()
		return
	end
end)


timer = gears.timer({
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		update()
	end,
})

return widget
