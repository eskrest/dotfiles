-- imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local widget = {}
local timer = nil

-- brightness icon starting from 0
local icons = {
	"󰛩 ",
	"󱩎 ",
	"󱩏 ",
	"󱩐 ",
	"󱩑 ",
	"󱩒 ",
	"󱩓 ",
	"󱩔 ",
	"󱩕 ",
	"󱩖 ",
	"󰛨 ",
}

local brightness_widget = wibox.widget({
	{
		id = "icon_text",
		text = "",
		font = "14",
		widget = wibox.widget.textbox,
	},
	{
		id = "brightness_text",
		text = "",
		widget = wibox.widget.textbox,
	},
	widget = wibox.widget.textbox,
	layout = wibox.layout.align.horizontal,
	set_icon = function(self, val)
		self.icon_text.text = val
	end,
	set_brightness = function(self, val)
		self.brightness_text.text = val
	end,
})

widget.widget = brightness_widget

brightness_widget:connect_signal("mouse::enter", function()
	-- enter
end)

local get_brightness = function(callback)
	awful.spawn.easy_async({"sh", "-c", "xrandr --verbose | grep -i brightness | cut -f2 -d ' '"}, function(out)
		local brightness = tonumber(out)
		callback(brightness)
	end)
end

local update = function()

	local callback = function(brightness)
		local brightness_x10 = brightness * 10
		local icon_index = math.floor(brightness_x10) + 1
		-- require("naughty").notify({ text = tostring(icon_index)})
		brightness_widget.icon = icons[icon_index]
		brightness_widget.brightness = tostring(math.floor(brightness_x10 * 10)) .. "%  "
	end
	get_brightness(callback)

end

local brightness_up = function()

	local callback = function(brightness)
		local br = math.min(brightness + 0.05, 1.0)
		awful.spawn.easy_async({"sh", "-c", "xrandr --output eDP --brightness " ..br}, function()
			update()
		end)
	end

	get_brightness(callback)
end
widget.brightness_up = brightness_up

local brightness_down = function()

	local callback = function(brightness)
		local br = math.max(brightness - 0.05, 0.1)
		awful.spawn.easy_async({"sh", "-c", "xrandr --output eDP --brightness " ..br}, function()
			update()
		end)
	end
	get_brightness(callback)
end
widget.brightness_down = brightness_down

brightness_widget:connect_signal("button::press", function(c, _, _, button)
	-- wheel up
	if button == 4 then
		brightness_up()
		return
	end
	-- wheel down
	if button == 5 then
		brightness_down()
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
