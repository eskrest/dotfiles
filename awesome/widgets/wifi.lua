-- imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

--helper functions
--read from a file
-- Opens a file in read
local read_file_first_line = function(path)
	file = io.open(path, "r")
	-- sets the default input file as test.lua
	io.input(file)
	-- prints the first line of the file
	result = io.read()
	-- closes the open file
	io.close(file)
	return result
end

local log_table = function(t)
	os.execute("rm ~/awesomewm_log.txt")
	for i,v in pairs(t) do
		os.execute("echo " .. i .. " >> ~/awesomewm_log.txt")
	end
end

local known_networks = {}

-- icons
local wifi_on = "󰖩  "
local wifi_off = "󰖪  "

-- Create a widget and update its content using the output of a shell
-- command every 10 seconds:
local wifi_widget = wibox.widget({
	text = wifi_off,
	font = "14",
	widget = wibox.widget.textbox,
	set_wifi = function(self, val)
		self.text = val
	end,
})

local ssid_widget = wibox.widget({
	text = "no wifi info",
	widget = wibox.widget.textbox,
	set_wifi = function(self, val)
		self.text = val
	end,
})

local popup_widget = awful.popup {
	widget = ssid_widget,
	visible = false,
	ontop = true,
	type = "desktop",
}

wifi_widget:connect_signal("mouse::enter", function()
	popup_widget:move_next_to(mouse.current_widget_geometry)
	popup_widget.visible = true
end)

wifi_widget:connect_signal("mouse::leave", function()
	gears.timer.start_new(1, function()
		popup_widget.visible = false
		return false
	end)
end)

ssid_widget:connect_signal("mouse::enter", function()
	popup_widget.visible = true
end)

ssid_widget:connect_signal("button::press", function(c, _, _, button)
	require("naughty").notify({ text = "hui" })
end)

gears.timer({
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		-- You should read it from `/sys/class/power_supply/` (on Linux)
		-- instead of spawning a shell. This is only an example.
		-- iwctl station wlan0 show | grep Connected\ network | awk '{ print $3 }'
		-- awful.spawn.easy_async({ "sh", "-c", "acpi | sed -n 's/^.*, ([0-9]*)%/\1/p'" }, function(out)
		awful.spawn.easy_async({ "sh", "-c", "iwctl station wlan0 show" }, function(out)
			-- require("naughty").notify({ text = out })
			ssid = out:match("Connected network %s*([%w|%p]*)") or "N/A"

			-- create the known network
			-- list for the ssid widget text
			local networks = ""
			for network in pairs(known_networks) do
				if network == ssid then
					network = " 󱚽 " .. network .. " "
				else
					network = "   " .. network .. " "
				end
				if networks == "" then
					networks = network
				else
					networks = networks .. "\n" .. network
				end
			end
			ssid_widget.wifi = networks
			if ssid == "N/A" then
				wifi_widget.wifi = wifi_off
			else
				wifi_widget.wifi = wifi_on
			end
		end)

		awful.spawn.easy_async("iwctl known-networks list", function(out)
			known_networks = {}
			for line in out:gmatch("([^\n]*)\n?") do
				-- need to remove the table header from iwctl
				if not line:match("---") and not line:match("Known Networks") and not line:match("Name%s*Security") then
					local net = line:match("([%w|%p]*)%s*psk")
					if not net == nil then
						known_networks[net] = net
					end
				end
			end
			ssid = out:match("Connected network %s*([%w|%p]*)") or "N/A"
		end)
	end,
})

return wifi_widget
