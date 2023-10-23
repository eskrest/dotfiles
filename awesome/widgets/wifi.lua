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
	for i, v in pairs(t) do
		os.execute("echo " .. i .. " >> ~/awesomewm_log.txt")
	end
end

local known_networks = {}
local networks = ""

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

local popup_widget = awful.popup({
	widget = ssid_widget,
	visible = false,
	ontop = true,
	type = "desktop",
})

-- wifi_widget:connect_signal("mouse::enter", function()
-- 	popup_widget:move_next_to(mouse.current_widget_geometry)
-- 	popup_widget.visible = true
-- end)
--
-- wifi_widget:connect_signal("mouse::leave", function()
-- 	gears.timer.start_new(1, function()
-- 		popup_widget.visible = false
-- 		return false
-- 	end)
-- end)

local connect_widget = wibox.widget({
	text = "",
	widget = wibox.widget.textbox,
	set_wifi = function(self, val)
		self.text = val
	end,
})

local prompt_widget = awful.popup({
	widget = connect_widget,
	visible = false,
	ontop = true,
	type = "dock",
	shape = gears.shape.rounded_rect,
	border_color = "#222222",
	border_width = 10,
})

-- Create a shortcut function
local function select_network()
	awful.prompt.run({
		prompt = networks .. "\nConnect to: ",
		text = "1",
		bg_cursor = "#ffa15d",
		-- To use the default rc.lua prompt:
		-- textbox      = mouse.screen.mypromptbox.widget,
		textbox = connect_widget,
		exe_callback = function(input)
			if not input or #input == 0 then
				return
			end
			awful.spawn.with_shell("iwctl station wlan0 connect '" .. known_networks[tonumber(input)] .. "'")
		end,
		done_callback = function()
			prompt_widget.visible = false
		end,
	})
end

local update = function()
	-- You should read it from `/sys/class/power_supply/` (on Linux)
	-- instead of spawning a shell. This is only an example.
	-- iwctl station wlan0 show | grep Connected\ network | awk '{ print $3 }'
	-- awful.spawn.easy_async({ "sh", "-c", "acpi | sed -n 's/^.*, ([0-9]*)%/\1/p'" }, function(out)
	awful.spawn.easy_async({ "sh", "-c", "iwctl station wlan0 show" }, function(out)
		networks = ""
		-- require("naughty").notify({ text = out })
		ssid = out:match("Connected network %s*([%w|%p|%s]*)%c%s*IPv4") or "N/A"
		ssid = ssid:gsub("%s*$", "")

		-- create the known network
		-- list for the ssid widget text
		for index, network in pairs(known_networks) do
			-- require("naughty").notify({ text = tostring(index) })
			if network == ssid then
				network = " 󱚽 " .. " " .. index .. ". " .. network .. " "
			else
				network = "   " .. " " .. index .. ". " .. network .. " "
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

	awful.spawn.with_shell("iwctl station wlan0 scan")

	awful.spawn.easy_async("iwctl station wlan0 get-networks", function(out)
		known_networks = {}
		local index = 0
		for line in out:gmatch("([^\n]*)\n?") do
			-- require("naughty").notify({ text = tostring(index) })
			-- need to remove the table header from iwctl
			if
				not line:match("---")
				and not line:match("Available networks")
				and not line:match("Network name%s*Security")
			then
				local net = line:match("%[?0?m?%s*([%w|%p%s]*)%s*psk")
				net = net:gsub("%s*$", "")
				index = index + 1
				known_networks[index] = net
			end
		end
		ssid = out:match("Connected network %s*([%w|%p]*)") or "N/A"
	end)
end

wifi_widget:connect_signal("button::press", function(c, _, _, button)
	if not button == 1 then return end
	if networks == "" then return end
	update()
	select_network()
	prompt_widget:move_next_to(mouse.current_widget_geometry)
	prompt_widget.visible = true
end)

-- ssid_widget:connect_signal("mouse::enter", function()
-- 	popup_widget.visible = true
-- end)

gears.timer({
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		-- require("naughty").notify({ text = tostring(prompt_widget.visible) })
		if not prompt_widget.visible then
			update()
		end
	end,
})

return wifi_widget
