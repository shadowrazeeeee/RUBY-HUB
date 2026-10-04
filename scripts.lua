-- RUBY HUB (чистый Instance) — MM2
-- TG: @RubyHub_Script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ============ СОСТОЯНИЕ ============
local CONFIG = {
    PlayerOverlay = true, NameLabels = true, TracerEnabled = false,
    ShowHUD = true, ShowFPS = true, ShowPing = true,
    AutoGunCollect = false, HitboxExtender = false, HitboxSize = 25,
    SpeedGlitchEnabled = false, WallHopEnabled = false, WallHopSpeed = 60,
    AntiFling = false, FlingEnabled = false, FlingPower = 100,
    ChinaHat = false, FogEnabled = false, GhostEnabled = false,
    SeasonEnabled = false, CurrentSeason = "Winter", SnowEnabled = false,
    SkyboxEnabled = false, CurrentSkybox = "Galaxy",
    ShotSoundEnabled = true, HitSoundEnabled = true, KillSoundEnabled = true,
    FOV = 70, ScreenStretch = 70, Noclip = false, Walkspeed = 16,
    SelectedPlayers = {}
}

-- ============ GUI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RUBY_HUB_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 560, 0, 420)
mainFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(180, 25, 45)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 15, 22)
titleBar.BackgroundTransparency = 0.1
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "RUBY HUB"
titleLabel.TextColor3 = Color3.fromRGB(255, 90, 110)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(0, 150, 1, 0)
subtitleLabel.Position = UDim2.new(0.3, 0, 0, 0)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "TG: @RubyHub_Script"
subtitleLabel.TextColor3 = Color3.fromRGB(200, 160, 170)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -70, 0, 6)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(180, 25, 45)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minimizeBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 60)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

-- Табы (слева)
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(0, 140, 1, -50)
tabBar.Position = UDim2.new(0, 5, 0, 45)
tabBar.BackgroundColor3 = Color3.fromRGB(30, 15, 22)
tabBar.BackgroundTransparency = 0.3
tabBar.BorderSizePixel = 0
tabBar.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 10)
tabCorner.Parent = tabBar

local tabList = Instance.new("UIListLayout")
tabList.Padding = UDim.new(0, 4)
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Parent = tabBar

-- Контент (справа)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -155, 1, -50)
contentFrame.Position = UDim2.new(0, 150, 0, 45)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 22)
contentFrame.BackgroundTransparency = 0.3
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = contentFrame

local contentScroll = Instance.new("ScrollingFrame")
contentScroll.Size = UDim2.new(1, -10, 1, -10)
contentScroll.Position = UDim2.new(0, 5, 0, 5)
contentScroll.BackgroundTransparency = 1
contentScroll.BorderSizePixel = 0
contentScroll.ScrollBarThickness = 4
contentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
contentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
contentScroll.Parent = contentFrame

local contentList = Instance.new("UIListLayout")
contentList.Padding = UDim.new(0, 6)
contentList.Parent = contentScroll

-- ============ ФУНКЦИИ GUI ============
local tabContents = {}

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 20, 28)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 180, 190)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabBar
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, c in pairs(tabContents) do c.Visible = false end
        if tabContents[name] then tabContents[name].Visible = true end
        for _, b in pairs(tabBar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(45, 20, 28)
                b.TextColor3 = Color3.fromRGB(220, 180, 190)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(180, 25, 45)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return btn
end

local function createContent(name)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
    f.Parent = contentScroll
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.Parent = f
    
    tabContents[name] = f
    return f
end

local function createToggle(parent, text, default, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 36)
    row.BackgroundColor3 = Color3.fromRGB(40, 20, 28)
    row.BorderSizePixel = 0
    row.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 200, 210)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0.5, -10)
    toggle.BackgroundColor3 = default and Color3.fromRGB(180, 25, 45) or Color3.fromRGB(60, 30, 40)
    toggle.Text = ""
    toggle.Parent = row
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggle
    
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(180, 25, 45) or Color3.fromRGB(60, 30, 40)
        callback(state)
    end)
end

local function createSlider(parent, text, min, max, default, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 50)
    row.BackgroundColor3 = Color3.fromRGB(40, 20, 28)
    row.BorderSizePixel = 0
    row.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(230, 200, 210)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 6)
    sliderBg.Position = UDim2.new(0, 10, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 30, 40)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = row
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(180, 25, 45)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(0, 14, 0, 14)
    sliderBtn.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.Text = ""
    sliderBtn.Parent = sliderBg
    
    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(1, 0)
    sCorner.Parent = sliderBtn
    
    local dragging = false
    sliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local mouseX = input.Position.X
            local bgAbs = sliderBg.AbsolutePosition.X
            local bgSize = sliderBg.AbsoluteSize.X
            local percent = math.clamp((mouseX - bgAbs) / bgSize, 0, 1)
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            sliderBtn.Position = UDim2.new(percent, -7, 0.5, -7)
            local value = min + (max - min) * percent
            label.Text = text .. ": " .. math.floor(value)
            callback(value)
        end
    end)
end

local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(180, 25, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 60, 80)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(180, 25, 45)}):Play()
        callback()
    end)
end

-- ============ ТАБЫ ============
local tabNames = {"General", "MM2", "Visuals", "Players", "Fun", "Emotes", "Sound"}
for _, name in ipairs(tabNames) do
    createTab(name)
    createContent(name)
end
tabContents["General"].Visible = true

-- ============ GENERAL ============
local genTab = tabContents["General"]
createToggle(genTab, "Noclip", false, function(v) CONFIG.Noclip = v end)
createSlider(genTab, "Walkspeed", 8, 200, 16, function(v) CONFIG.Walkspeed = v end)
createSlider(genTab, "FOV", 50, 180, 70, function(v) CONFIG.FOV = v; Camera.FieldOfView = v end)
createSlider(genTab, "Screen Stretch", 70, 180, 70, function(v) CONFIG.ScreenStretch = v; Camera.FieldOfView = v end)
createToggle(genTab, "AntiFling", false, function(v) CONFIG.AntiFling = v end)
createToggle(genTab, "Fling", false, function(v) CONFIG.FlingEnabled = v end)
createSlider(genTab, "Fling Power", 10, 500, 100, function(v) CONFIG.FlingPower = v end)
createButton(genTab, "FPS Boost", function()
    settings().Rendering.QualityLevel = 1
    Lighting.GlobalShadows = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("BlurEffect") or obj:IsA("BloomEffect") or obj:IsA("SunRaysEffect") then
            obj.Enabled = false
        end
    end
    print("[RUBY HUB] FPS Boost включён.")
end)
createButton(genTab, "Get Ping", function()
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    print("[RUBY HUB] Ping: " .. math.floor(ping) .. " ms")
end)
createButton(genTab, "Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

-- ============ MM2 ============
local mm2Tab = tabContents["MM2"]
createToggle(mm2Tab, "Auto Gun Collect", false, function(v) CONFIG.AutoGunCollect = v end)
createToggle(mm2Tab, "Hitbox Extender", false, function(v) CONFIG.HitboxExtender = v end)
createSlider(mm2Tab, "Hitbox Size", 5, 50, 25, function(v) CONFIG.HitboxSize = v end)
createButton(mm2Tab, "Jump Bomb", function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local bomb = nil
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("bomb") or tool.Name:lower():find("grenade")) then
                bomb = tool
                break
            end
        end
    end
    if bomb then
        hum:EquipTool(bomb)
        task.wait(0.1)
        hum.Jump = true
        task.wait(0.05)
        bomb:Activate()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(hrp.Velocity.X, 80, hrp.Velocity.Z) end
    end
end)
createButton(mm2Tab, "Kill All", function()
    local count = 0
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                hum.Health = 0
                count = count + 1
            end
        end
    end
    print("[RUBY HUB] Убито: " .. count)
end)

-- ============ VISUALS ============
local visTab = tabContents["Visuals"]
createToggle(visTab, "Player Overlay", true, function(v) CONFIG.PlayerOverlay = v end)
createToggle(visTab, "Name Labels", true, function(v) CONFIG.NameLabels = v end)
createToggle(visTab, "Tracer", false, function(v) CONFIG.TracerEnabled = v end)
createToggle(visTab, "China Hat", false, function(v) CONFIG.ChinaHat = v end)
createToggle(visTab, "Cinematic Fog", false, function(v)
    CONFIG.FogEnabled = v
    if v then
        local fog = Lighting:FindFirstChild("RUBY_Fog") or Instance.new("Atmosphere", Lighting)
        fog.Name = "RUBY_Fog"
        fog.Density = 0.5
        fog.Haze = 3
        fog.Color = Color3.fromRGB(150, 150, 150)
    else
        local fog = Lighting:FindFirstChild("RUBY_Fog")
        if fog then fog:Destroy() end
    end
end)
createToggle(visTab, "Ghost", false, function(v) CONFIG.GhostEnabled = v end)
createToggle(visTab, "Season Atmosphere", false, function(v) CONFIG.SeasonEnabled = v end)
createToggle(visTab, "Snow", false, function(v) CONFIG.SnowEnabled = v end)
createToggle(visTab, "Skybox", false, function(v) CONFIG.SkyboxEnabled = v end)

-- ============ PLAYERS ============
local plTab = tabContents["Players"]
createButton(plTab, "Kill Selected", function()
    for p, sel in pairs(CONFIG.SelectedPlayers) do
        if sel and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = 0 end
        end
    end
end)
createButton(plTab, "Kill All", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = 0 end
        end
    end
end)

-- ============ FUN ============
local funTab = tabContents["Fun"]
createToggle(funTab, "Speed Glitch", false, function(v) CONFIG.SpeedGlitchEnabled = v end)
createToggle(funTab, "Wall Hop", false, function(v) CONFIG.WallHopEnabled = v end)
createSlider(funTab, "Wall Hop Speed", 20, 120, 60, function(v) CONFIG.WallHopSpeed = v end)

-- ============ EMOTES ============
local emTab = tabContents["Emotes"]
createButton(emTab, "Stop All Emotes", function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            for _, t in pairs(hum:GetPlayingAnimationTracks()) do t:Stop() end
        end
    end
end)

-- ============ SOUND ============
local sndTab = tabContents["Sound"]
createToggle(sndTab, "Shot Sound", true, function(v) CONFIG.ShotSoundEnabled = v end)
createToggle(sndTab, "Hit Sound", true, function(v) CONFIG.HitSoundEnabled = v end)
createToggle(sndTab, "Kill Sound", true, function(v) CONFIG.KillSoundEnabled = v end)

-- ============ SHOT BUTTON ============
local shotButton = Instance.new("TextButton")
shotButton.Size = UDim2.new(0, 110, 0, 110)
shotButton.Position = UDim2.new(1, -140, 1, -200)
shotButton.BackgroundColor3 = Color3.fromRGB(180, 25, 45)
shotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shotButton.Text = "SHOT"
shotButton.TextScaled = true
shotButton.Font = Enum.Font.GothamBlack
shotButton.Parent = ScreenGui
shotButton.Active = true
shotButton.Draggable = true

local shotCorner = Instance.new("UICorner")
shotCorner.CornerRadius = UDim.new(1, 0)
shotCorner.Parent = shotButton

local shotStroke = Instance.new("UIStroke")
shotStroke.Color = Color3.fromRGB(255, 120, 140)
shotStroke.Thickness = 2
shotStroke.Parent = shotButton

local function findMurderer()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            for _, tool in pairs(p.Character:GetChildren()) do
                if tool:IsA("Tool") and (tool.Name:lower():find("knife") or tool.Name:lower():find("sword")) then
                    return p
                end
            end
        end
    end
    return nil
end

shotButton.MouseButton1Down:Connect(function()
    local target = findMurderer()
    if target and target.Character then
        local hum = target.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
end)

-- ============ HUD ============
local hudGui = Instance.new("ScreenGui")
hudGui.Name = "RUBY_HUB_HUD"
hudGui.ResetOnSpawn = false
hudGui.IgnoreGuiInset = true
hudGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local hudFrame = Instance.new("Frame")
hudFrame.Size = UDim2.new(0, 220, 0, 30)
hudFrame.Position = UDim2.new(0, 10, 0, 10)
hudFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 18)
hudFrame.BackgroundTransparency = 0.3
hudFrame.BorderSizePixel = 0
hudFrame.Parent = hudGui

local hudCorner = Instance.new("UICorner")
hudCorner.CornerRadius = UDim.new(0, 8)
hudCorner.Parent = hudFrame

local hudStroke = Instance.new("UIStroke")
hudStroke.Color = Color3.fromRGB(180, 25, 45)
hudStroke.Thickness = 1.5
hudStroke.Parent = hudFrame

local hudLabel = Instance.new("TextLabel")
hudLabel.Size = UDim2.new(1, -10, 1, 0)
hudLabel.Position = UDim2.new(0, 5, 0, 0)
hudLabel.BackgroundTransparency = 1
hudLabel.Text = "RUBY HUB | FPS: 0 | PING: 0 ms"
hudLabel.TextColor3 = Color3.fromRGB(255, 230, 235)
hudLabel.TextScaled = true
hudLabel.Font = Enum.Font.GothamBold
hudLabel.Parent = hudFrame

local fpsCount, fpsTime, currentFPS, currentPing = 0, 0, 0, 0
RunService.RenderStepped:Connect(function(dt)
    fpsCount = fpsCount + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then
        currentFPS = fpsCount
        fpsCount = 0
        fpsTime = 0
    end
end)
spawn(function()
    while true do
        task.wait(0.5)
        local ok, ping = pcall(function()
            return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
        end)
        currentPing = ok and math.floor(ping) or 0
    end
end)
RunService.RenderStepped:Connect(function()
    hudLabel.Text = "RUBY HUB | FPS: " .. currentFPS .. " | PING: " .. currentPing .. " ms"
end)

-- ============ СВОРАЧИВАНИЕ + OPEN + КЛАВИАТУРА ============
local isMinimized = false

local minimizedFrame = Instance.new("Frame")
minimizedFrame.Size = UDim2.new(0, 180, 0, 90)
minimizedFrame.Position = UDim2.new(0, 20, 0.5, -45)
minimizedFrame.BackgroundColor3 = Color3.fromRGB(35, 15, 20)
minimizedFrame.BorderSizePixel = 0
minimizedFrame.Visible = false
minimizedFrame.Active = true
minimizedFrame.Draggable = true
minimizedFrame.Parent = ScreenGui

local minFCorner = Instance.new("UICorner")
minFCorner.CornerRadius = UDim.new(0, 16)
minFCorner.Parent = minimizedFrame

local minFStroke = Instance.new("UIStroke")
minFStroke.Color = Color3.fromRGB(200, 40, 60)
minFStroke.Thickness = 2
minFStroke.Parent = minimizedFrame

local minFLabel = Instance.new("TextLabel")
minFLabel.Size = UDim2.new(1, -10, 1, -10)
minFLabel.Position = UDim2.new(0, 5, 0, 5)
minFLabel.BackgroundTransparency = 1
minFLabel.Text = "RUBY\nHUB"
minFLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
minFLabel.TextScaled = true
minFLabel.Font = Enum.Font.GothamBlack
minFLabel.Parent = minimizedFrame

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 60, 0, 30)
openBtn.Position = UDim2.new(1, -65, 0, -35)
openBtn.BackgroundColor3 = Color3.fromRGB(180, 25, 45)
openBtn.Text = "OPEN"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextScaled = true
openBtn.Font = Enum.Font.GothamBold
openBtn.Visible = false
openBtn.Parent = minimizedFrame

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = openBtn

-- Виртуальная клавиатура
local virtualKeyboard = Instance.new("Frame")
virtualKeyboard.Size = UDim2.new(0, 300, 0, 200)
virtualKeyboard.Position = UDim2.new(0.5, -150, 0.5, -100)
virtualKeyboard.BackgroundColor3 = Color3.fromRGB(20, 15, 18)
virtualKeyboard.BorderSizePixel = 0
virtualKeyboard.Visible = false
virtualKeyboard.Parent = ScreenGui

local vkCorner = Instance.new("UICorner")
vkCorner.CornerRadius = UDim.new(0, 10)
vkCorner.Parent = virtualKeyboard

local vkStroke = Instance.new("UIStroke")
vkStroke.Color = Color3.fromRGB(180, 25, 45)
vkStroke.Thickness = 2
vkStroke.Parent = virtualKeyboard

local vkInput = Instance.new("TextBox")
vkInput.Size = UDim2.new(1, -20, 0, 36)
vkInput.Position = UDim2.new(0, 10, 0, 10)
vkInput.BackgroundColor3 = Color3.fromRGB(40, 20, 28)
vkInput.TextColor3 = Color3.fromRGB(255, 255, 255)
vkInput.PlaceholderText = "Введи текст..."
vkInput.Text = ""
vkInput.Font = Enum.Font.Gotham
vkInput.TextScaled = true
vkInput.Parent = virtualKeyboard

local vkInputCorner = Instance.new("UICorner")
vkInputCorner.CornerRadius = UDim.new(0, 6)
vkInputCorner.Parent = vkInput

local keys = {
    "1","2","3","4","5","6","7","8","9","0",
    "q","w","e","r","t","y","u","i","o","p",
    "a","s","d
