-- imports
local wibox = require("wibox")
local gears = require("gears")

--helper functions
--read from a file
-- Opens a file in read
local read_file_first_line = function(path)
	file = io.open(path, "r")
	if file == nil then
		return ""
	end
	-- sets the default input file as test.lua
	io.input(file)
	-- prints the first line of the file
	result = io.read()
	-- closes the open file
	io.close(file)
	return result
end

-- Create a widget and update its content using the output of a shell
-- command every 10 seconds:
local battery = wibox.widget({
	{
		id = "icon_text",
		text = "󱉝 ",
		font = "14",
		widget = wibox.widget.textbox,
	},
	{
		id = "capacity_text",
		text = "",
		widget = wibox.widget.textbox,
	},
	widget = wibox.widget.textbox,
	layout = wibox.layout.align.horizontal,
	set_icon = function(self, val)
		self.icon_text.text = val
	end,
	set_capacity = function(self, val)
		self.capacity_text.text = val
	end,
})

gears.timer({
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		-- You should read it from `/sys/class/power_supply/` (on Linux)
		-- instead of spawning a shell. This is only an example.
		-- awful.spawn.easy_async({ "sh", "-c", "acpi | sed -n 's/^.*, ([0-9]*)%/\1/p'" }, function(out)
		-- 	battery.battery = out
		-- end)
		-- /sys/class/power_supply/BAT0/capacity = 98
		-- /sys/class/power_supply/BAT0/status = Discharging | Charging | Full
		capacity = read_file_first_line("/sys/class/power_supply/BAT0/capacity")
		capacity = tonumber(capacity)
		cord_connected = read_file_first_line("/sys/class/power_supply/ADP1/online")
		cord_connected = tonumber(cord_connected)
		status = read_file_first_line("/sys/class/power_supply/BAT0/status")
		status = status:lower()
		if capacity == nil then
			return
		end
		if status == "full" or status == "not charging" then
			if cord_connected then
				status = "charging"
			else
				status = "discharging"
			end
		end
		local battery_statuses = {
			charging = {
				"󰢟 ", "󰢜 ", "󰂆 ", "󰂇 ", "󰂈 ", "󰢝 ", "󰂉 ", "󰢞 ", "󰂊 ", "󰂋 ", "󰂅 "
			},
			discharging = {
				"󰂎 ", "󰁺 ", "󰁻 ", "󰁼 ", "󰁽 ", "󰁾 ", "󰁿 ", "󰂀 ", "󰂁 ", "󰂂 ", "󰁹 "
			},
		}
		icon_index = math.floor(capacity / 10) + 1
		icon = battery_statuses[status][icon_index]
		battery.icon = icon -- .. battery_status
		battery.capacity = tostring(capacity) .. "% "
	end,
})

return battery
