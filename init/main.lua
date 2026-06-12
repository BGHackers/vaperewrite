local vape = {}
vape.version = "beta"

-- テストするプレースID（※正しいPlaceIDか確認してください）
local TARGET_PLACE_ID = 71480482338212 
-- Raw URLの形式を修正
local BASE_URL = "https://raw.githubusercontent.com/BGHackers/vaperewrite/main/"

function vape:Init()
    -- デバッグ用：現在のPlaceIdを出力（IDが合っているか確認するため）
    print("Current PlaceId: " .. tostring(game.PlaceId))

    -- Place IDのチェック（合わない場合はここで終了）
    if game.PlaceId ~= TARGET_PLACE_ID then
        warn("PlaceId が一致しないため、Vapeのロードをスキップしました。")
        return
    end

    print("vape v4 beta loaded")

    -- Watermark.lua の読み込み
    local success, content = pcall(function()
        return game:HttpGet(BASE_URL .. "gui/Watermark.lua")
    end)

    if success then
        local func, err = loadstring(content)
        if func then
            local runSuccess, runErr = pcall(func)
            if not runSuccess then
                warn("Watermark.lua 実行エラー: " .. tostring(runErr))
            end
        else
            warn("Watermark.lua 構文（シンタックス）エラー: " .. tostring(err))
        end
    else
        warn("Watermark.lua の取得に失敗しました (404等): " .. tostring(content))
    end
end

vape:Init()