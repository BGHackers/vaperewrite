local vape = {}
vape.version = "beta"

local TARGET_PLACE_ID = 71480482338212
local BASE_URL = "https://raw.githubusercontent.com/BGHackers/vaperewrite/refs/heads/main/"

function vape:Init()
    if game.PlaceId ~= TARGET_PLACE_ID then 
        return 
    end

    print("vape v4 beta loaded")

    local success, content = pcall(function()
        return game:HttpGet(BASE_URL .. "gui/Watermark.lua")
    end)

    if success then
        local func, err = loadstring(content)
        if func then
            local runSuccess, runErr = pcall(func)
            if not runSuccess then
                warn("Watermark.lua Runtime Error: " .. tostring(runErr))
            end
        else
            warn("Watermark.lua Syntax Error: " .. tostring(err))
        end
    else
        warn("Failed to fetch Watermark.lua: " .. tostring(content))
    end
end

vape:Init()