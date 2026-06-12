--

local hud = {}

local function getAsset(fileName, imageUrl)
    if not isfile(fileName) then
        local success, rawData = pcall(function()
            return game:HttpGet(imageUrl)
        end)
        
        if success and rawData then
            writefile(fileName, rawData)
        else
            return nil
        end
    end

    local customAsset = nil
    pcall(function()
        customAsset = getcustomasset(fileName)
    end)
    
    return customAsset
end

function hud:CreateWatermark()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VapeV4_Watermark"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame")
    Frame.Name = "WatermarkFrame"
    Frame.Size = UDim2.new(0, 180, 0, 30)
    Frame.Position = UDim2.new(0, 10, 0, 10)
    Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame.BorderSizePixel = 1
    Frame.BorderColor3 = Color3.fromRGB(35, 35, 35)
    Frame.Parent = ScreenGui

    local Logo = Instance.new("ImageLabel")
    Logo.Name = "WatermarkLogo"
    Logo.Size = UDim2.new(0, 20, 0, 20)
    Logo.Position = UDim2.new(0, 6, 0, 5)
    Logo.BackgroundTransparency = 1

    local logoUrl = "https://raw.githubusercontent.com/BGHackers/vapev4-rewrite/main/assets/logo.png"
    local assetId = getAsset("vape_logo.png", logoUrl)
    if assetId then
        Logo.Image = assetId
    end
    Logo.Parent = Frame

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -32, 1, 0)
    TextLabel.Position = UDim2.new(0, 32, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "vape v4 | " .. "beta"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 14
    TextLabel.Font = Enum.Font.SourceSansSemibold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame
end

hud:CreateWatermark()