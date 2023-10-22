-- imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local icon = " "
local hdd = wibox.widget({
	{
		id = "capacitybox",
		text = "",
		widget = wibox.widget.textbox,
	},
	widget = wibox.widget.textbox,
	layout = wibox.layout.align.horizontal,
	set_capacity = function(self, val)
		self.capacitybox.text = val
	end,
})

gears.timer({
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async({ "sh", "-c", "df -h | awk '{ print $1\" \"$5}'" }, function(out)
			local result = ""

			nvme_use = out:match("^.*nvme0n1p2%s([%d]*)%%")
			if not nvme_use == nil then
				result = icon .. nvme_use .. "% "
			end

			ssd_use = out:match("^.*sda1%s([%d]*)%%")
			-- require("naughty").notify({ text = ssd_use })
			if not ssd_use == nil then
				result = result .. icon .. ssd_use .. "%  "
			end

			hdd.capacity = result
		end)
	end,
})

return hdd
