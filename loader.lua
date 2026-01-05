local url = "https://raw.githubusercontent.com/huynekbay/Huy-AntiAFK/main/main.lua"

local success, err = pcall(function()
	loadstring(game:HttpGet(url))()
end)

if not success then
	warn("Huy Anti-AFK load failed:", err)
end

