-- imports
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local widget = {}
local timer = nil
local color_on = "#ffffffff"
local color_off = "#ffffff77"

local icons = {
	"󰪛 ", -- capslock
	"󰼏  ", -- numlock
	-- "scroll ", -- scrolllock
}

local caps_on = "<span fgcolor='" .. color_on .. "'>" .. icons[1] .. "</span>"
local caps_off = "<span fgcolor='" .. color_off .. "'>" .. icons[1] .. "</span>"
local num_on = "<span fgcolor='" .. color_on .. "'>" .. icons[2] .. "</span>"
local num_off = "<span fgcolor='".. color_off .. "'>" .. icons[2] .. "</span>"

local numlock_widget = wibox.widget({
	{
		id = "caps_icon",
		markup = icons[1],
		font = "14",
		widget = wibox.widget.textbox,
	},
	{
		id = "num_icon",
		markup = icons[2],
		font = "14",
		widget = wibox.widget.textbox,
	},
	widget = wibox.widget.textbox,
	layout = wibox.layout.align.horizontal,
	set_caps = function(self, val)
		-- naughty.notify({ text = val })
		if val == "on" then
			self.caps_icon.markup = caps_on
		else
			self.caps_icon.markup = caps_off
		end
	end,
	set_num = function(self, val)
		-- naughty.notify({ text = val })
		if val == "on" then
			self.num_icon.markup = num_on
		else
			self.num_icon.markup = num_off
		end
	end,
})

widget.widget = numlock_widget

local get_status = function(callback)
	-- $4 - numlock
	-- $8 - capslock
	-- $12 - scrolllock
	awful.spawn.easy_async({"sh", "-c", "xset q | grep Caps | awk '{ print $4\" \"$8\" \"$12 }'"}, function(out)
		-- naughty.notify({ text = out })
		callback(out)
	end)
end

local update = function()

	local callback = function(status)
		local capslock = status:match("(%a*)%s%a*%s%a*")
		local numlock = status:match("%a*%s(%a*)%s%a*")
		-- local scrolllock = status:match("%a*%s%a*%s(%a*)")
		-- numlock_widget.brightness = tostring(math.floor(brightness_x10 * 10)) .. "%  "
		numlock_widget.caps = capslock
		numlock_widget.num = numlock
	end
	get_status(callback)

end
widget.update = update

local toggle_caps = function()
	-- naughty.notify({ text = "toggle caps" })
	local caps_state = numlock_widget.caps_icon.markup
	-- naughty.notify({ text = color_on })
	if caps_state:match(color_on) then
		-- naughty.notify({ text = color_on })
		numlock_widget.caps = "off"
	else
		-- naughty.notify({ text = color_off })
		numlock_widget.caps = "on"
	end
end
widget.toggle_caps = toggle_caps

local toggle_num = function()
	local num_state = numlock_widget.num_icon.markup
	if num_state:match(color_on) then
		-- naughty.notify({ text = "off" })
		numlock_widget.num = "off"
	else
		-- naughty.notify({ text = "on" })
		numlock_widget.num = "on"
	end
end
widget.toggle_num = toggle_num

timer = gears.timer({
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		update()
	end,
})

return widget
