local app_map = {
	["1"] = "Alacritty",
	["2"] = "Google Chrome",
	["3"] = "Telegram",
	["4"] = "Slack",
	["5"] = "Spotify",
	["6"] = "Antigravity",
	["7"] = "OBS",
	["8"] = "Obsidian",
    ["9"] = "Things3",
}

for key, app_name in pairs(app_map) do
	hs.hotkey.bind({ "alt" }, key, function()
		hs.application.launchOrFocus(app_name)
	end)
end

hs.hotkey.bind({ "ctrl", "cmd" }, "C", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local max = screen:frame()

	local windowWidth = 1280
	local windowHeight = 800

	local f = win:frame()
	f.x = max.x + (max.w - windowWidth) / 2
	f.y = max.y + (max.h - windowHeight) / 2
	f.w = windowWidth
	f.h = windowHeight

	win:setFrame(f)
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "H", function()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local screenFrame = win:screen():frame()
	win:setFrame({
		x = screenFrame.x,
		y = screenFrame.y,
		w = screenFrame.w / 2,
		h = screenFrame.h,
	})
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "L", function()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local screenFrame = win:screen():frame()
	win:setFrame({
		x = screenFrame.x + screenFrame.w / 2,
		y = screenFrame.y,
		w = screenFrame.w / 2,
		h = screenFrame.h,
	})
end)
