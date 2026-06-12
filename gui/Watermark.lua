-- vape v4 project by Owner
-- Watermark Module (Auto Environment Detect & Asset Fix)

local hud = {}

-- 画像をダウンロード、またはRoblox公式アセットをフォールバックとして取得する関数
local function getAsset(fileName, imageUrl)
    -- 1. エクスプロイト（Executor）環境向けのファイル操作
    if writefile and isfile then
        if not isfile(fileName) then
            local success, rawData = pcall(function()
                return game:HttpGet(imageUrl)
            end)
            
            if success and rawData and not rawData:find("404: Not Found") then
                writefile(fileName, rawData)
            end
        end
        
        -- 保存したファイルをアセットに変換
        if isfile(fileName) then
            local customAsset = nil
            pcall(function()
                if getcustomasset then
                    customAsset = getcustomasset(fileName)
                elseif get_custom_asset then
                    customAsset = get_custom_asset(fileName)
                end
            end)
            if customAsset then
                return customAsset
            end
        end
    end
    
    -- 2. エクスプロイトが無い場合、またはダウンロードに失敗した場合は
    -- Roblox公式にアップロードされているVape v4ロゴのアセットIDをフォールバックとして使用します
    return "rbxassetid://13350877564"
end

function hud:CreateWatermark()
    -- 実行環境に応じてGUIの親を自動判別 (CoreGui または PlayerGui)
    local targetParent = nil
    
    local coreGuiSuccess, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    
    -- 通常のLocalScriptやStudioではCoreGuiの編集権限がないためPlayerGuiにする
    if coreGuiSuccess and coreGui and not game:GetService("RunService"):IsStudio() then
        pcall(function()
            -- CoreGuiへの書き込み権限テスト
            local test = Instance.new("Folder")
            test.Parent = coreGui
            test:Destroy()
            targetParent = coreGui
        end)
    end
    
    if not targetParent then
        local lp = game:GetService("Players").LocalPlayer
        if lp then
            targetParent = lp:WaitForChild("PlayerGui")
        end
    end
    
    if not targetParent then
        warn("VapeWatermark: 表示先（PlayerGui/CoreGui）が見つかりませんでした。")
        return
    end

    -- 重複防止のため、既存の同じウォーターマークがあれば削除
    if targetParent:FindFirstChild("VapeV4_Watermark") then
        targetParent["VapeV4_Watermark"]:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VapeV4_Watermark"
    ScreenGui.Parent = targetParent
    ScreenGui.ResetOnSpawn = false

    -- Main Frame (OLED Black)
    local Frame = Instance.new("Frame")
    Frame.Name = "WatermarkFrame"
    Frame.Size = UDim2.new(0, 160, 0, 30) -- 初期サイズ
    Frame.Position = UDim2.new(0, 10, 0, 10)
    Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame.BorderSizePixel = 1
    Frame.BorderColor3 = Color3.fromRGB(35, 35, 35)
    Frame.Parent = ScreenGui

    -- Logo ImageLabel
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "WatermarkLogo"
    Logo.Size = UDim2.new(0, 20, 0, 20)
    Logo.Position = UDim2.new(0, 6, 0, 5)
    Logo.BackgroundTransparency = 1
    
    -- ロゴ画像の取得
    local logoUrl = "https://raw.githubusercontent.com/BGHackers/vaperewrite/main/assets/logo.png"
    local assetId = getAsset("vape_logo.png", logoUrl)
    
    local textOffset = 8
    if assetId then
        Logo.Image = assetId
        Logo.Parent = Frame
        textOffset = 32 -- ロゴがある場合はテキストを右にずらす
    else
        -- 画像が一切取得できなかった場合
        Frame.Size = UDim2.new(0, 130, 0, 30)
    end

    -- Text Label
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -textOffset, 1, 0)
    TextLabel.Position = UDim2.new(0, textOffset, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "vape v4 | " .. "beta"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 14
    TextLabel.Font = Enum.Font.SourceSansSemibold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame
end

hud:CreateWatermark()