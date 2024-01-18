-- imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local widget = {}
local timer = nil

local bluetooth_widget = wibox.widget({
	text = "󰂲  ",
	font = "14",
	widget = wibox.widget.textbox,
	set_icon = function(self, val)
		self.text = val
	end,
})

widget.widget = bluetooth_widget

bluetooth_widget:connect_signal("mouse::enter", function()
	-- enter
end)

local icons = {
	"󰂲  ", "󰂯  "
}

local update = function()
	awful.spawn.easy_async({ "sh", "-c", "bluetoothctl show | grep Powered" }, function(out)
		local powered = out:match("(yes)") or "no"
		local index = 1
		-- naughty.notify({ text = powered })

		if powered == nil then
			return
		end

		if powered == 'yes' then
			index = 2
		end
		local icon = icons[index]
		bluetooth_widget.icon = icon
	end)
end

local toggle = function()
	awful.spawn.easy_async({ "sh", "-c", "bluetoothctl show | grep Powered" }, function(out)
		local powered = out:match("(yes)") or "no"

		if powered == nil then
			return
		end

		if powered == 'yes' then
			awful.spawn.easy_async("bluetoothctl power off", function()
				naughty.notify({ text = "Bluetooth off" })
				update()
			end)
			return
		end

		awful.spawn.easy_async("bluetoothctl power on", function()
			naughty.notify({ text = "Bluetooth on" })
			update()
		end)
	end)
end
widget.toggle = toggle
-- 
-- local volume_down = function()
-- 	awful.spawn.easy_async("pactl -- set-sink-volume 0 -10%", function()
-- 		-- naughty.notify({ text = "volume -10%" })
-- 		update()
-- 	end)
-- end
-- widget.volume_down = volume_down

bluetooth_widget:connect_signal("button::press", function(c, _, _, button)
	-- left mouse click
	if button == 1 then
		toggle()
		return
	end
	-- wheel down
	-- if button == 5 then
	-- 	volume_down()
	-- 	return
	-- end
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
