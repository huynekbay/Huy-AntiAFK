--====================================
-- HUY ANTI-AFK | LOADER
--====================================

local BASE_URL = "https://raw.githubusercontent.com/huynekbay/Huy-AntiAFK/refs/heads/main/"
local VERSION_URL = BASE_URL .. "version.txt"
local MAIN_URL = BASE_URL .. "main.lua"

local function banner()
    print([[
██╗  ██╗██╗   ██╗██╗   ██╗
██║  ██║██║   ██║╚██╗ ██╔╝
███████║██║   ██║ ╚████╔╝ 
██╔══██║██║   ██║  ╚██╔╝  
██║  ██║╚██████╔╝   ██║   
╚═╝  ╚═╝ ╚═════╝    ╚═╝   
      HUY ANTI-AFK
]])
end

banner()

local localVersion = "1.0.0"
local success, onlineVersion = pcall(function()
    return game:HttpGet(VERSION_URL)
end)

if success and onlineVersion then
    onlineVersion = onlineVersion:gsub("%s+", "")
    if onlineVersion ~= localVersion then
        warn("🔄 Có phiên bản mới: " .. onlineVersion)
    else
        print("✅ Phiên bản mới nhất")
    end
else
    warn("⚠️ Không kiểm tra được version")
end

loadstring(game:HttpGet(MAIN_URL))()
