-- imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local icon = "<span font='14'> </span>"
local hdd = wibox.widget({
	{
		id = "capacitybox",
		markup = "",
		widget = wibox.widget.textbox,
	},
	widget = wibox.widget.textbox,
	layout = wibox.layout.align.horizontal,
	set_capacity = function(self, val)
		self.capacitybox.markup = val
	end,
})

gears.timer({
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async({ "sh", "-c", "df -h | awk '{ print $1\" \"$5}'" }, function(out)
			-- require("naughty").notify({ text = out })
			nvme_use = out:match("^.*nvme0n1p2%s([%d]*)%%") or ""
			ssd_use = out:match("^.*sda1%s([%d]*)%%") or ""
			-- require("naughty").notify({ text = ssd_use })
			hdd.capacity = icon .. nvme_use .. "% " .. icon .. ssd_use .. "%  "
		end)
	end,
})

return hdd
