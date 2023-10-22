-- imports
local wibox = require("wibox")
local gears = require("gears")

--helper functions
--read from a file
-- Opens a file in read
local read_file_first_line = function(path)
	local loaded, file = pcall(io.open(path, "r"))

	if not loaded then
		return ""
	end

	file = io.open(path, "r")
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
	text = "󱉝 ",
	font = "14",
	widget = wibox.widget.textbox,
	set_battery = function(self, val)
		self.text = val
		-- self.textbar.text = tonumber(val)
		-- self.mypb.value = tonumber(val)
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
		-- /sys/class/power_supply/BAT1/capacity = 98
		-- /sys/class/power_supply/BAT1/status = Discharging | Charging | Full
		capacity = tonumber(read_file_first_line("/sys/class/power_supply/BAT1/capacity"))
		cord_connected = tonumber(read_file_first_line("/sys/class/power_supply/ACAD/online"))
		status = read_file_first_line("/sys/class/power_supply/BAT1/status"):lower()
		if capacity == nil then
			return
		end
		if status == "full" then
			if cord_connected then
				status = "charging"
			else
				status = "discharging"
			end
		end
		-- 10: 󰁺, 20: 󰁻, 30: 󰁼, 40: 󰁽, 50: 󰁾, 60: 󰁿, 70: 󰂀, 80: 󰂁, 90: 󰂂, 100: 󰁹
		-- 10: 󰢜, 20: 󰂆, 30: 󰂇, 40: 󰂈, 50: 󰢝, 60: 󰂉, 70: 󰢞, 80: 󰂊, 90: 󰂋, 100: 󰂅
		local battery_statuses = {
			charging = {
				"󰢟 ", "󰢜 ", "󰂆 ", "󰂇 ", "󰂈 ", "󰢝 ", "󰂉 ", "󰢞 ", "󰂊 ", "󰂋 ", "󰂅 "
			},
			discharging = {
				"󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"
			},
		}
		icon_index = math.floor(capacity / 10) + 1
		icon = battery_statuses[status][icon_index]
		-- battery_status = capacity
		battery.battery = icon -- .. battery_status
	end,
})

return battery
