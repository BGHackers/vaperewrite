-- vape v4 project by Owner
-- Watermark Module (Safe Fix)

local hud = {}

-- Helper function to fetch and cache external image safely
local function getAsset(fileName, imageUrl)
    -- Check if writefile and isfile exist
    if not writefile or not isfile then return nil end
    
    if not isfile(fileName) then
        local success, rawData = pcall(function()
            return game:HttpGet(imageUrl)
        end)
        
        if success and rawData and not rawData:find("404: Not Found") then
            writefile(fileName, rawData)
        else
            return nil
        end
    end
    
    -- Xeno custom asset support with safety pcall
    local customAsset = nil
    pcall(function()
        if getcustomasset then
            customAsset = getcustomasset(fileName)
        elseif get_custom_asset then
            customAsset = get_custom_asset(fileName)
        end
     pcall(function()
        if getcustomasset then
            customAsset = getcustomasset(fileName)
        elseif get_custom_asset then
            customAsset = get_custom_asset(fileName)
        end
    end)
    
    return customAsset
end

function hud:CreateWatermark()
    -- すでに同じGUIがあったら削除して重複を防ぐ
    if game:GetService("CoreGui"):FindFirstChild("VapeV4_Watermark") then
        game:GetService("CoreGui")["VapeV4_Watermark"]:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VapeV4_Watermark"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    -- Main Frame (OLED Black)
    local Frame = Instance.new("Frame")
    Frame.Name = "WatermarkFrame"
    Frame.Size = UDim2.new(0, 140, 0, 30) -- 画像がない場合でも崩れないサイズ
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
    
    -- Correct Github Raw URL for your repository
    local logoUrl = "https://raw.githubusercontent.com/BGHackers/vaperewrite/refs/heads/main/assets/logo.png"
    local assetId = getAsset("vape_logo.png", logoUrl)
    
    local textOffset = 8
    if assetId then
        Logo.Image = assetId
        Logo.Parent = Frame
        textOffset = 32
        Frame.Size = UDim2.new(0, 160, 0, 30) -- 画像がある場合は横幅を広げる
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