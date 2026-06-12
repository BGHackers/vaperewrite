
local vape = {}
vape.version = "beta"

local TARGET_PLACE_ID = 71480482338212
local BASE_URL = "https://raw.githubusercontent.com/BGHackers/vapev4-rewrite/main/"

function vape:Init()
    if game.PlaceId ~= TARGET_PLACE_ID then 
        return 
    end

    print("vape v4 beta loaded")

    loadstring(game:HttpGet(BASE_URL .. "gui/Watermark.lua"))()
end

vape:Init()