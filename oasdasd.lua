-- ป้องกัน UI ซ้อน/บัค: ลบ ScreenGui เดิมถ้ามี
pcall(function()
    local cg = game:GetService("CoreGui")
    local old = cg:FindFirstChild("BEEBEEHUB")
    if old then old:Destroy() end
end)
-- BEE BEE HUB V5.0
-- Developed by BEE BEE - ผู้พัฒนาต่อจากGPTคนไทยNo.1
-- Enhanced UI with smooth animations and modern design

-- Services
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local vim = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local spawnRemote = nil
pcall(function() spawnRemote = ReplicatedStorage:WaitForChild("Connections"):WaitForChild("Spawn") end)

-- GUI Setup (BEE BEE V5.0)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BEEBEEHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400) -- ลดขนาดเล็กน้อย
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,30) -- สีเรียบง่าย
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Enhanced corner radius and gradient effect
local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Add subtle border effect
local border = Instance.new("UIStroke", MainFrame)
border.Color = Color3.fromRGB(100, 200, 255)
border.Thickness = 2
border.Transparency = 0.3

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, -60, 0, 35)
Header.Position = UDim2.new(0, 15, 0, 0)
Header.BackgroundTransparency = 1
Header.Text = "🐝 BEE BEE HUB"
Header.Font = Enum.Font.GothamBold
Header.TextSize = 20
Header.TextColor3 = Color3.fromRGB(255, 215, 0)
Header.TextXAlignment = Enum.TextXAlignment.Left

-- Add subtitle - Simplified for mobile
local Subtitle = Instance.new("TextLabel", MainFrame)
Subtitle.Size = UDim2.new(1, -60, 0, 20)
Subtitle.Position = UDim2.new(0, 15, 0, 25)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "By.bee bee - Mobile Friendly"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 12
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Time in this Server (Header Center)
local ServerTimeLabel = Instance.new("TextLabel", MainFrame)
ServerTimeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ServerTimeLabel.Position = UDim2.new(0.5, 0, 0, 15) -- ชิดกลางแน่นอน
ServerTimeLabel.Size = UDim2.new(0, 200, 0, 20)
ServerTimeLabel.BackgroundTransparency = 1
ServerTimeLabel.Font = Enum.Font.GothamBold
ServerTimeLabel.TextSize = 14
ServerTimeLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
ServerTimeLabel.TextXAlignment = Enum.TextXAlignment.Center
ServerTimeLabel.TextYAlignment = Enum.TextYAlignment.Center
ServerTimeLabel.Text = "Time: 00:00:00"

-- Update Timer
task.spawn(function()
    while task.wait(1) do
        if getgenv().ServerJoinTime then
            local elapsed = os.time() - getgenv().ServerJoinTime
            local h = math.floor(elapsed/3600)
            local m = math.floor((elapsed%3600)/60)
            local s = elapsed % 60
            ServerTimeLabel.Text = string.format("Time in Server: %02d:%02d:%02d", h,m,s)
        end
    end
end)

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -70, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MinBtn.Text = "−"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "×"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 90, 1, -50) -- ลดความกว้าง
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(25,25,40) -- สีเรียบง่าย
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,8)

-- Add subtle gradient effect to sidebar
local sidebarStroke = Instance.new("UIStroke", Sidebar)
sidebarStroke.Color = Color3.fromRGB(60, 60, 80)
sidebarStroke.Thickness = 1
sidebarStroke.Transparency = 0.5

local Content = Instance.new("ScrollingFrame", MainFrame)
Content.Size = UDim2.new(1, -100, 1, -60) -- ปรับตาม sidebar ใหม่
Content.Position = UDim2.new(0, 95, 0, 55)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 8
Content.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
local layout = Instance.new("UIListLayout", Content)
layout.Padding = UDim.new(0,8)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Minimize/Close with smooth animation
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Sidebar.Visible = not minimized
    Subtitle.Visible = not minimized
    
    -- Smooth animation - ปรับตามขนาดใหม่
    local targetSize = minimized and UDim2.new(0, 400, 0, 50) or UDim2.new(0, 500, 0, 400)
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize})
    tween:Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Enhanced Sidebar buttons with hover effects

local distance = 8         -- ระยะจากเราไป "จุดล็อก" ด้านหน้า (ครั้งที่กด Set Spot)
local yOffset = 0          -- ยกขึ้น/ลงจากระดับ HRP
local refreshInterval = 0.2
local stackJitter = 0      -- 0 = กองทับจุดเดียวเป๊ะ (ถ้ากระพริบ ให้ลอง 0.1)

_G.ComboEnabled = false    -- Farm Mode
_G.LockCFrame = nil        -- จุดล็อก (world CFrame), จะถูกกำหนดตอนกด ON หรือกด Set Spot

--// ====== รายชื่อมอน ======
local thugNames = {
    ["Lv11 Boar"]=true,["Lv12 Boar"]=true,["Lv12 Thug"]=true,
    ["Lv13 Bandit"]=true,["Lv13 Boar"]=true,["Lv14 Bandit"]=true,["Lv14 Boar"]=true,
    ["Lv15 Bandit"]=true,["Lv15 Boar"]=true,["Lv15 Thug"]=true,["Lv16 Boar"]=true,
    ["Lv16 Thug"]=true,["Lv17 Thug"]=true,["Lv186 Cave Demon"]=true,["Lv188 Cave Demon"]=true,
    ["Lv19 Thief"]=true,["Lv198 Cave Demon"]=true,["Lv2 Angry Bob"]=true,["Lv20 Thief"]=true,
    ["Lv200 Vokun"]=true,["Lv21 Thief"]=true,["Lv219 Cave Demon"]=true,["Lv22 Angry Bobby"]=true,
    ["Lv22 Thief"]=true,["Lv22 Thug"]=true,["Lv23 Thug"]=true,["Lv24 Angry Bobbi"]=true,
    ["Lv24 Fred"]=true,["Lv24 Thug"]=true,["Lv25 Thug"]=true,["Lv26 Thug"]=true,
        
    ["Lv28 Fredde"]=true,["Lv28 Freyd"]=true,["Lv28 Friedrich"]=true,["Lv29 Angry Bobber"]=true,
    ["Lv29 Frued"]=true,["Lv30 Thief"]=true,["Lv30 Thug"]=true,
    ["Lv31 Thief"]=true,["Lv32 Fredric"]=true,["Lv32 Thief"]=true,["Lv34 Freddi"]=true,
    ["Lv35 Angry Bobb"]=true,["Lv4 Boar"]=true,["Lv4 Freddy"]=true,
    ["Lv40 Cave Demon"]=true,["Lv40 Thug"]=true,["Lv9 Bandit"]=true,
}

--// ====== ดึงมอนให้ "ค้างจุดเดียว" ======
local function pullToLockedPoint()
    if not _G.LockCFrame then return end
    local enemiesFolder = workspace:FindFirstChild("Enemies")
    if not enemiesFolder then return end

    local i = 0
    for name in pairs(thugNames) do
        local enemy = enemiesFolder:FindFirstChild(name)
        if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
            i += 1
            local eHRP = enemy.HumanoidRootPart
            local hum = enemy.Humanoid

            -- จุดเดียวเป๊ะ + (ออปชัน) ขยับนิดเดียวกันซ้อนหนัก
            local jx = ((i % 3) - 1) * stackJitter
            local jz = math.floor(i / 3) * (stackJitter * 0.2)
            eHRP.CFrame = _G.LockCFrame * CFrame.new(jx, 0, -jz)

            eHRP.Anchored = true
            hum.PlatformStand = true
        end
    end
end

-- ลูปทำงานเมื่อเปิดโหมด
task.spawn(function()
    while task.wait(refreshInterval) do
        if _G.ComboEnabled then
            pullToLockedPoint()
        end
    end
end)

-- NoClip ระหว่างเปิดโหมด (ปิดก็คืนค่า)
RunService.Stepped:Connect(function()
    if not _G.ComboEnabled then return end
    local char = player.Character
    if not char then return end
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

-- รีสปาวน์: sync NoClip ให้ตรงสถานะ
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart", 10)
    task.delay(0.1, function()
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not _G.ComboEnabled
            end
        end
    end)
end)
local function CreateSidebarButton(text, yPos)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(1, -10, 0, 40) -- เพิ่มความสูง
    Btn.Position = UDim2.new(0, 5, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12 -- ลดขนาดตัวอักษรเล็กน้อย
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner", Btn)
    corner.CornerRadius = UDim.new(0,6)
    
    -- ลบ hover effects เพื่อความเรียบง่าย
    return Btn
end

local MainBtn      = CreateSidebarButton("🏠 Main", 10)
local WeaponBtn    = CreateSidebarButton("⚔️ Weapon", 50)
local PlayerBtn    = CreateSidebarButton("👥 Player", 90)
local DevilFruitBtn= CreateSidebarButton("🍎 DevilFruit", 130)
local MiscBtn      = CreateSidebarButton("⚙️ Misc", 170)
local DrinkBtn     = CreateSidebarButton("🥤 Drink", 210)
local TeleportBtn  = CreateSidebarButton("🚀 Teleport", 250)
local ServerBtn    = CreateSidebarButton("🌐 Server", 290)

-- Utility
local function ClearContent()
    for _,c in pairs(Content:GetChildren()) do
        if not c:IsA("UIListLayout") then c:Destroy() end
    end
end

-- Format helper
local function formatVal(v)
    if type(v) ~= "number" then return tostring(v) end
    if v < 1 then
        return string.format("%.2f", v)
    else
        return tostring(v)
    end
end

-- Simplified button creation function for mobile
local function CreateModernButton(parent, text, color, size)
    local btn = Instance.new("TextButton", parent)
    btn.Size = size or UDim2.new(1, -20, 0, 40) -- เพิ่มความสูงสำหรับมือถือ
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 80)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16 -- เพิ่มขนาดตัวอักษร
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 10) -- มุมโค้งมากขึ้น
    
    -- ลบ border และ hover effects เพื่อความเรียบง่าย
    return btn
end

-- Step Slider helper (copied from 4.2.2 / 4.3)
local function CreateStepSlider(parent, yPos, steps, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -20, 0, 40)
    Frame.Position = UDim2.new(0, 10, 0, yPos)
    Frame.BackgroundTransparency = 1

    local SliderBack = Instance.new("Frame", Frame)
    SliderBack.Size = UDim2.new(1, -120, 0, 8)
    SliderBack.Position = UDim2.new(0, 10, 0.5, -4)
    SliderBack.BackgroundColor3 = Color3.fromRGB(60,60,60)
    SliderBack.BorderSizePixel = 0
    Instance.new("UICorner", SliderBack).CornerRadius = UDim.new(0,4)

    local Fill = Instance.new("Frame", SliderBack)
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0,170,0)
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(0,4)

    local Knob = Instance.new("Frame", SliderBack)
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local ValueLabel = Instance.new("TextLabel", Frame)
    ValueLabel.Size = UDim2.new(0, 100, 1, 0)
    ValueLabel.Position = UDim2.new(1, -105, 0, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = formatVal(default)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 12
    ValueLabel.TextColor3 = Color3.fromRGB(255,255,255)

    local function setIndex(idx)
        if idx < 1 then idx = 1 end
        if idx > #steps then idx = #steps end
        local rel = 0
        if #steps > 1 then
            rel = (idx-1)/(#steps-1)
        end
        Fill.Size = UDim2.new(rel, 0, 1, 0)
        Knob.Position = UDim2.new(rel, -6, 0.5, -6)
        ValueLabel.Text = formatVal(steps[idx])
        callback(steps[idx], idx)
    end

    local startIdx = 1
    for i,v in ipairs(steps) do if v == default then startIdx = i break end end
    setIndex(startIdx)

    local dragging = false
    local function updateFromInput(inputPosX)
        local rel = math.clamp((inputPosX - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
        local idx = math.floor(rel * (#steps-1) + 0.5) + 1
        if idx < 1 then idx = 1 end
        if idx > #steps then idx = #steps end
        setIndex(idx)
    end

    Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    SliderBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateFromInput(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateFromInput(input.Position.X)
        end
    end)

    return Frame
end

-- States (merged)
local States = {
    AutoClick = {Enabled=false, Delay=0.1},
    AutoRespawn = {Enabled=false, Delay=2},
    AutoEquip = {Enabled=false, Weapon=nil},
    AntiAFK = {Enabled=false},
    AutoTP = false,
    AutoToSafeZone = false,
    Theme = "Dark",
    Misc = {
        Noclip = false,
        ClickTP = false,
        HipHeightEnabled = false,
        HipHeight = 2,
        WalkSpeedEnabled = false,
        WalkSpeed = 16,
        JumpEnabled = false,
        JumpPower = 50,
        FlightEnabled = false,
        FlightSpeed = 200,
        HideNames = false
    },
    Fruit = { -- 👈 เพิ่ม block นี้เข้าไป
        AutoBarrel = false,
        BarrelDelay = 0.1
    }
}


-- SafeZone creation (from 4.2.2)
local safeZone = workspace:FindFirstChild("PrivateFarmZone")
if not safeZone then
    safeZone = Instance.new("Part")
    safeZone.Size = Vector3.new(80, 2, 80)
    safeZone.Position = Vector3.new(50000, 5000, 50000)
    safeZone.Anchored = true
    safeZone.Transparency = 0.3
    safeZone.BrickColor = BrickColor.new("Bright green")
    safeZone.Name = "PrivateFarmZone"
    safeZone.Parent = workspace
end
local SafeZoneCFrame = CFrame.new(safeZone.Position + Vector3.new(0,5,0))

-- Auto respawn helper (from 4.2.2)
local function setupAutoRespawn(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        if States.AutoRespawn.Enabled then
            task.wait(States.AutoRespawn.Delay)
            local ok, userData = pcall(function()
                return workspace:WaitForChild("UserData"):WaitForChild("User_" .. player.UserId)
            end)
            if ok and userData then
                local spawnNumber = userData:FindFirstChild("Data") and userData.Data:FindFirstChild("SpawnNumber")
                if spawnNumber and spawnRemote then
                    spawnRemote:FireServer(spawnNumber.Value)
                else
                end
            else
            end
        end
    end)
end
player.CharacterAdded:Connect(setupAutoRespawn)
if player.Character then setupAutoRespawn(player.Character) end

-- Global connections (to manage repeated connections)
local flightConnection = nil
local noclipConnection = nil
local autoTPConnection = nil
local autoToSafeZoneConnection = nil
local posLabelRef = nil

-- Mouse for ClickTP
local mouse = player:GetMouse()

-- =====================================================
-- MAIN TAB (FULL)
-- =====================================================
local function LoadMainTab()
    ClearContent()

    -- ===================== MUSIC PLAYER =====================
    local musicLabel = Instance.new("TextLabel", Content)
    musicLabel.Size = UDim2.new(1, -20, 0, 24)
    musicLabel.Position = UDim2.new(0, 0, 0, 0)
    musicLabel.BackgroundTransparency = 1
    musicLabel.Text = "🎵 Music Player (ใส่ลิ้งเพลง Roblox หรือ Asset ID)"
    musicLabel.Font = Enum.Font.GothamBold
    musicLabel.TextSize = 14
    musicLabel.TextColor3 = Color3.fromRGB(255,255,200)

    local musicBox = Instance.new("TextBox", Content)
    musicBox.Size = UDim2.new(1, -20, 0, 32)
    musicBox.Position = UDim2.new(0, 0, 0, 28)
    musicBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    musicBox.TextColor3 = Color3.fromRGB(255,255,255)
    musicBox.Font = Enum.Font.Gotham
    musicBox.TextSize = 15
    musicBox.PlaceholderText = "Asset ID หรือ https://www.roblox.com/library/xxxx..."
    musicBox.Text = ""
    Instance.new("UICorner", musicBox).CornerRadius = UDim.new(0,8)

    local playBtn = Instance.new("TextButton", Content)
    playBtn.Size = UDim2.new(1, -20, 0, 32)
    playBtn.Position = UDim2.new(0, 0, 0, 68)
    playBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
    playBtn.TextColor3 = Color3.fromRGB(255,255,255)
    playBtn.Font = Enum.Font.GothamBold
    playBtn.TextSize = 15
    playBtn.Text = "▶️ Play Music"
    Instance.new("UICorner", playBtn).CornerRadius = UDim.new(0,8)

    local stopBtn = Instance.new("TextButton", Content)
    stopBtn.Size = UDim2.new(1, -20, 0, 32)
    stopBtn.Position = UDim2.new(0, 0, 0, 108)
    stopBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    stopBtn.TextColor3 = Color3.fromRGB(255,255,255)
    stopBtn.Font = Enum.Font.GothamBold
    stopBtn.TextSize = 15
    stopBtn.Text = "⏹️ Stop Music"
    Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0,8)

    local sound = nil

    local function parseAssetId(text)
        if tonumber(text) then return tonumber(text) end
        local id = string.match(text, "/library/(%d+)") or string.match(text, "id=(%d+)")
        return id and tonumber(id) or nil
    end

    playBtn.MouseButton1Click:Connect(function()
        local assetId = parseAssetId(musicBox.Text)
        if not assetId then
            playBtn.Text = "❌ Asset ID ไม่ถูกต้อง"
            wait(1.2)
            playBtn.Text = "▶️ Play Music"
            return
        end
        if sound then sound:Destroy() sound = nil end
        sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://"..assetId
        sound.Volume = 1
        sound.Looped = true
        sound.Parent = game:GetService("SoundService")
        sound:Play()
        playBtn.Text = "▶️ Playing..."
    end)

    stopBtn.MouseButton1Click:Connect(function()
        if sound then sound:Destroy() sound = nil end
        stopBtn.Text = "⏹️ Stopped"
        wait(1.2)
        stopBtn.Text = "⏹️ Stop Music"
    end)

-----------------------------------------------------------------
-- AUTO CLICK
----------------------------------------------------------------
local autoClickThread = nil

-- ปุ่ม AutoClick with modern styling
local AutoClickBtn = CreateModernButton(Content, "🖱️ AutoClick: "..(States.AutoClick.Enabled and "ON" or "OFF"), 
    States.AutoClick.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0))

AutoClickBtn.MouseButton1Click:Connect(function()
    States.AutoClick.Enabled = not States.AutoClick.Enabled
    AutoClickBtn.BackgroundColor3 = States.AutoClick.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    AutoClickBtn.Text = "🖱️ AutoClick: "..(States.AutoClick.Enabled and "ON" or "OFF")

    if States.AutoClick.Enabled then
        -- ถ้ามี thread เดิมให้หยุดก่อน
        if autoClickThread then
            task.cancel(autoClickThread)
            autoClickThread = nil
        end
        autoClickThread = task.spawn(function()
            while States.AutoClick.Enabled do
                pcall(function()
                    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait(0.01)
                    VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                end)
                task.wait(States.AutoClick.Delay or 0.1)
            end
        end)
    else
        if autoClickThread then
            task.cancel(autoClickThread)
            autoClickThread = nil
        end
    end
end)

-- ✅ Slider สำหรับ AutoClick Delay
CreateStepSlider(Content, 0, {0.01,0.05,0.1,0.2,0.5}, States.AutoClick.Delay or 0.1, function(v)
    States.AutoClick.Delay = v
end)

    -----------------------------------------------------------------
    -- AUTO RESPAWN
    -----------------------------------------------------------------
    local function StartAutoRespawn()
        if autoRespawnConn then autoRespawnConn:Disconnect() end

        autoRespawnConn = player.CharacterAdded:Connect(function(char)
            local hum = char:WaitForChild("Humanoid", 5)
            if hum then
                hum.Died:Connect(function()
                    if States.AutoRespawn.Enabled then
                        task.wait(States.AutoRespawn.Delay or 3)
                        pcall(function()
                            local spawnEvent = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Spawn")
                            if spawnEvent then
                                spawnEvent:FireServer()
                            else
                                player:LoadCharacter()
                            end
                        end)
                    end
                end)
            end
        end)
    end

    local RespawnBtn = CreateModernButton(Content, "🔄 AutoRespawn: "..(States.AutoRespawn.Enabled and "ON" or "OFF"), 
        States.AutoRespawn.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0))

    RespawnBtn.MouseButton1Click:Connect(function()
        States.AutoRespawn.Enabled = not States.AutoRespawn.Enabled
        RespawnBtn.BackgroundColor3 = States.AutoRespawn.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        RespawnBtn.Text = "🔄 AutoRespawn: "..(States.AutoRespawn.Enabled and "ON" or "OFF")

        if States.AutoRespawn.Enabled then
            StartAutoRespawn()
        end
    end)

    -- ปุ่ม Delay Respawn (วนค่า)
    local respawnDelaySteps = {2,3,4,5}
    local respawnDelayIndex = table.find(respawnDelaySteps, States.AutoRespawn.Delay) or 2
    States.AutoRespawn.Delay = respawnDelaySteps[respawnDelayIndex]

    local RespawnDelayBtn = CreateModernButton(Content, "⏱️ Respawn Delay: "..States.AutoRespawn.Delay.."s", Color3.fromRGB(120,120,120))

    RespawnDelayBtn.MouseButton1Click:Connect(function()
        respawnDelayIndex = respawnDelayIndex % #respawnDelaySteps + 1
        States.AutoRespawn.Delay = respawnDelaySteps[respawnDelayIndex]
        RespawnDelayBtn.Text = "⏱️ Respawn Delay: "..States.AutoRespawn.Delay.."s"
    end)

    if States.AutoRespawn.Enabled then
        StartAutoRespawn()
    end

    -----------------------------------------------------------------
    -- ANTI AFK
    -----------------------------------------------------------------
    local AntiAFKBtn = CreateModernButton(Content, "🚫 AntiAFK: "..(States.AntiAFK.Enabled and "ON" or "OFF"), 
        States.AntiAFK.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0))

    AntiAFKBtn.MouseButton1Click:Connect(function()
        States.AntiAFK.Enabled = not States.AntiAFK.Enabled
        AntiAFKBtn.BackgroundColor3 = States.AntiAFK.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        AntiAFKBtn.Text = "🚫 AntiAFK: "..(States.AntiAFK.Enabled and "ON" or "OFF")

        if States.AntiAFK.Enabled then
            task.spawn(function()
                while States.AntiAFK.Enabled do
                    task.wait(600)
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end)
        end
    end)

    -----------------------------------------------------------------
    -- AUTO TO SAFE ZONE
    -----------------------------------------------------------------
    local AutoSafeBtn = CreateModernButton(Content, "🛡️ Auto To Safe Zone (Hold): "..(States.AutoTP and "ON" or "OFF"), 
        States.AutoTP and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0))

    AutoSafeBtn.MouseButton1Click:Connect(function()
        States.AutoTP = not States.AutoTP
        AutoSafeBtn.BackgroundColor3 = States.AutoTP and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        AutoSafeBtn.Text = "🛡️ Auto To Safe Zone (Hold): "..(States.AutoTP and "ON" or "OFF")

        if States.AutoTP then
            if autoTPConnection then autoTPConnection:Disconnect(); autoTPConnection = nil end
            autoTPConnection = RunService.Heartbeat:Connect(function()
                if not States.AutoTP then
                    if autoTPConnection then autoTPConnection:Disconnect(); autoTPConnection = nil end
                    return
                end
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        player.Character.HumanoidRootPart.CFrame = SafeZoneCFrame
                    end)
                end
            end)
        else
            if autoTPConnection then autoTPConnection:Disconnect(); autoTPConnection = nil end
        end
    end)

    -----------------------------------------------------------------
    -- TP TO SAFE ZONE (ครั้งเดียว)
    -----------------------------------------------------------------
    local Btn = CreateModernButton(Content, "🚀 TP to Safe Zone", Color3.fromRGB(0,120,255))
    Btn.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = SafeZoneCFrame
        end
    end)

    -----------------------------------------------------------------
    -- FPS LOCK (ล็อก FPS)
    -----------------------------------------------------------------
    local fpsLockEnabled = false
    local fpsLockValue = 60
    local fpsLockConnection = nil
    
    -- FPS Input Box
    local fpsInputBox = Instance.new("TextBox", Content)
    fpsInputBox.Size = UDim2.new(0.6, -10, 0, 30)
    fpsInputBox.Position = UDim2.new(0, 10, 0, 0)
    fpsInputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    fpsInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsInputBox.Font = Enum.Font.Gotham
    fpsInputBox.TextSize = 14
    fpsInputBox.PlaceholderText = "FPS Value (30-120)"
    fpsInputBox.Text = tostring(fpsLockValue)
    fpsInputBox.TextXAlignment = Enum.TextXAlignment.Center
    Instance.new("UICorner", fpsInputBox).CornerRadius = UDim.new(0, 6)
    
    -- FPS Lock Button
    local FpsLockBtn = Instance.new("TextButton", Content)
    FpsLockBtn.Size = UDim2.new(0.35, -10, 0, 30)
    FpsLockBtn.Position = UDim2.new(0.65, 0, 0, 0)
    FpsLockBtn.BackgroundColor3 = fpsLockEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    FpsLockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FpsLockBtn.Font = Enum.Font.GothamBold
    FpsLockBtn.TextSize = 14
    FpsLockBtn.Text = "🔒 Lock FPS: OFF"
    Instance.new("UICorner", FpsLockBtn).CornerRadius = UDim.new(0, 6)
    
    -- FPS Input validation
    fpsInputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local newFps = tonumber(fpsInputBox.Text)
            if newFps and newFps >= 30 and newFps <= 120 then
                fpsLockValue = newFps
                fpsInputBox.Text = tostring(fpsLockValue)
            else
                fpsInputBox.Text = tostring(fpsLockValue)
            end
        end
    end)
    
    -- FPS Lock functionality
    FpsLockBtn.MouseButton1Click:Connect(function()
        fpsLockEnabled = not fpsLockEnabled
        FpsLockBtn.Text = "🔒 Lock FPS: " .. (fpsLockEnabled and "ON" or "OFF")
        FpsLockBtn.BackgroundColor3 = fpsLockEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        
        if fpsLockEnabled then
            -- เริ่มล็อก FPS
            if fpsLockConnection then
                fpsLockConnection:Disconnect()
            end
            
            fpsLockConnection = RunService.Heartbeat:Connect(function()
                if fpsLockEnabled then
                    local targetFrameTime = 1 / fpsLockValue
                    local currentTime = tick()
                    local elapsed = currentTime - (getgenv().lastFrameTime or currentTime)
                    
                    if elapsed < targetFrameTime then
                        task.wait(targetFrameTime - elapsed)
                    end
                    
                    getgenv().lastFrameTime = tick()
                end
            end)
        else
            -- หยุดล็อก FPS
            if fpsLockConnection then
                fpsLockConnection:Disconnect()
                fpsLockConnection = nil
            end
        end
    end)

    -----------------------------------------------------------------
    -- AUTO KILL MONSTERS
    -----------------------------------------------------------------
    local autoKillEnabled = false
    local autoKillThread = nil
    
    local AutoKillBtn = CreateModernButton(Content, "⚔️ AutoKill: OFF", Color3.fromRGB(170, 0, 0))
    
    AutoKillBtn.MouseButton1Click:Connect(function()
        autoKillEnabled = not autoKillEnabled
        if autoKillEnabled then
            AutoKillBtn.Text = "⚔️ AutoKill: ON"
            AutoKillBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            
            -- เริ่ม AutoKill loop
            if autoKillThread then
                task.cancel(autoKillThread)
            end
            
            autoKillThread = task.spawn(function()
                while autoKillEnabled do
                    pcall(function()
                        local enemiesFolder = workspace:FindFirstChild("Enemies")
                        if enemiesFolder then
                            -- หามอนที่ยังมีชีวิตอยู่
                            local aliveMonsters = {}
                            for name, _ in pairs(thugNames) do
                                local monster = enemiesFolder:FindFirstChild(name)
                                if monster and monster:FindFirstChild("Humanoid") and monster:FindFirstChild("HumanoidRootPart") then
                                    local humanoid = monster.Humanoid
                                    if humanoid.Health > 0 then
                                        table.insert(aliveMonsters, monster)
                                    end
                                end
                            end
                            
                            if #aliveMonsters > 0 then
                                -- เลือกมอนตัวแรก
                                local targetMonster = aliveMonsters[1]
                                local targetHRP = targetMonster.HumanoidRootPart
                                
                                -- TP ไปหลังมอน (ไม่ให้มอนตีเราได้)
                                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                    local playerHRP = player.Character.HumanoidRootPart
                                    
                                    -- รอให้มอนตาย + ล็อกตามมอน + หันหน้าไปหามอน
                                    local startTime = tick()
                                    while autoKillEnabled and targetMonster.Parent and targetMonster:FindFirstChild("Humanoid") and targetMonster.Humanoid.Health > 0 do
                                        -- ล็อกตามมอนไปด้วย (TP ไปหลังมอนตลอด)
                                        if targetMonster:FindFirstChild("HumanoidRootPart") then
                                            local behindPosition = targetHRP.CFrame * CFrame.new(0, 2, -5)
                                            playerHRP.CFrame = behindPosition
                                            
                                            -- หันหน้าไปหามอน
                                            local lookDirection = (targetHRP.Position - playerHRP.Position).Unit
                                            local lookCFrame = CFrame.lookAt(playerHRP.Position, playerHRP.Position + lookDirection)
                                            playerHRP.CFrame = lookCFrame
                                        end
                                        
                                        task.wait(0.1)
                                        -- ตรวจสอบ timeout (30 วินาที)
                                        if tick() - startTime > 30 then
                                            break
                                        end
                                    end
                                    
                                    -- รอสักครู่ก่อนไปหาตัวถัดไป
                                    task.wait(0.5)
                                end
                            else
                                -- ไม่มีมอนที่ยังมีชีวิต รอสักครู่
                                task.wait(2)
                            end
                        else
                            -- ไม่มี Enemies folder รอสักครู่
                            task.wait(1)
                        end
                    end)
                end
            end)
        else
            AutoKillBtn.Text = "⚔️ AutoKill: OFF"
            AutoKillBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            
            -- หยุด AutoKill
            if autoKillThread then
                task.cancel(autoKillThread)
                autoKillThread = nil
            end
        end
    end)

end

-- Swords Tab (choose weapon to auto-equip)
local function LoadSwordsTab()
    ClearContent()
-- AutoEquip
    local EquipBtn = Instance.new("TextButton", Content)
    EquipBtn.Size = UDim2.new(1, -20, 0, 30)
    EquipBtn.BackgroundColor3 = States.AutoEquip.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    EquipBtn.Text = "AutoEquip Weapon: "..(States.AutoEquip.Enabled and "ON" or "OFF")
    EquipBtn.Font = Enum.Font.GothamBold
    EquipBtn.TextSize = 14
    EquipBtn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", EquipBtn).CornerRadius = UDim.new(0,6)

    EquipBtn.MouseButton1Click:Connect(function()
        States.AutoEquip.Enabled = not States.AutoEquip.Enabled
        EquipBtn.BackgroundColor3 = States.AutoEquip.Enabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        EquipBtn.Text = "AutoEquip Weapon: "..(States.AutoEquip.Enabled and "ON" or "OFF")
        if States.AutoEquip.Enabled then
            task.spawn(function()
                while States.AutoEquip.Enabled do
                    task.wait(1)
                    if player.Character and player.Character:FindFirstChild("Humanoid") and States.AutoEquip.Weapon then
                        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        local backpack = player:FindFirstChild("Backpack")
                        if backpack and humanoid then
                            local tool = backpack:FindFirstChild(States.AutoEquip.Weapon)
                            if tool and not humanoid:FindFirstChild(States.AutoEquip.Weapon) then
                                humanoid:EquipTool(tool)
                            end
                        end
                    end
                end
            end)
        end
    end)

    local ListFrame = Instance.new("ScrollingFrame", Content)
    ListFrame.Size = UDim2.new(1, -20, 1, -20)
    ListFrame.Position = UDim2.new(0, 0, 0, 0)
    ListFrame.CanvasSize = UDim2.new(0,0,0,0)
    ListFrame.ScrollBarThickness = 6
    ListFrame.BackgroundTransparency = 1
    local layout = Instance.new("UIListLayout", ListFrame)
    layout.Padding = UDim.new(0,5)

    local function RefreshList()
        for _,v in pairs(ListFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        local backpack = player:FindFirstChild("Backpack")
        if not backpack then return end
        for _,tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                local Btn = Instance.new("TextButton", ListFrame)
                Btn.Size = UDim2.new(1, -10, 0, 30)
                Btn.Text = "Set AutoEquip: "..tool.Name
                Btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
                Btn.TextColor3 = Color3.fromRGB(255,255,255)
                Btn.Font = Enum.Font.GothamBold
                Btn.TextSize = 14
                Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)
                Btn.MouseButton1Click:Connect(function()
                    States.AutoEquip.Weapon = tool.Name
                end)
            end
        end
        local count = 0
        for _,v in pairs(ListFrame:GetChildren()) do if v:IsA("TextButton") then count = count + 1 end end
        ListFrame.CanvasSize = UDim2.new(0,0,0, math.max(1, count)*35)
    end

    RefreshList()
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        backpack.ChildAdded:Connect(RefreshList)
        backpack.ChildRemoved:Connect(RefreshList)
    else
        player.ChildAdded:Connect(function(child)
            if child.Name == "Backpack" then
                child.ChildAdded:Connect(RefreshList)
                child.ChildRemoved:Connect(RefreshList)
                RefreshList()
            end
        end)
    end

end

----------------------------------------------------------------
-- PLAYER TAB (ESP + BOX + PLAYER LIST)
----------------------------------------------------------------
function LoadPlayerTab()
    ClearContent()

    local player = Players.LocalPlayer
    local currentSpectate = nil

    -----------------------------
    -- ESP Config
    -----------------------------
    local espEnabled = false
    local boxEspEnabled = false
    local espSize = 12
    local espConnections = {}

    -- ฟังก์ชันอัปเดตขนาดทั้งหมด
    local function updateAllESP()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local gui = plr.Character.Head:FindFirstChild("ESP_Name")
                if gui and gui:IsA("BillboardGui") then
                    gui.Size = UDim2.new(0, espSize*10, 0, espSize*4)
                    local label = gui:FindFirstChildOfClass("TextLabel")
                    if label then
                        label.TextSize = espSize
                    end
                end
            end
        end
    end

    -- ฟังก์ชันสร้าง Billboard
    local function createBillboard(plr)
        if not plr.Character then return end
        if plr.Character:FindFirstChild("Head") and not plr.Character.Head:FindFirstChild("ESP_Name") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP_Name"
            billboard.Size = UDim2.new(0, espSize*10, 0, espSize*4)
            billboard.AlwaysOnTop = true
            billboard.Adornee = plr.Character.Head
            billboard.Parent = plr.Character.Head
            billboard.StudsOffset = Vector3.new(0, 3, 0)

            local text = Instance.new("TextLabel", billboard)
            text.Size = UDim2.new(1,0,1,0)
            text.BackgroundTransparency = 1
            text.TextColor3 = Color3.new(1,1,1)
            text.TextStrokeTransparency = 0
            text.Font = Enum.Font.GothamBold
            text.TextScaled = false
            text.TextSize = espSize

            task.spawn(function()
                while billboard.Parent and espEnabled do
                    if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local hum = plr.Character:FindFirstChild("Humanoid")
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        local dist = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude

                        local hpPercent = hum.Health / hum.MaxHealth
                        if hpPercent > 0.6 then
                            text.TextColor3 = Color3.fromRGB(0,255,0)
                        elseif hpPercent > 0.3 then
                            text.TextColor3 = Color3.fromRGB(255,255,0)
                        else
                            text.TextColor3 = Color3.fromRGB(255,0,0)
                        end

                        text.Text = string.format("%s | %.0f", plr.Name, dist)
                    end
                    task.wait(0.2)
                end
                if billboard then billboard:Destroy() end
            end)
        end
    end

    local function enableESP()
        espEnabled = true
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                createBillboard(plr)
            end
        end
        espConnections["Added"] = Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function()
                task.wait(1)
                createBillboard(plr)
            end)
        end)
    end

    local function disableESP()
        espEnabled = false
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local gui = plr.Character.Head:FindFirstChild("ESP_Name")
                if gui then gui:Destroy() end
            end
        end
        for _,con in pairs(espConnections) do
            if con then con:Disconnect() end
        end
        espConnections = {}
    end

    local function enableBoxESP()
        boxEspEnabled = true
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                if not plr.Character:FindFirstChild("BoxESP") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "BoxESP"
                    highlight.Adornee = plr.Character
                    highlight.FillTransparency = 1
                    highlight.OutlineColor = Color3.fromRGB(0,255,0)
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = plr.Character
                end
            end
            plr.CharacterAdded:Connect(function(char)
                task.wait(1)
                if not char:FindFirstChild("BoxESP") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "BoxESP"
                    highlight.Adornee = char
                    highlight.FillTransparency = 1
                    highlight.OutlineColor = Color3.fromRGB(0,255,0)
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = char
                end
            end)
        end
    end

    local function disableBoxESP()
        boxEspEnabled = false
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("BoxESP") then
                plr.Character.BoxESP:Destroy()
            end
        end
    end

    -----------------------------
    -- ปุ่ม UI ESP
    -----------------------------
    local espBtn = Instance.new("TextButton", Content)
    espBtn.Size = UDim2.new(1, -20, 0, 30)
    espBtn.Text = "ESP Players: OFF"
    espBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
    espBtn.TextColor3 = Color3.new(1,1,1)
    espBtn.Font = Enum.Font.GothamBold
    espBtn.TextSize = 14
    Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0,6)

    espBtn.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        espBtn.Text = "ESP Players: " .. (espEnabled and "ON" or "OFF")
        espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        if espEnabled then enableESP() else disableESP() end
    end)

    local minusBtn = Instance.new("TextButton", Content)
    minusBtn.Size = UDim2.new(1, -20, 0, 30)
    minusBtn.Text = "- ESP Size"
    minusBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
    minusBtn.TextColor3 = Color3.new(1,1,1)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 14
    Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0,6)

    minusBtn.MouseButton1Click:Connect(function()
        espSize = math.max(8, espSize - 2)
        updateAllESP()
    end)

    local plusBtn = Instance.new("TextButton", Content)
    plusBtn.Size = UDim2.new(1, -20, 0, 30)
    plusBtn.Text = "+ ESP Size"
    plusBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
    plusBtn.TextColor3 = Color3.new(1,1,1)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 14
    Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0,6)

    plusBtn.MouseButton1Click:Connect(function()
        espSize = math.min(30, espSize + 2)
        updateAllESP()
    end)

    local boxEspBtn = Instance.new("TextButton", Content)
    boxEspBtn.Size = UDim2.new(1, -20, 0, 30)
    boxEspBtn.Text = "Box ESP: OFF"
    boxEspBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
    boxEspBtn.TextColor3 = Color3.new(1,1,1)
    boxEspBtn.Font = Enum.Font.GothamBold
    boxEspBtn.TextSize = 14
    Instance.new("UICorner", boxEspBtn).CornerRadius = UDim.new(0,6)

    boxEspBtn.MouseButton1Click:Connect(function()
        boxEspEnabled = not boxEspEnabled
        boxEspBtn.Text = "Box ESP: " .. (boxEspEnabled and "ON" or "OFF")
        boxEspBtn.BackgroundColor3 = boxEspEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        if boxEspEnabled then enableBoxESP() else disableBoxESP() end
    end)

    ----------------------------------------------------------------
    -- PLAYER PULL SYSTEM
    ----------------------------------------------------------------
    local distance = 7 -- ระยะจากเรา
    local pullingAll = false       -- toggle loop ดึงทุกคน
    local pullingSelected = nil    -- เก็บผู้เล่นที่เลือกไว้สำหรับ loop

    -- ฟังก์ชันดึงผู้เล่นเดี่ยว
    local function pullPlayer(plr)
        local myChar = player.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local targetChar = plr.Character
        local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        if myHRP and targetHRP then
            targetHRP.CFrame = myHRP.CFrame * CFrame.new(0, 0, -distance)
        end
    end

    -- ดึงผู้เล่นทุกคน
    local function pullAllPlayers()
        local myChar = player.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then
                pullPlayer(plr)
            end
        end
    end

    -- ปุ่ม Pull All Once
    local pullAllBtn = Instance.new("TextButton", Content)
    pullAllBtn.Size = UDim2.new(1, -20, 0, 30)
    pullAllBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 150)
    pullAllBtn.TextColor3 = Color3.new(1,1,1)
    pullAllBtn.Text = "Pull All Once"
    pullAllBtn.Font = Enum.Font.GothamBold
    pullAllBtn.TextSize = 14
    Instance.new("UICorner", pullAllBtn).CornerRadius = UDim.new(0,6)

    pullAllBtn.MouseButton1Click:Connect(function()
        pullAllPlayers()
    end)

    -- ปุ่ม Pull All Loop
    local loopBtn = Instance.new("TextButton", Content)
    loopBtn.Size = UDim2.new(1, -20, 0, 30)
    loopBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 70)
    loopBtn.TextColor3 = Color3.new(1,1,1)
    loopBtn.Text = "Pull All Loop: OFF"
    loopBtn.Font = Enum.Font.GothamBold
    loopBtn.TextSize = 14
    Instance.new("UICorner", loopBtn).CornerRadius = UDim.new(0,6)

    loopBtn.MouseButton1Click:Connect(function()
        pullingAll = not pullingAll
        loopBtn.Text = pullingAll and "Pull All Loop: ON" or "Pull All Loop: OFF"
        loopBtn.BackgroundColor3 = pullingAll and Color3.fromRGB(30,140,60) or Color3.fromRGB(120,70,70)
    end)

    -- ปุ่ม Pull Selected Loop
    local selectedLoopBtn = Instance.new("TextButton", Content)
    selectedLoopBtn.Size = UDim2.new(1, -20, 0, 30)
    selectedLoopBtn.BackgroundColor3 = Color3.fromRGB(120, 90, 50)
    selectedLoopBtn.TextColor3 = Color3.new(1,1,1)
    selectedLoopBtn.Text = "Pull Selected Loop: OFF"
    selectedLoopBtn.Font = Enum.Font.GothamBold
    selectedLoopBtn.TextSize = 14
    Instance.new("UICorner", selectedLoopBtn).CornerRadius = UDim.new(0,6)

    -- ปุ่ม Selected Loop toggle
    local selectedLoopOn = false
    selectedLoopBtn.MouseButton1Click:Connect(function()
        if pullingSelected then
            selectedLoopOn = not selectedLoopOn
            selectedLoopBtn.Text = selectedLoopOn and ("Pull Selected Loop: "..pullingSelected.Name.." (ON)") 
                                                  or ("Pull Selected Loop: "..pullingSelected.Name.." (OFF)")
            selectedLoopBtn.BackgroundColor3 = selectedLoopOn and Color3.fromRGB(30,140,200) or Color3.fromRGB(120,90,50)
        else
            selectedLoopBtn.Text = "Pull Selected Loop: (No Target)"
        end
    end)

    -----------------------------
    -- รายชื่อผู้เล่น + ปุ่ม Spectate / Teleport
    -----------------------------
    local playerList = Instance.new("ScrollingFrame", Content)
    playerList.Size = UDim2.new(1, -10, 1, -200)
    playerList.Position = UDim2.new(0,5,0,190)
    playerList.CanvasSize = UDim2.new(0,0,0,0)
    playerList.ScrollBarThickness = 6
    playerList.BackgroundTransparency = 1
    playerList.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local layout = Instance.new("UIListLayout", playerList)
    layout.Padding = UDim.new(0,5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local function createPlayerButton(plr)
        local frame = Instance.new("Frame", playerList)
        frame.Size = UDim2.new(1, -10, 0, 40)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BorderSizePixel = 0
        frame.Name = plr.Name
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)

        local nameLabel = Instance.new("TextLabel", frame)
        nameLabel.Size = UDim2.new(0.5,0,1,0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name
        nameLabel.TextColor3 = Color3.new(1,1,1)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextScaled = false   -- ปิด auto scale
        nameLabel.TextSize = 18        -- ✅ กำหนดขนาดฟอนต์

        -- ปุ่ม Spectate
        local spectateBtn = Instance.new("TextButton", frame)
        spectateBtn.Size = UDim2.new(0.18,0,1,0)
        spectateBtn.Position = UDim2.new(0.59,0,0,0)
        spectateBtn.Text = "Spectate"
        spectateBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
        spectateBtn.TextColor3 = Color3.new(1,1,1)
        spectateBtn.Font = Enum.Font.GothamBold
        spectateBtn.TextScaled = true
        Instance.new("UICorner", spectateBtn).CornerRadius = UDim.new(0,6)

        -- ปุ่ม Teleport
        local tpBtn = Instance.new("TextButton", frame)
        tpBtn.Size = UDim2.new(0.20,0,1,0)
        tpBtn.Position = UDim2.new(0.79,0,0,0)
        tpBtn.Text = "Teleport"
        tpBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
        tpBtn.TextColor3 = Color3.new(1,1,1)
        tpBtn.Font = Enum.Font.GothamBold
        tpBtn.TextScaled = true
        Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,6)

        spectateBtn.MouseButton1Click:Connect(function()
            if currentSpectate == plr then
                currentSpectate = nil
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                end
                spectateBtn.Text = "Spectate"
                spectateBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
            else
                currentSpectate = plr
                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
                end
                spectateBtn.Text = "Unspectate"
                spectateBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
            end
        end)

        tpBtn.MouseButton1Click:Connect(function()
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                end
            end
        end)

        -- เพิ่มปุ่ม Pull
        local pullBtn = Instance.new("TextButton", frame)
        pullBtn.Name = "Pull"
        pullBtn.Size = UDim2.new(0.18,0,1,0)
        pullBtn.Position = UDim2.new(0.40,0,0,0)
        pullBtn.Text = "Pull"
        pullBtn.BackgroundColor3 = Color3.fromRGB(255,100,0)
        pullBtn.TextColor3 = Color3.new(1,1,1)
        pullBtn.Font = Enum.Font.GothamBold
        pullBtn.TextScaled = true
        Instance.new("UICorner", pullBtn).CornerRadius = UDim.new(0,6)

        pullBtn.MouseButton1Click:Connect(function()
            pullPlayer(plr)
            -- กำหนดว่าเป็นเป้าหมายสำหรับ Selected Loop
            pullingSelected = plr
            selectedLoopBtn.Text = "Pull Selected Loop: "..plr.Name.." (OFF)"
            selectedLoopOn = false
            selectedLoopBtn.BackgroundColor3 = Color3.fromRGB(120,90,50)
        end)
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            createPlayerButton(plr)
        end
    end
    Players.PlayerAdded:Connect(function(plr)
        if plr ~= player then
            createPlayerButton(plr)
        end
    end)
    Players.PlayerRemoving:Connect(function(plr)
        local btn = playerList:FindFirstChild(plr.Name)
        if btn then btn:Destroy() end
    end)

    -- Loop สำหรับ Pull All และ Pull Selected
    task.spawn(function()
        while task.wait() do
            if pullingAll then
                pullAllPlayers()
            end
            if selectedLoopOn and pullingSelected and pullingSelected.Parent == Players then
                pullPlayer(pullingSelected)
            end
        end
    end)


end



----------------------------------------------------------------
-- DEVIL FRUIT TAB (Spectate + Teleport + ESP + Sorted A-Z)
----------------------------------------------------------------
function LoadDevilFruitTab()
    ClearContent()
    -- ===================== FRUIT ESP =====================
    local fruitESPEnabled = false
    local playerESP = {}
    local TargetFruits = {"Smoke","Sand","Rumble","Quake","Phoenix","Ope","Magma","Light","Hollow","Alice","Gas","Flare","Dark","Chilly","Candy","Plasma","Gravity","Vampire","Venom","Snow","Rare Box","Ultra Rare Box"}
    local fruitLookup = {}; for _,f in ipairs(TargetFruits) do fruitLookup[string.lower(f)] = true end
    local function isTargetFruit(name)
        if not name then return false end
        local lname = string.lower(name)
        for key,_ in pairs(fruitLookup) do if string.find(lname, key, 1, true) then return true end end
        return false
    end
    local function isFruitTool(obj)
        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") then
            for key,_ in pairs(fruitLookup) do if string.find(string.lower(obj.Name), key, 1, true) then return true end end
        end
        return false
    end
    local function createESP(plr, fruitName)
        local head = plr.Character and plr.Character:FindFirstChild("Head")
        if not head then return end
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "FruitESP"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0,200,0,40)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = 2000
        billboard.Parent = head
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.TextScaled = true
        txt.Font = Enum.Font.SourceSansBold
        txt.TextColor3 = Color3.fromRGB(255,80,80)
        txt.Text = fruitName.." ("..plr.Name..")"
        txt.Parent = billboard
        playerESP[plr] = billboard
    end
    local function removeESP(plr)
        if playerESP[plr] then playerESP[plr]:Destroy() playerESP[plr]=nil end
    end
    local function scanFruits()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local fruitName = nil
                if plr:FindFirstChild("Backpack") then
                    for _, item in pairs(plr.Backpack:GetChildren()) do
                        if isFruitTool(item) then fruitName = item.Name break end
                    end
                end
                if not fruitName then
                    for _, tool in pairs(plr.Character:GetChildren()) do
                        if isFruitTool(tool) then fruitName = tool.Name break end
                    end
                end
                if fruitName then
                    if not playerESP[plr] then createESP(plr, fruitName)
                    else local txt = playerESP[plr]:FindFirstChildOfClass("TextLabel") if txt then txt.Text = fruitName.." ("..plr.Name..")" end end
                else removeESP(plr) end
            end
        end
    end
    local function clearAllESP() for plr,_ in pairs(playerESP) do removeESP(plr) end end
    local fruitESPBtn = CreateModernButton(Content, "Toggle Fruit ESP", Color3.fromRGB(120,180,80))
    fruitESPBtn.MouseButton1Click:Connect(function()
        fruitESPEnabled = not fruitESPEnabled
        fruitESPBtn.Text = fruitESPEnabled and "Fruit ESP: ON" or "Fruit ESP: OFF"
        if not fruitESPEnabled then clearAllESP() end
    end)
    task.spawn(function()
        while true do task.wait(2.5)
            if fruitESPEnabled then scanFruits() else clearAllESP() end
        end
    end)

    -- ===================== SPECTATE PLAYER =====================
    local spectateTarget = nil
    local spectating = false
    local Camera = workspace.CurrentCamera
    local spectateLabel = Instance.new("TextLabel", Content)
    spectateLabel.Size = UDim2.new(1, -20, 0, 28)
    spectateLabel.BackgroundTransparency = 1
    spectateLabel.Text = "Spectate Player:"
    spectateLabel.Font = Enum.Font.Gotham
    spectateLabel.TextSize = 14
    spectateLabel.TextColor3 = Color3.fromRGB(255,255,255)
    local spectateDropdown = Instance.new("TextButton", Content)
    spectateDropdown.Size = UDim2.new(1, -20, 0, 32)
    spectateDropdown.BackgroundColor3 = Color3.fromRGB(80,80,120)
    spectateDropdown.TextColor3 = Color3.fromRGB(255,255,255)
    spectateDropdown.Font = Enum.Font.Gotham
    spectateDropdown.TextSize = 14
    spectateDropdown.Text = "เลือกผู้เล่น..."
    Instance.new("UICorner", spectateDropdown).CornerRadius = UDim.new(0,8)
    local function refreshDropdown()
        local names = {}
        for _,plr in pairs(Players:GetPlayers()) do if plr ~= player then table.insert(names, plr.Name) end end
        spectateDropdown.Text = #names>0 and ("เลือก: "..names[1]) or "ไม่มีผู้เล่น"
        spectateTarget = #names>0 and Players:FindFirstChild(names[1]) or nil
        spectateDropdown.MouseButton1Click:Connect(function()
            local menu = Instance.new("Frame", Content)
            menu.Size = UDim2.new(1, -20, 0, 120)
            menu.Position = UDim2.new(0,10,0,0)
            menu.BackgroundColor3 = Color3.fromRGB(30,30,40)
            Instance.new("UICorner", menu).CornerRadius = UDim.new(0,8)
            for i,plr in ipairs(Players:GetPlayers()) do
                if plr ~= player then
                    local btn = Instance.new("TextButton", menu)
                    btn.Size = UDim2.new(1, -10, 0, 24)
                    btn.Position = UDim2.new(0,5,0,(i-1)*26)
                    btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
                    btn.Text = plr.Name
                    btn.Font = Enum.Font.Gotham
                    btn.TextSize = 13
                    btn.TextColor3 = Color3.fromRGB(255,255,255)
                    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
                    btn.MouseButton1Click:Connect(function()
                        spectateTarget = plr
                        spectateDropdown.Text = "เลือก: "..plr.Name
                        menu:Destroy()
                    end)
                end
            end
        end)
    end
    refreshDropdown()
    local spectateBtn = CreateModernButton(Content, "Toggle Spectate", Color3.fromRGB(120,120,220))
    spectateBtn.MouseButton1Click:Connect(function()
        spectating = not spectating
        spectateBtn.Text = spectating and "Spectate: ON" or "Spectate: OFF"
        if spectating and spectateTarget and spectateTarget.Character and spectateTarget.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = spectateTarget.Character.Humanoid
        else
            Camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid") or workspace
        end
    end)

    -- ===================== AUTO COLLECT FRUITS =====================
    local autoCollectEnabled = false
    local autoBtn = CreateModernButton(Content, "Toggle Auto Collect Fruit", Color3.fromRGB(200,120,80))
    autoBtn.MouseButton1Click:Connect(function()
        autoCollectEnabled = not autoCollectEnabled
        autoBtn.Text = autoCollectEnabled and "Auto Collect: ON" or "Auto Collect: OFF"
    end)
    local RF_RareDevilfruit = {"Smoke","Sand","Rumble","Quake","Phoenix","Ope","Magma","Light","Hollow","Alice","Gas","Flare","Dark","Chilly","Candy","Plasma","Gravity","Vampire","Venom","Snow"}
    local function isRareDevilfruit(name)
        for _,fruitName in ipairs(RF_RareDevilfruit) do if string.find(name, fruitName) then return true end end
        return false
    end
    local Locations = { ["Afk"] = CFrame.new(-0.60, 200003, 190) }
    local function TeleportTo(name)
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local pos = Locations[name]
        if pos then hrp.CFrame = pos end
    end
    task.spawn(function()
        while true do task.wait(2)
            if autoCollectEnabled then
                for _,v in pairs(workspace:GetChildren()) do
                    if isRareDevilfruit(v.Name) and string.find(v.Name, "Fruit") then
                        if player.Character and v:FindFirstChild("Handle") then
                            player.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                            task.wait(0.2)
                            local success = pcall(function() fireclickdetector(v.Handle.ClickDetector) end)
                            if success then task.wait(0.3) TeleportTo("Afk") end
                        end
                    end
                end
            end
        end
    end)

    -- ===================== SAFE ZONE =====================
    local safeBtn = CreateModernButton(Content, "Teleport to Safe Zone", Color3.fromRGB(80,200,200))
    safeBtn.MouseButton1Click:Connect(function()
        local SafeCFrame = CFrame.new(1849.68262, 237.200668, 849.754639)
        local char = player.Character or player.CharacterAdded:Wait()
        char:WaitForChild("HumanoidRootPart").CFrame = SafeCFrame
    end)

    -- ===================== GOD MODE (USER LOGIC) =====================
    local godEnabled = false
    local godBtn = CreateModernButton(Content, "Toggle God Mode", Color3.fromRGB(200,80,200))
    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local Event = ReplicatedStorage.Connections.Spawn
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    local function enableGodMode()
        setreadonly(mt, false)
        mt.__namecall = function(self, ...)
            local method = getnamecallmethod()
            if self == Event and method == 'FireServer' then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                    -77.09452056884766,
                    215.99998474121094,
                    -858.5032958984375
                )
                return
            end
            return oldNamecall(self, ...)
        end
        setreadonly(mt, true)
    end
    local function disableGodMode()
        setreadonly(mt, false)
        mt.__namecall = oldNamecall
        setreadonly(mt, true)
    end
    godBtn.MouseButton1Click:Connect(function()
        godEnabled = not godEnabled
        if godEnabled then
            enableGodMode()
            godBtn.Text = "God Mode: ON"
            -- รีตัวตายเมื่อเปิด
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").Health = 0
            end
        else
            disableGodMode()
            godBtn.Text = "God Mode: OFF"
            -- รีตัวตายเมื่อปิด
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").Health = 0
            end
        end
    end)
    -- ClearContent() -- Removed to prevent wiping out DevilFruit UI
    local fruitEspEnabled = false
    local fruitEspConnections = {}
    local currentSpectate = nil

    -----------------------------------------------------
    -- ฟังก์ชันสร้าง Billboard สำหรับผล
    -----------------------------------------------------
    local function createFruitESP(fruit)
        if not fruit:IsDescendantOf(workspace) then return end
        if fruit:FindFirstChild("FruitESP") then return end

        local target = fruit:FindFirstChild("Handle") or fruit.PrimaryPart or (fruit:IsA("BasePart") and fruit)
        if not target then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "FruitESP"
        billboard.Size = UDim2.new(0,200,0,50)
        billboard.AlwaysOnTop = true
        billboard.Adornee = target
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Parent = fruit

        local label = Instance.new("TextLabel", billboard)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255,255,0)
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextScaled = false
        label.TextSize = 14

        task.spawn(function()
            while billboard.Parent and fruitEspEnabled do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and target then
                    local dist = (target.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    label.Text = string.format("%s | %.0f", fruit.Name, dist)
                end
                task.wait(0.3)
            end
            if billboard then billboard:Destroy() end
        end)
    end

    -----------------------------------------------------
    -- เปิด/ปิด ESP
    -----------------------------------------------------
    local function enableFruitESP()
        fruitEspEnabled = true
        for _, obj in pairs(workspace:GetChildren()) do
            if string.find(obj.Name, "Fruit") then
                createFruitESP(obj)
            end
        end
        fruitEspConnections["Added"] = workspace.ChildAdded:Connect(function(obj)
            if fruitEspEnabled and string.find(obj.Name, "Fruit") then
                task.wait(0.5)
                createFruitESP(obj)
            end
        end)
    end

    local function disableFruitESP()
        fruitEspEnabled = false
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:FindFirstChild("FruitESP") then
                obj.FruitESP:Destroy()
            end
        end
        for _,con in pairs(fruitEspConnections) do
            if con then con:Disconnect() end
        end
        fruitEspConnections = {}
    end

    -----------------------------------------------------
    -- ปุ่ม ESP Fruits (บนสุด)
    -----------------------------------------------------
    local fruitEspBtn = Instance.new("TextButton", Content)
    fruitEspBtn.Size = UDim2.new(1, -20, 0, 30)
    fruitEspBtn.Text = "ESP Fruits: OFF"
    fruitEspBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
    fruitEspBtn.TextColor3 = Color3.new(1,1,1)
    fruitEspBtn.Font = Enum.Font.GothamBold
    fruitEspBtn.TextSize = 14
    fruitEspBtn.LayoutOrder = 1
    Instance.new("UICorner", fruitEspBtn).CornerRadius = UDim.new(0,6)

    fruitEspBtn.MouseButton1Click:Connect(function()
        fruitEspEnabled = not fruitEspEnabled
        fruitEspBtn.Text = "ESP Fruits: " .. (fruitEspEnabled and "ON" or "OFF")
        fruitEspBtn.BackgroundColor3 = fruitEspEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        if fruitEspEnabled then enableFruitESP() else disableFruitESP() end
    end)

	-----------------------------------------------------
-- Auto Claim Sam (UI + Logic)
-----------------------------------------------------
local autoClaimSamThread = nil

local function StartAutoClaimSam()
    if autoClaimSamThread then return end
    autoClaimSamThread = task.spawn(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RemoteContainer = ReplicatedStorage:FindFirstChild("Connections")
        if not RemoteContainer then
            warn("❌ ไม่พบ ReplicatedStorage.Connections")
            return
        end
        local ClaimRemote = RemoteContainer:FindFirstChild("Claim_Sam")
        if not ClaimRemote then
            warn("❌ ไม่พบ Remote 'Claim_Sam'")
            return
        end

        while States.Fruit.AutoClaimSam do
            pcall(function()
                ClaimRemote:FireServer("Claim1") -- 🔑 ปรับ arg ตรงนี้ให้ตรงกับที่ sniff เจอ
            end)
            task.wait(States.Fruit.SamDelay or 1)
        end
        autoClaimSamThread = nil
    end)
end

local autoClaimSamBtn = Instance.new("TextButton", Content)
autoClaimSamBtn.Size = UDim2.new(1, -20, 0, 30)
autoClaimSamBtn.Text = "Auto Claim Sam: " .. (States.Fruit.AutoClaimSam and "ON" or "OFF")
autoClaimSamBtn.BackgroundColor3 = States.Fruit.AutoClaimSam and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
autoClaimSamBtn.TextColor3 = Color3.new(1,1,1)
autoClaimSamBtn.Font = Enum.Font.GothamBold
autoClaimSamBtn.TextSize = 14
autoClaimSamBtn.LayoutOrder = 2
Instance.new("UICorner", autoClaimSamBtn).CornerRadius = UDim.new(0,6)

autoClaimSamBtn.MouseButton1Click:Connect(function()
    States.Fruit.AutoClaimSam = not States.Fruit.AutoClaimSam
    autoClaimSamBtn.Text = "Auto Claim Sam: " .. (States.Fruit.AutoClaimSam and "ON" or "OFF")
    autoClaimSamBtn.BackgroundColor3 = States.Fruit.AutoClaimSam and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    if States.Fruit.AutoClaimSam then
        StartAutoClaimSam()
    end
end)

-- ===================== DROP COMPASS =====================
local dropCompassEnabled = false
local dropCompassThread = nil

local function startDropCompassLoop()
    if dropCompassThread then return end
    dropCompassThread = task.spawn(function()
        while dropCompassEnabled do
            local backpack = player:FindFirstChild("Backpack")
            local character = player.Character
            if backpack and character and character:FindFirstChild("Humanoid") then
                local humanoid = character:FindFirstChild("Humanoid")
                
                -- หา Compass ใน backpack
                for _, tool in ipairs(backpack:GetChildren()) do
                    if not dropCompassEnabled then break end
                    if tool:IsA("Tool") and string.find(string.lower(tool.Name), "compass") then
                        pcall(function()
                            humanoid:EquipTool(tool)
                            task.wait(0.1)
                            if tool.Parent == character then
                                -- ใช้ Backspace เพื่อทิ้ง
                                local VIM = game:GetService("VirtualInputManager")
                                VIM:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
                                task.wait(0.05)
                                VIM:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
                            end
                        end)
                        task.wait(0.2) -- รอระหว่างการทิ้งแต่ละอัน
                    end
                end
            end
            task.wait(0.5) -- รอสักครู่ก่อนเช็คใหม่
        end
        dropCompassThread = nil
    end)
end

-- ปุ่ม Drop Compass
local dropCompassBtn = Instance.new("TextButton", Content)
dropCompassBtn.Size = UDim2.new(1, -20, 0, 30)
dropCompassBtn.Text = "🗺️ Drop Compass: " .. (dropCompassEnabled and "ON" or "OFF")
dropCompassBtn.BackgroundColor3 = dropCompassEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
dropCompassBtn.TextColor3 = Color3.new(1,1,1)
dropCompassBtn.Font = Enum.Font.GothamBold
dropCompassBtn.TextSize = 14
dropCompassBtn.LayoutOrder = 3
Instance.new("UICorner", dropCompassBtn).CornerRadius = UDim.new(0,6)

dropCompassBtn.MouseButton1Click:Connect(function()
    dropCompassEnabled = not dropCompassEnabled
    dropCompassBtn.Text = "🗺️ Drop Compass: " .. (dropCompassEnabled and "ON" or "OFF")
    dropCompassBtn.BackgroundColor3 = dropCompassEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    if dropCompassEnabled then
        startDropCompassLoop()
    end
end)

local function stopDropCompassLoop()
    dropCompassEnabled = false
    if dropCompassThread then
        task.cancel(dropCompassThread)
        dropCompassThread = nil
    end
end

local dropCompassBtn = Instance.new("TextButton", Content)
dropCompassBtn.Size = UDim2.new(1, -20, 0, 30)
dropCompassBtn.Text = "🗺️ Drop Compass: OFF"
dropCompassBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
dropCompassBtn.TextColor3 = Color3.new(1,1,1)
dropCompassBtn.Font = Enum.Font.GothamBold
dropCompassBtn.TextSize = 14
Instance.new("UICorner", dropCompassBtn).CornerRadius = UDim.new(0,6)

dropCompassBtn.MouseButton1Click:Connect(function()
    dropCompassEnabled = not dropCompassEnabled
    if dropCompassEnabled then
        dropCompassBtn.Text = "🗺️ Drop Compass: ON"
        dropCompassBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        startDropCompassLoop()
    else
        dropCompassBtn.Text = "🗺️ Drop Compass: OFF"
        dropCompassBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        stopDropCompassLoop()
    end
end)


    -----------------------------------------------------
    -- รายชื่อผล + ปุ่ม Spectate / Teleport
    -----------------------------------------------------
    local fruitList = Instance.new("ScrollingFrame", Content)
    fruitList.Size = UDim2.new(1, -10, 1, -50)
    fruitList.Position = UDim2.new(0,5,0,40)
    fruitList.CanvasSize = UDim2.new(0,0,0,0)
    fruitList.ScrollBarThickness = 6
    fruitList.BackgroundTransparency = 1
    fruitList.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local layout = Instance.new("UIListLayout", fruitList)
    layout.Padding = UDim.new(0,5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local function getFruitCFrame(fruit)
        if fruit:IsA("BasePart") then
            return fruit.CFrame
        elseif fruit:FindFirstChild("Handle") then
            return fruit.Handle.CFrame
        elseif fruit.PrimaryPart then
            return fruit.PrimaryPart.CFrame
        end
        return nil
    end

    local function stopSpectate()
        currentSpectate = nil
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        end
    end

    local function startSpectate(fruit)
        currentSpectate = fruit
        local target = fruit:FindFirstChild("Handle") or fruit.PrimaryPart or (fruit:IsA("BasePart") and fruit)
        if target then
            workspace.CurrentCamera.CameraSubject = target
        end
    end

    local function createFruitButton(fruit)
        local frame = Instance.new("Frame", fruitList)
        frame.Size = UDim2.new(1, -10, 0, 30)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BorderSizePixel = 0
        frame.Name = fruit.Name
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)

        local nameLabel = Instance.new("TextLabel", frame)
        nameLabel.Size = UDim2.new(0.5,0,1,0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = fruit.Name
        nameLabel.TextColor3 = Color3.new(1,1,1)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextScaled = false
        nameLabel.TextSize = 18

        local spectateBtn = Instance.new("TextButton", frame)
        spectateBtn.Size = UDim2.new(0.22,0,1,0)
        spectateBtn.Position = UDim2.new(0.55,0,0,0)
        spectateBtn.Text = "Spectate"
        spectateBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
        spectateBtn.TextColor3 = Color3.new(1,1,1)
        spectateBtn.Font = Enum.Font.GothamBold
        spectateBtn.TextScaled = true
        Instance.new("UICorner", spectateBtn).CornerRadius = UDim.new(0,6)

        spectateBtn.MouseButton1Click:Connect(function()
            if currentSpectate == fruit then
                stopSpectate()
                spectateBtn.Text = "Spectate"
                spectateBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
            else
                startSpectate(fruit)
                spectateBtn.Text = "Unspectate"
                spectateBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
            end
        end)

        local tpBtn = Instance.new("TextButton", frame)
        tpBtn.Size = UDim2.new(0.22,0,1,0)
        tpBtn.Position = UDim2.new(0.78,0,0,0)
        tpBtn.Text = "Teleport"
        tpBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
        tpBtn.TextColor3 = Color3.new(1,1,1)
        tpBtn.Font = Enum.Font.GothamBold
        tpBtn.TextScaled = true
        Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,6)

        tpBtn.MouseButton1Click:Connect(function()
            local cf = getFruitCFrame(fruit)
            if cf and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = cf + Vector3.new(0,5,0)
            end
        end)
    end

    -----------------------------------------------------
    -- ฟังก์ชัน Refresh เรียงผล A-Z
    -----------------------------------------------------
    local function RefreshFruitList()
        for _, child in ipairs(fruitList:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        local fruits = {}
        for _, obj in pairs(workspace:GetChildren()) do
            if string.find(obj.Name, "Fruit") then
                table.insert(fruits, obj)
            end
        end

        table.sort(fruits, function(a,b) return a.Name:lower() < b.Name:lower() end)

        for _, fruit in ipairs(fruits) do
            createFruitButton(fruit)
        end
    end

    RefreshFruitList()

    workspace.ChildAdded:Connect(function(obj)
        if string.find(obj.Name, "Fruit") then
            task.wait(0.2)
            RefreshFruitList()
        end
    end)
    workspace.ChildRemoved:Connect(function(obj)
        if string.find(obj.Name, "Fruit") then
            task.wait(0.1)
            RefreshFruitList()
        end
    end)

end


----------------------------------------------------------------
-- SERVER TAB (FULL FIXED with Save Settings + Hide UI)
----------------------------------------------------------------

-- ✅ Global UI Toggle Key (RightAlt by default)
if not getgenv().UIKey then
    getgenv().UIKey = Enum.KeyCode.RightAlt
end

-- ✅ Bind toggle UI (ป้องกันซ้ำ)
-- Smooth Hide UI Key: disconnect event ก่อน bind ใหม่
if getgenv()._UIHideConn then
    pcall(function() getgenv()._UIHideConn:Disconnect() end)
    getgenv()._UIHideConn = nil
end
getgenv()._UIHideConn = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == getgenv().UIKey then
        if MainFrame then
            MainFrame.Visible = not MainFrame.Visible
        end
    end
end)

-- ✅ เก็บเวลาเข้าเซิร์ฟครั้งแรก
if not getgenv().ServerJoinTime then
    getgenv().ServerJoinTime = os.time()
end

-- ✅ ถ้ามี SavedStates (ตอน Rejoin/Hop) โหลดกลับมา
if getgenv().SavedStates then
    States = getgenv().SavedStates
end

local function LoadServerTab()
    -- ปุ่มคัดลอก accessCode ทั้ง 3 แบบ เรียงแนวตั้งติดกัน
    -- ปุ่มคัดลอก accessCode ทั้ง 3 แบบ แยกกัน ไม่ต้องรวม
    -- ปุ่ม 1: คัดลอกจากช่องกรอก
    local copyBoxBtn = Instance.new("TextButton")
    copyBoxBtn.Parent = Content
    copyBoxBtn.Size = UDim2.new(1, -20, 0, 32)
    copyBoxBtn.Position = UDim2.new(0,0,0,0)
    copyBoxBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 220)
    copyBoxBtn.TextColor3 = Color3.fromRGB(255,255,255)
    copyBoxBtn.Font = Enum.Font.GothamBold
    copyBoxBtn.TextSize = 15
    copyBoxBtn.Text = "คัดลอกช่องนี้"
    copyBoxBtn.LayoutOrder = 1001
    Instance.new("UICorner", copyBoxBtn).CornerRadius = UDim.new(0,8)
    local pad1 = Instance.new("UIPadding", copyBoxBtn)
    pad1.PaddingTop = UDim.new(0,2)
    pad1.PaddingBottom = UDim.new(0,2)
    copyBoxBtn.MouseButton1Click:Connect(function()
        if codeBox and codeBox.Text and #codeBox.Text > 0 then
            setclipboard(codeBox.Text)
            copyBoxBtn.Text = "คัดลอกแล้ว!" wait(1.2) copyBoxBtn.Text = "คัดลอกช่องนี้"
        else
            copyBoxBtn.Text = "ช่องว่าง" wait(1.2) copyBoxBtn.Text = "คัดลอกช่องนี้"
        end
    end)

    -- ปุ่ม 2: คัดลอก accessCode ล่าสุด
    local copyLastBtn = Instance.new("TextButton")
    copyLastBtn.Parent = Content
    copyLastBtn.Size = UDim2.new(1, -20, 0, 32)
    copyLastBtn.Position = UDim2.new(0,0,0,0)
    copyLastBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
    copyLastBtn.TextColor3 = Color3.fromRGB(255,255,255)
    copyLastBtn.Font = Enum.Font.GothamBold
    copyLastBtn.TextSize = 15
    copyLastBtn.Text = "คัดลอก accessCode ล่าสุด"
    copyLastBtn.LayoutOrder = 1002
    Instance.new("UICorner", copyLastBtn).CornerRadius = UDim.new(0,8)
    local pad2 = Instance.new("UIPadding", copyLastBtn)
    pad2.PaddingTop = UDim.new(0,2)
    pad2.PaddingBottom = UDim.new(0,2)
    copyLastBtn.MouseButton1Click:Connect(function()
        if getgenv().LastAccessCode and #getgenv().LastAccessCode > 10 then
            setclipboard(getgenv().LastAccessCode)
            copyLastBtn.Text = "คัดลอกแล้ว!" wait(1.2) copyLastBtn.Text = "คัดลอก accessCode ล่าสุด"
        else
            copyLastBtn.Text = "ไม่พบโค้ด" wait(1.2) copyLastBtn.Text = "คัดลอก accessCode ล่าสุด"
        end
    end)

    -- ปุ่ม 3: คัดลอก accessCode เซิร์ฟนี้
    local copyCurrentBtn = Instance.new("TextButton")
    copyCurrentBtn.Parent = Content
    copyCurrentBtn.Size = UDim2.new(1, -20, 0, 32)
    copyCurrentBtn.Position = UDim2.new(0,0,0,0)
    copyCurrentBtn.BackgroundColor3 = Color3.fromRGB(200, 180, 60)
    copyCurrentBtn.TextColor3 = Color3.fromRGB(40,40,40)
    copyCurrentBtn.Font = Enum.Font.GothamBold
    copyCurrentBtn.TextSize = 15
    copyCurrentBtn.Text = "คัดลอก accessCode เซิร์ฟนี้"
    copyCurrentBtn.LayoutOrder = 1003
    Instance.new("UICorner", copyCurrentBtn).CornerRadius = UDim.new(0,8)
    local pad3 = Instance.new("UIPadding", copyCurrentBtn)
    pad3.PaddingTop = UDim.new(0,2)
    pad3.PaddingBottom = UDim.new(0,2)
    copyCurrentBtn.MouseButton1Click:Connect(function()
        if game.PrivateServerId ~= "" or game.VIPServerId ~= nil then
            local accessCode, _ = GenerateReservedServerCode(game.PlaceId)
            setclipboard(accessCode)
            copyCurrentBtn.Text = "คัดลอกแล้ว!" wait(1.2) copyCurrentBtn.Text = "คัดลอก accessCode เซิร์ฟนี้"
        else
            copyCurrentBtn.Text = "ไม่ใช่ private server" wait(1.2) copyCurrentBtn.Text = "คัดลอก accessCode เซิร์ฟนี้"
        end
    end)
    -- ปุ่มคัดลอก accessCode ของปัจจุบัน (เฉพาะคัดลอก ไม่วาร์ป) - ล่างสุด
    local function addCopyCurrentAccessCodeButton()
        local copyOnlyBtn = Instance.new("TextButton", Content)
        copyOnlyBtn.Size = UDim2.new(1, -20, 0, 32)
        copyOnlyBtn.LayoutOrder = 9999 -- ให้ไปอยู่ล่างสุดเสมอ
        copyOnlyBtn.Text = "คัดลอก accessCode ของปัจจุบัน"
        copyOnlyBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        copyOnlyBtn.TextColor3 = Color3.fromRGB(255,255,255)
        copyOnlyBtn.Font = Enum.Font.GothamBold
        copyOnlyBtn.TextSize = 15
        Instance.new("UICorner", copyOnlyBtn).CornerRadius = UDim.new(0,8)
        copyOnlyBtn.MouseButton1Click:Connect(function()
            if getgenv().LastAccessCode and #getgenv().LastAccessCode > 10 then
                setclipboard(getgenv().LastAccessCode)
                copyOnlyBtn.Text = "คัดลอกแล้ว!"
                wait(1.2)
                copyOnlyBtn.Text = "คัดลอก accessCode ของปัจจุบัน"
            else
                copyOnlyBtn.Text = "ไม่พบ accessCode ปัจจุบัน"
                wait(1.2)
                copyOnlyBtn.Text = "คัดลอก accessCode ของปัจจุบัน"
            end
        end)
    end
    addCopyCurrentAccessCodeButton()
    -- ปุ่มวาร์ป/คัดลอก accessCode ปัจจุบันของเซิฟเวอร์
    local warpCopyCurrentBtn = Instance.new("TextButton", Content)
    warpCopyCurrentBtn.Size = UDim2.new(1, -20, 0, 32)
    warpCopyCurrentBtn.Position = UDim2.new(0,0,0,460)
    warpCopyCurrentBtn.Text = "วาร์ป/คัดลอก accessCodeปัจจุบันของเซิฟเวอร์"
    warpCopyCurrentBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    warpCopyCurrentBtn.TextColor3 = Color3.fromRGB(255,255,255)
    warpCopyCurrentBtn.Font = Enum.Font.GothamBold
    warpCopyCurrentBtn.TextSize = 15
    Instance.new("UICorner", warpCopyCurrentBtn).CornerRadius = UDim.new(0,8)

    warpCopyCurrentBtn.MouseButton1Click:Connect(function()
        if getgenv().LastAccessCode and #getgenv().LastAccessCode > 10 then
            setclipboard(getgenv().LastAccessCode)
            game.RobloxReplicatedStorage.ContactListIrisInviteTeleport:FireServer(game.PlaceId, "", getgenv().LastAccessCode)
            warpCopyCurrentBtn.Text = "คัดลอก+วาร์ปแล้ว!"
            wait(1.2)
            warpCopyCurrentBtn.Text = "วาร์ป/คัดลอก accessCodeปัจจุบันของเซิฟเวอร์"
        else
            warpCopyCurrentBtn.Text = "ไม่พบ accessCode ปัจจุบัน"
            wait(1.2)
            warpCopyCurrentBtn.Text = "วาร์ป/คัดลอก accessCodeปัจจุบันของเซิฟเวอร์"
        end
    end)
    -- ปุ่มคัดลอก accessCode ปัจจุบัน (ถ้ามี)
    local copyCurrentBtn = Instance.new("TextButton", Content)
    copyCurrentBtn.Size = UDim2.new(1, -20, 0, 32)
    copyCurrentBtn.Position = UDim2.new(0,0,0,420)
    copyCurrentBtn.Text = "คัดลอกเซิฟปัจจุบัน"
    copyCurrentBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 40)
    copyCurrentBtn.TextColor3 = Color3.fromRGB(255,255,255)
    copyCurrentBtn.Font = Enum.Font.GothamBold
    copyCurrentBtn.TextSize = 15
    Instance.new("UICorner", copyCurrentBtn).CornerRadius = UDim.new(0,8)

    copyCurrentBtn.MouseButton1Click:Connect(function()
        if getgenv().LastAccessCode and #getgenv().LastAccessCode > 10 then
            setclipboard(getgenv().LastAccessCode)
            copyCurrentBtn.Text = "คัดลอกแล้ว!"
            wait(1.2)
            copyCurrentBtn.Text = "คัดลอกเซิฟปัจจุบัน"
        else
            copyCurrentBtn.Text = "ไม่พบ accessCode ปัจจุบัน"
            wait(1.2)
            copyCurrentBtn.Text = "คัดลอกเซิฟปัจจุบัน"
        end
    end)
    ClearContent()

    ----------------------------------------------------------------
    -- Label แสดงข้อมูล
    ----------------------------------------------------------------
    local infoLabel = Instance.new("TextLabel", Content)
    infoLabel.Size = UDim2.new(1, -20, 0, 40)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextColor3 = Color3.new(1,1,1)
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.TextSize = 14
    infoLabel.Text = "Loading..."
    infoLabel.TextYAlignment = Enum.TextYAlignment.Top

    task.spawn(function()
        while task.wait(1) do
            infoLabel.Text =
                "Rejoin Count: "..tostring(getgenv().RejoinCount or 0)..
                "\nHop Count: "..tostring(getgenv().HopCount or 0)
        end
    end)

    ----------------------------------------------------------------
    -- ฟังก์ชันช่วยบันทึกค่าและเตรียม queue_on_teleport
    ----------------------------------------------------------------
    local function teleportWithSave(callback)
        if getgenv().SaveSettings then
            local HttpService = game:GetService("HttpService")
            getgenv().SavedStates = States
            getgenv().SavedStatesJSON = HttpService:JSONEncode(States)
        else
            getgenv().SavedStates = nil
            getgenv().SavedStatesJSON = nil
        end

        local savedStr = getgenv().SavedStatesJSON and
            (string.format("game:GetService('HttpService'):JSONDecode([[%s]])", getgenv().SavedStatesJSON))
            or "nil"

        queue_on_teleport([[
            getgenv().RejoinCount = ]]..(getgenv().RejoinCount or 0)..[[;
            getgenv().HopCount = ]]..(getgenv().HopCount or 0)..[[;
            getgenv().UIKey = Enum.KeyCode.]]..getgenv().UIKey.Name..[[;
            getgenv().ServerJoinTime = os.time();
            getgenv().SavedStates = ]]..savedStr..[[
            -- (ลบ loadstring ออก ไม่ต้องรันสคริปต์ซ้ำตอน Hop)
            if getgenv().SavedStates then
                States = getgenv().SavedStates
            end
            MainFrame.Visible = true
        ]])

        callback()
    end

    ----------------------------------------------------------------
    -- REJOIN BUTTON
    ----------------------------------------------------------------
    local rejoinBtn = Instance.new("TextButton", Content)
    rejoinBtn.Size = UDim2.new(1, -20, 0, 30)
    rejoinBtn.Position = UDim2.new(0,0,0,50)
    rejoinBtn.Text = "Rejoin Server"
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    rejoinBtn.TextColor3 = Color3.fromRGB(255,255,255)
    rejoinBtn.Font = Enum.Font.GothamBold
    rejoinBtn.TextSize = 14
    Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0,6)

    rejoinBtn.MouseButton1Click:Connect(function()
        getgenv().RejoinCount = (getgenv().RejoinCount or 0) + 1
        teleportWithSave(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(
                game.PlaceId, game.JobId, game.Players.LocalPlayer
            )
        end)
    end)

    ----------------------------------------------------------------
    -- SERVER HOP BUTTON
    ----------------------------------------------------------------
    local hopBtn = rejoinBtn:Clone()
    hopBtn.Parent = Content
    hopBtn.Position = UDim2.new(0,0,0,90)
    hopBtn.Text = "Server Hop"

    hopBtn.MouseButton1Click:Connect(function()
        getgenv().HopCount = (getgenv().HopCount or 0) + 1
        teleportWithSave(function()
            local HttpService = game:GetService("HttpService")
            local servers = HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
            ))

            for _,srv in ipairs(servers.data) do
                if srv.id ~= game.JobId and srv.playing < srv.maxPlayers then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, srv.id, game.Players.LocalPlayer)
                end
            end
        end)
    end)

    -- ปุ่มคัดลอก Teleport code ของเซิร์ฟเวอร์ปัจจุบัน
    local teleportCodeBtn = Instance.new("TextButton")
    teleportCodeBtn.Parent = Content
    teleportCodeBtn.Size = UDim2.new(1, -20, 0, 32)
    teleportCodeBtn.Position = UDim2.new(0,0,0,0)
    teleportCodeBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 220)
    teleportCodeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    teleportCodeBtn.Font = Enum.Font.GothamBold
    teleportCodeBtn.TextSize = 15
    teleportCodeBtn.Text = "คัดลอก Teleport Code เซิร์ฟนี้"
    teleportCodeBtn.LayoutOrder = 101
    Instance.new("UICorner", teleportCodeBtn).CornerRadius = UDim.new(0,8)
    local padTeleport = Instance.new("UIPadding", teleportCodeBtn)
    padTeleport.PaddingTop = UDim.new(0,2)
    padTeleport.PaddingBottom = UDim.new(0,2)
    teleportCodeBtn.MouseButton1Click:Connect(function()
        local placeId = game.PlaceId
        local jobId = game.JobId
        local teleportCode = string.format(
            'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s")',
            placeId, jobId
        )
        setclipboard(teleportCode)
        teleportCodeBtn.Text = "คัดลอกแล้ว!" wait(1.2) teleportCodeBtn.Text = "คัดลอก Teleport Code เซิร์ฟนี้"
        print("[COPY] โค้ด Teleport ถูกก๊อปปี้แล้ว:")
        print(teleportCode)
    end)

    -- ช่องกรอก/วาง Teleport code
    local teleportCodeBox = Instance.new("TextBox")
    teleportCodeBox.Parent = Content
    teleportCodeBox.Size = UDim2.new(1, -20, 0, 32)
    teleportCodeBox.Position = UDim2.new(0,0,0,0)
    teleportCodeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    teleportCodeBox.TextColor3 = Color3.fromRGB(255,255,255)
    teleportCodeBox.Font = Enum.Font.Gotham
    teleportCodeBox.TextSize = 15
    teleportCodeBox.PlaceholderText = "วาง Teleport Code ที่นี่..."
    teleportCodeBox.Text = ""
    teleportCodeBox.LayoutOrder = 102
    Instance.new("UICorner", teleportCodeBox).CornerRadius = UDim.new(0,8)

    -- ปุ่มวาร์ปด้วย Teleport Code
    local teleportGoBtn = Instance.new("TextButton")
    teleportGoBtn.Parent = Content
    teleportGoBtn.Size = UDim2.new(1, -20, 0, 32)
    teleportGoBtn.Position = UDim2.new(0,0,0,0)
    teleportGoBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 180)
    teleportGoBtn.TextColor3 = Color3.fromRGB(255,255,255)
    teleportGoBtn.Font = Enum.Font.GothamBold
    teleportGoBtn.TextSize = 15
    teleportGoBtn.Text = "วาร์ปด้วย Teleport Code"
    teleportGoBtn.LayoutOrder = 103
    Instance.new("UICorner", teleportGoBtn).CornerRadius = UDim.new(0,8)
    local padGo = Instance.new("UIPadding", teleportGoBtn)
    padGo.PaddingTop = UDim.new(0,2)
    padGo.PaddingBottom = UDim.new(0,2)
    teleportGoBtn.MouseButton1Click:Connect(function()
        local code = teleportCodeBox.Text
        if code and code:find("TeleportToPlaceInstance") then
            local ok,err = pcall(function()
                loadstring(code)()
            end)
            if ok then
                teleportGoBtn.Text = "กำลังวาร์ป..."
            else
                teleportGoBtn.Text = "โค้ดผิดพลาด!"
                wait(1.2)
                teleportGoBtn.Text = "วาร์ปด้วย Teleport Code"
            end
        else
            teleportGoBtn.Text = "กรุณาใส่โค้ดให้ถูก!"
            wait(1.2)
            teleportGoBtn.Text = "วาร์ปด้วย Teleport Code"
        end
    end)

    ----------------------------------------------------------------
    -- HIDE UI TOGGLE KEY BUTTON
    ----------------------------------------------------------------
    local hideKeyBtn = rejoinBtn:Clone()
    hideKeyBtn.Parent = Content
    hideKeyBtn.Position = UDim2.new(0,0,0,130)
    hideKeyBtn.Text = "Hide UI Key (Now: "..(getgenv().UIKey and getgenv().UIKey.Name or "RightAlt")..")"

    hideKeyBtn.MouseButton1Click:Connect(function()
        hideKeyBtn.Text = "Press a key..."
        local conn; conn = game:GetService("UserInputService").InputBegan:Connect(function(input,gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                getgenv().UIKey = input.KeyCode
                hideKeyBtn.Text = "Hide UI Key (Now: "..getgenv().UIKey.Name..")"
                conn:Disconnect()
            end
        end)
    end)

    ----------------------------------------------------------------
    -- SAVE SETTINGS BUTTON
    ----------------------------------------------------------------
    local saveBtn = rejoinBtn:Clone()
    saveBtn.Parent = Content
    saveBtn.Position = UDim2.new(0,0,0,170)
    saveBtn.Text = "Save Settings: " .. (getgenv().SaveSettings and "ON" or "OFF")

    saveBtn.MouseButton1Click:Connect(function()
        getgenv().SaveSettings = not getgenv().SaveSettings
        saveBtn.Text = "Save Settings: " .. (getgenv().SaveSettings and "ON" or "OFF")
    end)

    -- ✅ Label อธิบายใต้ปุ่ม Save Settings (2 บรรทัด)
    local saveInfo1 = Instance.new("TextLabel", Content)
    saveInfo1.Size = UDim2.new(1, -20, 0, 20)
    saveInfo1.Position = UDim2.new(0,0,0,210)
    saveInfo1.BackgroundTransparency = 1
    saveInfo1.TextColor3 = Color3.fromRGB(200,200,200)
    saveInfo1.Font = Enum.Font.Gotham
    saveInfo1.TextSize = 12
    saveInfo1.TextWrapped = true
    saveInfo1.Text = "(Enable to auto-save all UI settings when activated)"

    local saveInfo2 = Instance.new("TextLabel", Content)
    saveInfo2.Size = UDim2.new(1, -20, 0, 20)
    saveInfo2.Position = UDim2.new(0,0,0,230)
    saveInfo2.BackgroundTransparency = 1
    saveInfo2.TextColor3 = Color3.fromRGB(200,200,200)
    saveInfo2.Font = Enum.Font.Gotham
    saveInfo2.TextSize = 12
    saveInfo2.TextWrapped = true
    saveInfo2.Text = "(Takes effect when you Rejoin/Hop server)"

    -- =====================
    -- ช่องใส่ accessCode และปุ่มวาร์ป
    -- =====================
    local codeBox = Instance.new("TextBox", Content)
    codeBox.Size = UDim2.new(1, -20, 0, 36)
    codeBox.Position = UDim2.new(0,0,0,305)
    codeBox.PlaceholderText = "ใส่ accessCode ที่นี่ (เช่น YKwI2ExFazoBu_2onJgUknXlr603RUJ7k1PO94-bBcTU4IxxJH0AAA2)"
    codeBox.Text = ""
    codeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    codeBox.TextColor3 = Color3.fromRGB(255,255,255)
    codeBox.Font = Enum.Font.Gotham
    codeBox.TextSize = 16
    codeBox.ClearTextOnFocus = false
    Instance.new("UICorner", codeBox).CornerRadius = UDim.new(0,8)

    local teleportBtn = Instance.new("TextButton", Content)
    teleportBtn.Size = UDim2.new(1, -20, 0, 36)
    teleportBtn.Position = UDim2.new(0,0,0,345)
    teleportBtn.Text = "วาร์ปด้วย accessCode"
    teleportBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
    teleportBtn.TextColor3 = Color3.fromRGB(255,255,255)
    teleportBtn.Font = Enum.Font.GothamBold
    teleportBtn.TextSize = 16
    Instance.new("UICorner", teleportBtn).CornerRadius = UDim.new(0,8)

    teleportBtn.MouseButton1Click:Connect(function()
        local code = codeBox.Text
        if code and #code > 10 then
            -- FireServer ด้วย accessCode ที่กรอก
            game.RobloxReplicatedStorage.ContactListIrisInviteTeleport:FireServer(game.PlaceId, "", code)
            teleportBtn.Text = "ส่งโค้ดแล้ว! (ถ้าโค้ดถูกต้องจะวาร์ป)"
            wait(1.2)
            teleportBtn.Text = "วาร์ปด้วย accessCode"
        else
            teleportBtn.Text = "กรุณาใส่ accessCode ที่ถูกต้อง"
            wait(1.2)
            teleportBtn.Text = "วาร์ปด้วย accessCode"
        end
    end)

    -- =====================
    -- ปุ่ม Serverส่วนตัวฟามได้ปกติ
    -- =====================
    local farmServerBtn = Instance.new("TextButton", Content)
    farmServerBtn.Size = UDim2.new(1, -20, 0, 36)
    farmServerBtn.Position = UDim2.new(0,0,0,260)
    farmServerBtn.Text = "Serverส่วนตัวฟามได้ปกติ (คัดลอกโค้ด)"
    farmServerBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
    farmServerBtn.TextColor3 = Color3.fromRGB(255,255,255)
    farmServerBtn.Font = Enum.Font.GothamBold
    farmServerBtn.TextSize = 16
    Instance.new("UICorner", farmServerBtn).CornerRadius = UDim.new(0,8)

    -- ฟังก์ชันสร้าง accessCode (ยกโค้ดจากสคริปต์ที่ให้มา)
    local function GenerateReservedServerCode(placeId)
        local md5 = {}
        local hmac = {}
        local base64 = {}
        do
            local T = {
                0xd76aa478,0xe8c7b756,0x242070db,0xc1bdceee,0xf57c0faf,0x4787c62a,0xa8304613,0xfd469501,
                0x698098d8,0x8b44f7af,0xffff5bb1,0x895cd7be,0x6b901122,0xfd987193,0xa679438e,0x49b40821,
                0xf61e2562,0xc040b340,0x265e5a51,0xe9b6c7aa,0xd62f105d,0x02441453,0xd8a1e681,0xe7d3fbc8,
                0x21e1cde6,0xc33707d6,0xf4d50d87,0x455a14ed,0xa9e3e905,0xfcefa3f8,0x676f02d9,0x8d2a4c8a,
                0xfffa3942,0x8771f681,0x6d9d6122,0xfde5380c,0xa4beea44,0x4bdecfa9,0xf6bb4b60,0xbebfbc70,
                0x289b7ec6,0xeaa127fa,0xd4ef3085,0x04881d05,0xd9d4d039,0xe6db99e5,0x1fa27cf8,0xc4ac5665,
                0xf4292244,0x432aff97,0xab9423a7,0xfc93a039,0x655b59c3,0x8f0ccc92,0xffeff47d,0x85845dd1,
                0x6fa87e4f,0xfe2ce6e0,0xa3014314,0x4e0811a1,0xf7537e82,0xbd3af235,0x2ad7d2bb,0xeb86d391,
            }
            local function add(a, b)
                local lsw = bit32.band(a, 0xFFFF) + bit32.band(b, 0xFFFF)
                local msw = bit32.rshift(a, 16) + bit32.rshift(b, 16) + bit32.rshift(lsw, 16)
                return bit32.bor(bit32.lshift(msw, 16), bit32.band(lsw, 0xFFFF))
            end
            local function rol(x, n)
                return bit32.bor(bit32.lshift(x, n), bit32.rshift(x, 32 - n))
            end
            local function F(x, y, z) return bit32.bor(bit32.band(x, y), bit32.band(bit32.bnot(x), z)) end
            local function G(x, y, z) return bit32.bor(bit32.band(x, z), bit32.band(y, bit32.bnot(z))) end
            local function H(x, y, z) return bit32.bxor(x, bit32.bxor(y, z)) end
            local function I(x, y, z) return bit32.bxor(y, bit32.bor(x, bit32.bnot(z))) end
            function md5.sum(message)
                local a, b, c, d = 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476
                local message_len = #message
                local padded_message = message .. "\128"
                while #padded_message % 64 ~= 56 do padded_message = padded_message .. "\0" end
                local len_bytes = ""
                local len_bits = message_len * 8
                for i = 0, 7 do len_bytes = len_bytes .. string.char(bit32.band(bit32.rshift(len_bits, i * 8), 0xFF)) end
                padded_message = padded_message .. len_bytes
                for i = 1, #padded_message, 64 do
                    local chunk = padded_message:sub(i, i + 63)
                    local X = {}
                    for j = 0, 15 do
                        local b1, b2, b3, b4 = chunk:byte(j * 4 + 1, j * 4 + 4)
                        X[j] = bit32.bor(b1, bit32.lshift(b2, 8), bit32.lshift(b3, 16), bit32.lshift(b4, 24))
                    end
                    local aa, bb, cc, dd = a, b, c, d
                    local s = { 7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10, 15, 21 }
                    for j = 0, 63 do
                        local f, k, shift_index
                        if j < 16 then f = F(b, c, d) k = j shift_index = j % 4
                        elseif j < 32 then f = G(b, c, d) k = (1 + 5 * j) % 16 shift_index = 4 + (j % 4)
                        elseif j < 48 then f = H(b, c, d) k = (5 + 3 * j) % 16 shift_index = 8 + (j % 4)
                        else f = I(b, c, d) k = (7 * j) % 16 shift_index = 12 + (j % 4) end
                        local temp = add(a, f)
                        temp = add(temp, X[k])
                        temp = add(temp, T[j + 1])
                        temp = rol(temp, s[shift_index + 1])
                        local new_b = add(b, temp)
                        a, b, c, d = d, new_b, b, c
                    end
                    a = add(a, aa)
                    b = add(b, bb)
                    c = add(c, cc)
                    d = add(d, dd)
                end
                local function to_le_hex(n)
                    local s = ""
                    for i = 0, 3 do s = s .. string.char(bit32.band(bit32.rshift(n, i * 8), 0xFF)) end
                    return s
                end
                return to_le_hex(a) .. to_le_hex(b) .. to_le_hex(c) .. to_le_hex(d)
            end
        end
        do
            function hmac.new(key, msg, hash_func)
                if #key > 64 then key = hash_func(key) end
                local o_key_pad, i_key_pad = "", ""
                for i = 1, 64 do
                    local byte = (i <= #key and string.byte(key, i)) or 0
                    o_key_pad = o_key_pad .. string.char(bit32.bxor(byte, 0x5C))
                    i_key_pad = i_key_pad .. string.char(bit32.bxor(byte, 0x36))
                end
                return hash_func(o_key_pad .. hash_func(i_key_pad .. msg))
            end
        end
        do
            local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
            function base64.encode(data)
                return ((data:gsub(".", function(x)
                    local r, b_val = "", x:byte()
                    for i = 8, 1, -1 do r = r .. (b_val % 2 ^ i - b_val % 2 ^ (i - 1) > 0 and "1" or "0") end
                    return r
                end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
                    if #x < 6 then return "" end
                    local c = 0
                    for i = 1, 6 do c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0) end
                    return b:sub(c + 1, c + 1)
                end) .. ({ "", "==", "=" })[#data % 3 + 1])
            end
        end
        local uuid = {}
        for i = 1, 16 do uuid[i] = math.random(0, 255) end
        uuid[7] = bit32.bor(bit32.band(uuid[7], 0x0F), 0x40)
        uuid[9] = bit32.bor(bit32.band(uuid[9], 0x3F), 0x80)
        local firstBytes = ""
        for i = 1, 16 do firstBytes = firstBytes .. string.char(uuid[i]) end
        local gameCode = string.format("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x", table.unpack(uuid))
        local placeIdBytes = ""
        local pIdRec = placeId
        for _ = 1, 8 do placeIdBytes = placeIdBytes .. string.char(pIdRec % 256) pIdRec = math.floor(pIdRec / 256) end
        local content = firstBytes .. placeIdBytes
        local key = "e4Yn8ckbCJtw2sv7qmbg"
        local signature = hmac.new(key, content, md5.sum)
        local accessCodeBytes = signature .. content
        local accessCode = base64.encode(accessCodeBytes)
        accessCode = accessCode:gsub("+", "-"):gsub("/", "_")
        local pdding = 0
        accessCode, _ = accessCode:gsub("=", function() pdding = pdding + 1 return "" end)
        accessCode = accessCode .. tostring(pdding)
        return accessCode, gameCode
    end

    farmServerBtn.MouseButton1Click:Connect(function()
        local accessCode = GenerateReservedServerCode(game.PlaceId)
        setclipboard(accessCode)
        farmServerBtn.Text = "คัดลอก+เติมช่องแล้ว! (กดอีกครั้งเพื่อสร้างใหม่)"
        -- เติมลงในช่องกรอกอัตโนมัติ
        if codeBox then codeBox.Text = accessCode end
        wait(1.2)
        farmServerBtn.Text = "Serverส่วนตัวฟามได้ปกติ (คัดลอกโค้ด)"
    end)

    -- =====================
    -- ช่องแสดง accessCode ที่ใช้งานในเซิร์ฟเวอร์นี้
    -- =====================
    local currentCodeLabel = Instance.new("TextLabel", Content)
    currentCodeLabel.Size = UDim2.new(1, -20, 0, 28)
    currentCodeLabel.Position = UDim2.new(0,0,0,385)
    currentCodeLabel.BackgroundTransparency = 1
    currentCodeLabel.TextColor3 = Color3.fromRGB(255,255,180)
    currentCodeLabel.Font = Enum.Font.GothamBold
    currentCodeLabel.TextSize = 14
    currentCodeLabel.TextWrapped = true
    currentCodeLabel.Text = "AccessCode ปัจจุบัน: กำลังตรวจสอบ..."

    -- ฟังก์ชันตรวจสอบ accessCode ปัจจุบัน (ดูจาก JobId/PlaceId)
    local function checkCurrentAccessCode()
        -- ปกติ Roblox ไม่มี API ให้ดู accessCode ปัจจุบันตรงๆ ต้องใช้วิธีจำค่าตอนวาร์ป
        -- สมมุติว่าเก็บไว้ใน getgenv().LastAccessCode ถ้ามีการวาร์ปด้วยโค้ดนี้
        if getgenv().LastAccessCode and #getgenv().LastAccessCode > 10 then
            currentCodeLabel.Text = "AccessCode ปัจจุบัน: "..getgenv().LastAccessCode.." (อาจยังใช้ได้)"
        else
            currentCodeLabel.Text = "AccessCode ปัจจุบัน: ไม่พบ/หมดอายุ หรือไม่ได้วาร์ปด้วยโค้ดนี้"
        end
    end
    checkCurrentAccessCode()

    -- เมื่อกดปุ่มวาร์ปด้วย accessCode ให้จำค่าไว้
    teleportBtn.MouseButton1Click:Connect(function()
        local code = codeBox.Text
        if code and #code > 10 then
            getgenv().LastAccessCode = code
            checkCurrentAccessCode()
        end
    end)

end

-- ===================== MISC TAB (FULL) ======================
local function LoadMiscTab()
    ClearContent()

    ----------------------------------------------------------------
    -- AUTO CHEST (FAST MODE)
    ----------------------------------------------------------------
    local chestThread = nil
    local function StartChestThread()
        if chestThread then task.cancel(chestThread) end
        chestThread = task.spawn(function()
            while States.Misc.AutoChest do
                local chests = workspace:FindFirstChild("Chests")
                if chests and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    for _, chest in ipairs(chests:GetChildren()) do
                        if not States.Misc.AutoChest then break end
                        if chest:IsA("Model") and chest.PrimaryPart then
                            player.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame + Vector3.new(0,3,0)
                            task.wait(0.1)
                        end
                    end
                end
                task.wait(0.2)
            end
        end)
    end

    local chestBtn = Instance.new("TextButton", Content)
    chestBtn.Size = UDim2.new(1, -20, 0, 30)
    chestBtn.Text = "Auto Chest: " .. (States.Misc.AutoChest and "ON" or "OFF")
    chestBtn.BackgroundColor3 = States.Misc.AutoChest and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    chestBtn.TextColor3 = Color3.fromRGB(255,255,255)
    chestBtn.Font = Enum.Font.GothamBold
    chestBtn.TextSize = 14
    Instance.new("UICorner", chestBtn).CornerRadius = UDim.new(0,6)

    chestBtn.MouseButton1Click:Connect(function()
        States.Misc.AutoChest = not States.Misc.AutoChest
        chestBtn.Text = "Auto Chest: "..(States.Misc.AutoChest and "ON" or "OFF")
        chestBtn.BackgroundColor3 = States.Misc.AutoChest and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        if States.Misc.AutoChest then StartChestThread()
        else if chestThread then task.cancel(chestThread) chestThread = nil end end
    end)

    ----------------------------------------------------------------
    -- NOCLIP
    ----------------------------------------------------------------
    local noclipBtn = Instance.new("TextButton", Content)
    noclipBtn.Size = UDim2.new(1, -20, 0, 30)
    noclipBtn.BackgroundColor3 = States.Misc.Noclip and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    noclipBtn.Text = "Noclip: "..(States.Misc.Noclip and "ON" or "OFF")
    noclipBtn.Font = Enum.Font.GothamBold
    noclipBtn.TextSize = 14
    noclipBtn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0,6)

    noclipBtn.MouseButton1Click:Connect(function()
        States.Misc.Noclip = not States.Misc.Noclip
        noclipBtn.BackgroundColor3 = States.Misc.Noclip and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        noclipBtn.Text = "Noclip: "..(States.Misc.Noclip and "ON" or "OFF")
    end)

    ----------------------------------------------------------------
    -- CLICK TP
    ----------------------------------------------------------------
    local ctpBtn = Instance.new("TextButton", Content)
    ctpBtn.Size = UDim2.new(1, -20, 0, 30)
    ctpBtn.BackgroundColor3 = States.Misc.ClickTP and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    ctpBtn.Text = "ClickTP: "..(States.Misc.ClickTP and "ON" or "OFF")
    ctpBtn.Font = Enum.Font.GothamBold
    ctpBtn.TextSize = 14
    ctpBtn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", ctpBtn).CornerRadius = UDim.new(0,6)

    ctpBtn.MouseButton1Click:Connect(function()
        States.Misc.ClickTP = not States.Misc.ClickTP
        ctpBtn.BackgroundColor3 = States.Misc.ClickTP and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        ctpBtn.Text = "ClickTP: "..(States.Misc.ClickTP and "ON" or "OFF")
    end)

----------------------------------------------------------------
-- CLICK TP KEYBIND TOGGLE
----------------------------------------------------------------
-- ค่า Default = RightControl
States.Misc.ClickTPKey = States.Misc.ClickTPKey or Enum.KeyCode.RightControl
local listeningForToggleKey = false

local toggleKeyBtn = Instance.new("TextButton", Content)
toggleKeyBtn.Size = UDim2.new(1, -20, 0, 30)
toggleKeyBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
toggleKeyBtn.Text = "Set Toggle Key (Now: "..States.Misc.ClickTPKey.Name..")"
toggleKeyBtn.Font = Enum.Font.GothamBold
toggleKeyBtn.TextSize = 14
toggleKeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", toggleKeyBtn).CornerRadius = UDim.new(0,6)

-- เวลาเปลี่ยนปุ่ม
toggleKeyBtn.MouseButton1Click:Connect(function()
    if listeningForToggleKey then return end
    listeningForToggleKey = true
    toggleKeyBtn.Text = "Press any key..."
    toggleKeyBtn.BackgroundColor3 = Color3.fromRGB(200,170,0)

    local conn
    conn = UserInputService.InputBegan:Connect(function(input,gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            States.Misc.ClickTPKey = input.KeyCode
            toggleKeyBtn.Text = "Set Toggle Key (Now: "..States.Misc.ClickTPKey.Name..")"
            toggleKeyBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
            listeningForToggleKey = false
            conn:Disconnect()
        end
    end)
end)

-- ฟัง Key ที่เซ็ตไว้ -> Toggle ClickTP
UserInputService.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode == States.Misc.ClickTPKey then
        States.Misc.ClickTP = not States.Misc.ClickTP

        -- หา Button ของ ClickTP แล้วอัปเดตสี+ข้อความ
        for _,btn in ipairs(Content:GetChildren()) do
            if btn:IsA("TextButton") and string.find(btn.Text, "ClickTP") then
                btn.Text = "ClickTP: "..(States.Misc.ClickTP and "ON" or "OFF")
                btn.BackgroundColor3 = States.Misc.ClickTP and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
            end
        end
    end
end)

----------------------------------------------------------------
-- HIP HEIGHT
----------------------------------------------------------------
local defaultHipHeight = 0 -- ✅ Roblox default

local hipBtn = Instance.new("TextButton", Content)
hipBtn.Size = UDim2.new(1, -20, 0, 30)
hipBtn.BackgroundColor3 = States.Misc.HipHeightEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
hipBtn.Text = "HipHeight: "..(States.Misc.HipHeightEnabled and "ON" or "OFF")
hipBtn.Font = Enum.Font.GothamBold
hipBtn.TextSize = 14
hipBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", hipBtn).CornerRadius = UDim.new(0,6)

hipBtn.MouseButton1Click:Connect(function()
    States.Misc.HipHeightEnabled = not States.Misc.HipHeightEnabled
    hipBtn.BackgroundColor3 = States.Misc.HipHeightEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    hipBtn.Text = "HipHeight: "..(States.Misc.HipHeightEnabled and "ON" or "OFF")

    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if States.Misc.HipHeightEnabled then
            hum.HipHeight = States.Misc.HipHeight or defaultHipHeight
        else
            hum.HipHeight = defaultHipHeight
        end
    end
end)

CreateStepSlider(Content, 0, {0,2,4,6,8,10,20,30,40,50}, defaultHipHeight, function(v)
    States.Misc.HipHeight = v
    if States.Misc.HipHeightEnabled then
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.HipHeight = v end
    end
end)

    ----------------------------------------------------------------
    -- WALK SPEED
    ----------------------------------------------------------------
    local wsBtn = Instance.new("TextButton", Content)
    wsBtn.Size = UDim2.new(1, -20, 0, 30)
    wsBtn.BackgroundColor3 = States.Misc.WalkSpeedEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    wsBtn.Text = "WalkSpeed: "..(States.Misc.WalkSpeedEnabled and "ON" or "OFF")
    wsBtn.Font = Enum.Font.GothamBold
    wsBtn.TextSize = 14
    wsBtn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", wsBtn).CornerRadius = UDim.new(0,6)

    wsBtn.MouseButton1Click:Connect(function()
        States.Misc.WalkSpeedEnabled = not States.Misc.WalkSpeedEnabled
        wsBtn.BackgroundColor3 = States.Misc.WalkSpeedEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        wsBtn.Text = "WalkSpeed: "..(States.Misc.WalkSpeedEnabled and "ON" or "OFF")
    end)

    CreateStepSlider(Content, 0, {16,20,30,50,100,150,200}, States.Misc.WalkSpeed, function(v) States.Misc.WalkSpeed = v end)

----------------------------------------------------------------
-- JUMP POWER
----------------------------------------------------------------
local defaultJumpPower = 50

local jpBtn = Instance.new("TextButton", Content)
jpBtn.Size = UDim2.new(1, -20, 0, 30)
jpBtn.BackgroundColor3 = States.Misc.JumpEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
jpBtn.Text = "JumpPower: "..(States.Misc.JumpEnabled and "ON" or "OFF")
jpBtn.Font = Enum.Font.GothamBold
jpBtn.TextSize = 14
jpBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", jpBtn).CornerRadius = UDim.new(0,6)

jpBtn.MouseButton1Click:Connect(function()
    States.Misc.JumpEnabled = not States.Misc.JumpEnabled
    jpBtn.BackgroundColor3 = States.Misc.JumpEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
    jpBtn.Text = "JumpPower: "..(States.Misc.JumpEnabled and "ON" or "OFF")

    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if States.Misc.JumpEnabled then
            hum.UseJumpPower = true
            hum.JumpPower = States.Misc.JumpPower or defaultJumpPower
        else
            hum.JumpPower = defaultJumpPower
        end
    end
end)

CreateStepSlider(Content, 0, {50,75,100,125,150,175,200}, defaultJumpPower, function(v)
    States.Misc.JumpPower = v
    if States.Misc.JumpEnabled then
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = v end
    end
end)

----------------------------------------------------------------
-- FLIGHT
----------------------------------------------------------------
local flyConnection = nil

local flyBtn = Instance.new("TextButton", Content)
flyBtn.Size = UDim2.new(1, -20, 0, 30)
flyBtn.Text = "Flight: "..(States.Misc.FlightEnabled and "ON" or "OFF")
flyBtn.BackgroundColor3 = States.Misc.FlightEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,170)
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 14
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0,6)

flyBtn.MouseButton1Click:Connect(function()
    States.Misc.FlightEnabled = not States.Misc.FlightEnabled
    flyBtn.Text = "Flight: "..(States.Misc.FlightEnabled and "ON" or "OFF")
    flyBtn.BackgroundColor3 = States.Misc.FlightEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,170)

    if States.Misc.FlightEnabled then
        -- เริ่มบิน
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.RenderStepped:Connect(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            local hrp = player.Character.HumanoidRootPart
            local camCF = workspace.CurrentCamera.CFrame
            local moveDir = Vector3.new()

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0,1,0) end

            if moveDir.Magnitude > 0 then
                hrp.Velocity = moveDir.Unit * States.Misc.FlightSpeed
            else
                hrp.Velocity = Vector3.new(0,0,0)
            end
        end)
    else
        -- หยุดบิน
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end
    end
end)

CreateStepSlider(Content, 0, {100,200,300,400,500,600,700,800,900,1000}, States.Misc.FlightSpeed, function(v) 
    States.Misc.FlightSpeed = v 
end)

end
-- =====================================================


-- =====================================================
-- GLOBAL STATE FOR FRUIT
-- =====================================================
local runningDrink = false
local runningMix = false
local autoBarrelThread = nil
local runningXYZ = false
local xyzLabel = nil

-- ===== Drink/Barrel helpers (robust implementations) =====
-- Defaults
getgenv().dist = getgenv().dist or 300

-- Find the active juicing bowl anywhere in the workspace
local function findJuiceBowl()
    -- Prefer Island8.Kitchen tree if present
    local island8 = workspace:FindFirstChild("Island8")
    local kitchen = island8 and island8:FindFirstChild("Kitchen")
    if kitchen then
        for _, child in ipairs(kitchen:GetDescendants()) do
            if child.Name == "JuicingBowl" then
                local bowl = child:FindFirstChild("Bowl")
                if bowl and bowl:IsA("BasePart") then return bowl end
            end
        end
    end
    -- Fallback: scan the whole workspace
    for _, inst in ipairs(workspace:GetDescendants()) do
        if inst.Name == "JuicingBowl" then
            local bowl = inst:FindFirstChild("Bowl")
            if bowl and bowl:IsA("BasePart") then return bowl end
        end
    end
    return nil
end

-- Activate any equipped Juice/Milk tool
local function activateDrinkTools()
    local char = Players.LocalPlayer.Character
    if not char then return end
    for _, obj in ipairs(char:GetDescendants()) do
        if obj:IsA("Tool") and (string.find(obj.Name, "Juice") or string.find(obj.Name, "Milk")) then
            pcall(function() obj:Activate() end)
        end
    end
end

-- Equip and consume any Juice/Milk found in the backpack
function autodrink()
    local lp = Players.LocalPlayer
    local char = lp.Character
    local backpack = lp:FindFirstChild("Backpack")
    if not (char and backpack) then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    for _, obj in ipairs(backpack:GetChildren()) do
        if obj:IsA("Tool") and (string.find(obj.Name, "Juice") or string.find(obj.Name, "Milk")) then
            pcall(function()
                hum:EquipTool(obj)
                task.wait(0.1)
                activateDrinkTools()
            end)
        end
    end
end

-- Click all relevant Kitchen ClickDetectors (e.g., to mix/confirm)
function teleportfarmclick()
    local bowl = findJuiceBowl()
    local lp = Players.LocalPlayer
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not (bowl and hrp) then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "ClickDetector" and obj.Parent and obj.Parent:IsDescendantOf(workspace) then
            local part = obj.Parent
            if part:IsA("BasePart") and part:IsDescendantOf(workspace:FindFirstChild("Island8") or workspace) then
                pcall(function()
                    hrp.CFrame = CFrame.new(bowl.Position)
                    task.wait(0.1)
                    fireclickdetector(obj)
                end)
            end
        end
    end
end

-- Teleport to nearby Barrels/Crates around the bowl and click them
function teleportfarm()
    local lp = Players.LocalPlayer
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local bowl = findJuiceBowl()
    if not (hrp and bowl) then return end

    local maxDist = tonumber(getgenv().dist) or 300
    for _, obj in ipairs(workspace:GetDescendants()) do
        local part
        if obj:IsA("BasePart") and (obj.Name == "Barrel" or obj.Name == "Crate") then
            part = obj
        elseif obj:IsA("Model") and (obj.Name == "Barrel" or obj.Name == "Crate") and obj.PrimaryPart then
            part = obj.PrimaryPart
        end
        if part then
            local dist = (bowl.Position - part.Position).Magnitude
            if dist <= maxDist then
                local cd = part:FindFirstChildOfClass("ClickDetector") or part:FindFirstChild("ClickDetector")
                pcall(function()
                    hrp.CFrame = part.CFrame
                end)
                task.wait(0.2)
                if cd then pcall(function() fireclickdetector(cd) end) end
                task.wait(0.3)
            end
        end
    end
end


-- หยุดทุกอย่างเวลาออกจาก Fruit Tab
local function StopFruitThreads()
    States.Fruit.AutoBarrel = false
    runningDrink = false
    runningMix = false
    if autoBarrelThread then
        task.cancel(autoBarrelThread)
        autoBarrelThread = nil
    end
end

-- =====================================================
-- FRUIT TAB (Auto Barrel TP + Flight + Mix + Drink)
-- =====================================================
local function LoadFruitTab()

    -- ลูปดึงมอนเข้าจุดล็อก (Farm Mode)
    if not _G._FarmLoopStarted then
        _G._FarmLoopStarted = true
        task.spawn(function()
            while true do
                task.wait(0.2)
                if _G.ComboEnabled and type(pullToLockedPoint) == "function" then
                    pcall(pullToLockedPoint)
                end
            end
        end)
    end


    ClearContent()
    -- สร้าง marker กันซ้อน (แต่ไม่ return ออก)
    if not Content:FindFirstChild("FruitLoaded") then
        local marker = Instance.new("BoolValue", Content)
        marker.Name = "FruitLoaded"
    end

    -- ปุ่ม Farm Mode และ Set Spot ในเมนู Drink (สร้างหลัง ClearContent)
    local farmBtn = Instance.new("TextButton", Content)
    farmBtn.Size = UDim2.new(1, -20, 0, 40)
    farmBtn.Position = UDim2.new(0, 10, 0, 0)
    farmBtn.TextScaled = true
    farmBtn.BackgroundColor3 = _G.ComboEnabled and Color3.fromRGB(30,140,60) or Color3.fromRGB(40,40,40)
    farmBtn.TextColor3 = Color3.new(1,1,1)
    farmBtn.Font = Enum.Font.GothamBold
    farmBtn.Text = _G.ComboEnabled and "Farm Mode: ON" or "Farm Mode: OFF"
    Instance.new("UICorner", farmBtn).CornerRadius = UDim.new(0,6)

    local setBtn = Instance.new("TextButton", Content)
    setBtn.Size = UDim2.new(1, -20, 0, 32)
    setBtn.Position = UDim2.new(0, 10, 0, 46)
    setBtn.TextScaled = true
    setBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    setBtn.TextColor3 = Color3.new(1,1,1)
    setBtn.Font = Enum.Font.GothamBold
    setBtn.Text = _G.LockCFrame and "Set Spot (Update)" or "Set Spot"
    Instance.new("UICorner", setBtn).CornerRadius = UDim.new(0,6)

    local function styleFarmBtn()
        farmBtn.Text = _G.ComboEnabled and "Farm Mode: ON" or "Farm Mode: OFF"
        farmBtn.BackgroundColor3 = _G.ComboEnabled and Color3.fromRGB(30,140,60) or Color3.fromRGB(40,40,40)
        setBtn.Text = _G.LockCFrame and "Set Spot (Update)" or "Set Spot"
    end

    local function setSpotFromPlayer()
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        _G.LockCFrame = (hrp.CFrame * CFrame.new(0, 0, -8))
        setBtn.Text = "Set Spot (Update)"
    end

    farmBtn.MouseButton1Click:Connect(function()
        _G.ComboEnabled = not _G.ComboEnabled
        if _G.ComboEnabled and not _G.LockCFrame then
            setSpotFromPlayer()
        end
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not _G.ComboEnabled and true or false
                end
            end
        end
        if not _G.ComboEnabled then
            local enemiesFolder = workspace:FindFirstChild("Enemies")
            if enemiesFolder then
                for _, enemy in ipairs(enemiesFolder:GetChildren()) do
                    local hum = enemy:FindFirstChildOfClass("Humanoid")
                    local hrp2 = enemy:FindFirstChild("HumanoidRootPart")
                    if hum and hrp2 then
                        hrp2.Anchored = false
                        hum.PlatformStand = false
                    end
                end
            end
        end
        styleFarmBtn()
    end)

    setBtn.MouseButton1Click:Connect(function()
        setSpotFromPlayer()
    end)

    -- ปุ่มออโต้กินน้ำไปเรื่อย จนกว่าจะกดหยุด
    local runningAutoDrink = false
    local autoDrinkBtn = Instance.new("TextButton", Content)
    autoDrinkBtn.Size = UDim2.new(1, -20, 0, 40)
    autoDrinkBtn.Text = "ออโต้ กินนํ้าไปเรื่อย: OFF"
    autoDrinkBtn.BackgroundColor3 = Color3.fromRGB(200,100,50)
    autoDrinkBtn.TextColor3 = Color3.new(1,1,1)
    autoDrinkBtn.Font = Enum.Font.GothamBold
    autoDrinkBtn.TextSize = 16
    Instance.new("UICorner", autoDrinkBtn).CornerRadius = UDim.new(0,6)


    -- ====== ฟังก์ชัน Farm Mode (Fixed Front) ======
    local distance = 8         -- ระยะจากเราไป "จุดล็อก" ด้านหน้า (ครั้งที่กด Set Spot)
    local yOffset = 0          -- ยกขึ้น/ลงจากระดับ HRP
    local refreshInterval = 0.2
    local stackJitter = 0      -- 0 = กองทับจุดเดียวเป๊ะ (ถ้ากระพริบ ให้ลอง 0.1)

    _G.ComboEnabled = false    -- Farm Mode
    _G.LockCFrame = nil        -- จุดล็อก (world CFrame), จะถูกกำหนดตอนกด ON หรือกด Set Spot

    local function ensureUI()
        local pg = player:WaitForChild("PlayerGui")
        local gui = pg:FindFirstChild("FarmGui_FixedFront")
        if not gui then
            gui = Instance.new("ScreenGui")
            gui.Name = "FarmGui_FixedFront"
            gui.ResetOnSpawn = false
            gui.Parent = pg
        end

        local farmBtn = gui:FindFirstChild("FarmButton")
        if not farmBtn then
            farmBtn = Instance.new("TextButton")
            farmBtn.Name = "FarmButton"
            farmBtn.Size = UDim2.fromOffset(180, 48)
            farmBtn.Position = UDim2.new(0, 20, 0, 120)
            farmBtn.TextScaled = true
            farmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            farmBtn.TextColor3 = Color3.new(1,1,1)
            farmBtn.Parent = gui
        end

        local setBtn = gui:FindFirstChild("SetSpotButton")
        if not setBtn then
            setBtn = Instance.new("TextButton")
            setBtn.Name = "SetSpotButton"
            setBtn.Size = UDim2.fromOffset(140, 36)
            setBtn.Position = UDim2.new(0, 210, 0, 132)
            setBtn.TextScaled = true
            setBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            setBtn.TextColor3 = Color3.new(1,1,1)
            setBtn.Parent = gui
        end

        local function styleFarm(on)
            farmBtn.Text = on and "Farm Mode: ON" or "Farm Mode: OFF"
            farmBtn.BackgroundColor3 = on and Color3.fromRGB(30,140,60) or Color3.fromRGB(40,40,40)
            setBtn.Text = _G.LockCFrame and "Set Spot (Update)" or "Set Spot"
        end
        styleFarm(_G.ComboEnabled)

        local function setSpotFromPlayer()
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            _G.LockCFrame = (hrp.CFrame * CFrame.new(0, yOffset, -distance))
            setBtn.Text = "Set Spot (Update)"
        end

        farmBtn.MouseButton1Click:Connect(function()
            _G.ComboEnabled = not _G.ComboEnabled
            if _G.ComboEnabled and not _G.LockCFrame then
                setSpotFromPlayer() -- ตั้งจุดครั้งแรกอัตโนมัติ
            end
            -- เปิด/ปิด NoClip ให้ผู้เล่น
            local char = player.Character
            if char then
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = not _G.ComboEnabled and true or false
                    end
                end
            end
            if not _G.ComboEnabled then
                -- ปลดแช่มอนกลับปกติ
                local enemiesFolder = workspace:FindFirstChild("Enemies")
                if enemiesFolder then
                    for _, enemy in ipairs(enemiesFolder:GetChildren()) do
                        local hum = enemy:FindFirstChildOfClass("Humanoid")
                        local hrp2 = enemy:FindFirstChild("HumanoidRootPart")
                        if hum and hrp2 then
                            hrp2.Anchored = false
                            hum.PlatformStand = false
                        end
                    end
                end
            end
            styleFarm(_G.ComboEnabled)
        end)

        setBtn.MouseButton1Click:Connect(function()
            setSpotFromPlayer()
        end)
    end

    -- รายชื่อมอน (ตัวอย่าง, ปรับเองได้)
    local thugNames = {
        ["Lv1 Crab"]=true,["Lv11 Boar"]=true,["Lv12 Boar"]=true,["Lv12 Thug"]=true,
        ["Lv13 Bandit"]=true,["Lv13 Boar"]=true,["Lv14 Bandit"]=true,["Lv14 Boar"]=true,
        ["Lv15 Bandit"]=true,["Lv15 Boar"]=true,["Lv15 Thug"]=true,["Lv16 Boar"]=true,
        ["Lv16 Thug"]=true,["Lv17 Thug"]=true,["Lv186 Cave Demon"]=true,["Lv188 Cave Demon"]=true,
        ["Lv19 Thief"]=true,["Lv198 Cave Demon"]=true,["Lv2 Angry Bob"]=true,["Lv20 Thief"]=true,
        ["Lv200 Vokun"]=true,["Lv21 Thief"]=true,["Lv219 Cave Demon"]=true,["Lv22 Angry Bobby"]=true,
        ["Lv22 Thief"]=true,["Lv22 Thug"]=true,["Lv23 Thug"]=true,["Lv24 Angry Bobbi"]=true,
        ["Lv24 Fred"]=true,["Lv24 Thug"]=true,["Lv25 Thug"]=true,["Lv26 Thug"]=true,
        ["Lv28 Fredde"]=true,["Lv28 Freyd"]=true,["Lv28 Friedrich"]=true,["Lv29 Angry Bobber"]=true,
        ["Lv29 Frued"]=true,["Lv3 Crab"]=true,["Lv30 Thief"]=true,["Lv30 Thug"]=true,
        ["Lv31 Thief"]=true,["Lv32 Fredric"]=true,["Lv32 Thief"]=true,["Lv34 Freddi"]=true,
        ["Lv35 Angry Bobb"]=true,["Lv4 Boar"]=true,["Lv4 Crab"]=true,["Lv4 Freddy"]=true,
        ["Lv40 Cave Demon"]=true,["Lv40 Thug"]=true,["Lv5 Crab"]=true,["Lv6 Crab"]=true,
        ["Lv7 Crab"]=true,["Lv9 Bandit"]=true,
    }

    local function pullToLockedPoint()
        if not _G.LockCFrame then return end
        local enemiesFolder = workspace:FindFirstChild("Enemies")
        if not enemiesFolder then return end

        local i = 0
        for name in pairs(thugNames) do
            local enemy = enemiesFolder:FindFirstChild(name)
            if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                i += 1
                local eHRP = enemy.HumanoidRootPart
                local hum = enemy.Humanoid

                local jx = ((i % 3) - 1) * stackJitter
                local jz = math.floor(i / 3) * (stackJitter * 0.2)
                eHRP.CFrame = _G.LockCFrame * CFrame.new(jx, 0, -jz)

                eHRP.Anchored = true
                hum.PlatformStand = true
            end
        end
    end

    local autoDrinkThread = nil
    local function startAutoDrinkLoop()
        if autoDrinkThread then return end
        getgenv().abc = true
        autoDrinkThread = task.spawn(function()
            while getgenv().abc do
                task.wait()
                task.spawn(function()
                    pcall(autodrink)
                end)
                pcall(teleportfarm)
                wait(0.1)
                pcall(teleportfarmclick)
            end
            autoDrinkThread = nil
        end)
    end
    local function stopAutoDrinkLoop()
        getgenv().abc = false
        if autoDrinkThread then
            task.cancel(autoDrinkThread)
            autoDrinkThread = nil
        end
    end

    autoDrinkBtn.MouseButton1Click:Connect(function()
        runningAutoDrink = not runningAutoDrink
        if runningAutoDrink then
            autoDrinkBtn.Text = "ออโต้ กินนํ้าไปเรื่อย: ON"
            autoDrinkBtn.BackgroundColor3 = Color3.fromRGB(50,200,100)
            startAutoDrinkLoop()
        else
            autoDrinkBtn.Text = "ออโต้ กินนํ้าไปเรื่อย: OFF"
            autoDrinkBtn.BackgroundColor3 = Color3.fromRGB(200,100,50)
            stopAutoDrinkLoop()
        end
    end)

    -- QuangTri Drink Suite (Auto Buy / Drop / Drink)
    local function OpenQuangTriDrinkSuite()
        if getgenv().QuangTriHub then pcall(function() getgenv().QuangTriHub:Destroy() end) end

        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local CoreGui = game:GetService("CoreGui")
        local VIM = game:GetService("VirtualInputManager")

        getgenv().AutoBuy = false; getgenv().AutoDrop = false; getgenv().AutoDrink = false
        getgenv().DROP_DELAY = getgenv().DROP_DELAY or 0.05
        getgenv().DRINK_DELAY = getgenv().DRINK_DELAY or 0.03
        local BuyAmount, Bought, SelectedDrink = 10, 0, "Cider+"
        local DrinkTypes = {"Cider+", "Lemonade+", "Juice+", "Smoothie+"}

        local gui = Instance.new("ScreenGui", CoreGui)
        gui.Name = "QuangTriHub"
        getgenv().QuangTriHub = gui

        local main = Instance.new("Frame", gui)
        main.Size = UDim2.new(0, 300, 0, 320)
        main.Position = UDim2.new(0.35, 0, 0.3, 0)
        main.BackgroundColor3 = Color3.fromRGB(22,22,28)
        main.Active = true; main.Draggable = true
        Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)
        local stroke = Instance.new("UIStroke", main); stroke.Color = Color3.fromRGB(100,200,255); stroke.Thickness = 1; stroke.Transparency = 0.4

        local title = Instance.new("TextLabel", main)
        title.Size = UDim2.new(1,0,0,32)
        title.BackgroundTransparency = 1
        title.Text = "⚡ QuangTri Drink Suite"
        title.Font = Enum.Font.GothamBold
        title.TextSize = 18
        title.TextColor3 = Color3.fromRGB(255,255,255)

        local buyLabel = Instance.new("TextLabel", main)
        buyLabel.Text = "Auto Buy Drinks"
        buyLabel.Size = UDim2.new(1,0,0,20)
        buyLabel.Position = UDim2.new(0,0,0.12,0)
        buyLabel.BackgroundTransparency = 1
        buyLabel.TextColor3 = Color3.fromRGB(200,200,200)
        buyLabel.Font = Enum.Font.Gotham
        buyLabel.TextSize = 14

        local drinkButtons = {}
        for i, name in ipairs(DrinkTypes) do
            local btn = Instance.new("TextButton", main)
            btn.Size = UDim2.new(0.45,0,0,26)
            btn.Position = UDim2.new((i%2==1) and 0.05 or 0.5,0,0.18+(math.floor((i-1)/2)*0.1),0)
            btn.Text = name
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 13
            btn.BackgroundColor3 = Color3.fromRGB(50,50,70)
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
            btn.MouseButton1Click:Connect(function()
                SelectedDrink = name
                for _,b in ipairs(drinkButtons) do b.BackgroundColor3 = Color3.fromRGB(50,50,70) end
                btn.BackgroundColor3 = Color3.fromRGB(100,170,60)
            end)
            table.insert(drinkButtons, btn)
        end
        if drinkButtons[1] then drinkButtons[1].BackgroundColor3 = Color3.fromRGB(100,170,60) end

        local amountBox = Instance.new("TextBox", main)
        amountBox.Size = UDim2.new(0.9,0,0,26)
        amountBox.Position = UDim2.new(0.05,0,0.38,0)
        amountBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
        amountBox.Text = tostring(BuyAmount)
        amountBox.PlaceholderText = "จำนวนที่จะซื้อ..."
        amountBox.Font = Enum.Font.Gotham
        amountBox.TextSize = 13
        amountBox.TextColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", amountBox).CornerRadius = UDim.new(0,6)
        amountBox.FocusLost:Connect(function(enter)
            if enter and tonumber(amountBox.Text) then
                BuyAmount = tonumber(amountBox.Text)
                Bought = 0
            end
        end)

        local toggleBuy = Instance.new("TextButton", main)
        toggleBuy.Size = UDim2.new(0.9,0,0,28)
        toggleBuy.Position = UDim2.new(0.05,0,0.48,0)
        toggleBuy.Text = "▶ เริ่ม Auto Buy"
        toggleBuy.Font = Enum.Font.GothamBold
        toggleBuy.TextSize = 14
        toggleBuy.BackgroundColor3 = Color3.fromRGB(0,170,100)
        toggleBuy.TextColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", toggleBuy).CornerRadius = UDim.new(0,6)

        local function findRemote()
            local m = workspace:FindFirstChild("Merchants")
            local b = m and m:FindFirstChild("BetterDrinkMerchant")
            local c = b and b:FindFirstChild("Clickable")
            local s = c and c:FindFirstChild("ShopDrinksPlus")
            local clk = s and s:FindFirstChild("Clicked")
            return clk and clk:FindFirstChild("Retum")
        end
        local remote; task.spawn(function() while not remote do remote = findRemote() task.wait(1) end end)

        toggleBuy.MouseButton1Click:Connect(function()
            getgenv().AutoBuy = not getgenv().AutoBuy
            Bought = 0
            toggleBuy.Text = getgenv().AutoBuy and "⏹ หยุด Auto Buy" or "▶ เริ่ม Auto Buy"
            toggleBuy.BackgroundColor3 = getgenv().AutoBuy and Color3.fromRGB(200,50,50) or Color3.fromRGB(0,170,100)
        end)

        task.spawn(function()
            while gui.Parent do
                if getgenv().AutoBuy and remote and Bought < BuyAmount then
                    pcall(function() remote:FireServer(SelectedDrink) end)
                    Bought += 1
                end
                task.wait(0.05)
            end
        end)

        local toggleDrop = toggleBuy:Clone()
        toggleDrop.Parent = main
        toggleDrop.Position = UDim2.new(0.05,0,0.63,0)
        toggleDrop.Text = "▶ Auto Drop"
        toggleDrop.BackgroundColor3 = Color3.fromRGB(0,170,100)

        local function autoDropLoop()
            while getgenv().AutoDrop and gui.Parent do
                local backpack, char = LocalPlayer.Backpack, LocalPlayer.Character
                if backpack and char and char:FindFirstChild("Humanoid") then
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if not getgenv().AutoDrop then break end
                        if tool:IsA("Tool") then
                            pcall(function()
                                char.Humanoid:EquipTool(tool)
                                task.wait(0.01)
                                if tool.Parent == char then
                                    VIM:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
                                    task.wait(0.01)
                                    VIM:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)
                                    task.wait(getgenv().DROP_DELAY)
                                end
                            end)
                        end
                    end
                end
                task.wait()
            end
        end
        toggleDrop.MouseButton1Click:Connect(function()
            getgenv().AutoDrop = not getgenv().AutoDrop
            toggleDrop.Text = getgenv().AutoDrop and "⏹ Stop Drop" or "▶ Auto Drop"
            toggleDrop.BackgroundColor3 = getgenv().AutoDrop and Color3.fromRGB(200,50,50) or Color3.fromRGB(0,170,100)
            if getgenv().AutoDrop then task.spawn(autoDropLoop) end
        end)

        local toggleDrink = toggleBuy:Clone()
        toggleDrink.Parent = main
        toggleDrink.Position = UDim2.new(0.05,0,0.78,0)
        toggleDrink.Text = "▶ Auto Drink"
        toggleDrink.BackgroundColor3 = Color3.fromRGB(0,170,100)

        local function autoDrinkLoop()
            while getgenv().AutoDrink and gui.Parent do
                local backpack, char = LocalPlayer.Backpack, LocalPlayer.Character
                if backpack and char and char:FindFirstChild("Humanoid") then
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if not getgenv().AutoDrink then break end
                        if tool:IsA("Tool") then
                            pcall(function()
                                char.Humanoid:EquipTool(tool)
                                task.wait(0.001)
                                if tool.Parent == char then
                                    tool:Activate()
                                    task.wait(getgenv().DRINK_DELAY)
                                end
                            end)
                        end
                    end
                end
                task.wait()
            end
        end
        toggleDrink.MouseButton1Click:Connect(function()
            getgenv().AutoDrink = not getgenv().AutoDrink
            toggleDrink.Text = getgenv().AutoDrink and "⏹ Stop Drink" or "▶ Auto Drink"
            toggleDrink.BackgroundColor3 = getgenv().AutoDrink and Color3.fromRGB(200,50,50) or Color3.fromRGB(0,170,100)
            if getgenv().AutoDrink then task.spawn(autoDrinkLoop) end
        end)
    end

    -- QuangTri Drink Suite Toggle
    local qtEnabled = false
    local qtButton = Instance.new("TextButton", Content)
    qtButton.Size = UDim2.new(1, -20, 0, 40)
    qtButton.Position = UDim2.new(0, 10, 0, 88)
    qtButton.TextScaled = true
    qtButton.Text = "🍹 QuangTri Drink Suite: OFF"
    qtButton.Font = Enum.Font.GothamBold
    qtButton.TextColor3 = Color3.new(1,1,1)
    qtButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    Instance.new("UICorner", qtButton).CornerRadius = UDim.new(0,6)
    local qstroke = Instance.new("UIStroke", qtButton); qstroke.Color = Color3.fromRGB(255, 215, 0); qstroke.Thickness = 1; qstroke.Transparency = 0.3
    qtButton.MouseButton1Click:Connect(function()
        qtEnabled = not qtEnabled
        if qtEnabled then
            qtButton.Text = "🍹 QuangTri Drink Suite: ON"
            qtButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            OpenQuangTriDrinkSuite()
        else
            qtButton.Text = "🍹 QuangTri Drink Suite: OFF"
            qtButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            if getgenv().QuangTriHub then 
                pcall(function() getgenv().QuangTriHub:Destroy() end) 
            end
        end
    end)

    -- =============== Side Farm Suite (Left/Right/Both) ===============
    local function OpenSideFarmSuite()
        -- Config (namespaced to avoid conflicts)
        local side_distance = 0
        local side_yOffset = 0
        local side_refreshInterval = 0
        local side_stackJitter = 0
        local side_bothSpacing = 2

        _G.SideFarm_Enabled = _G.SideFarm_Enabled or false
        _G.SideFarm_SideMode = _G.SideFarm_SideMode or "Right" -- Right | Left | Both

        -- UI on right side
        local pg = player:WaitForChild("PlayerGui")
        local gui = pg:FindFirstChild("FarmGui_Side")
        if not gui then
            gui = Instance.new("ScreenGui")
            gui.Name = "FarmGui_Side"
            gui.ResetOnSpawn = false
            gui.Parent = pg
        end

        local farmBtn = gui:FindFirstChild("FarmButton_Side")
        if not farmBtn then
            farmBtn = Instance.new("TextButton")
            farmBtn.Name = "FarmButton_Side"
            farmBtn.Size = UDim2.fromOffset(180, 48)
            farmBtn.AnchorPoint = Vector2.new(1, 0) -- stick to right
            farmBtn.Position = UDim2.new(1, -20, 0, 120)
            farmBtn.TextScaled = true
            farmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            farmBtn.TextColor3 = Color3.new(1, 1, 1)
            farmBtn.AutoButtonColor = true
            farmBtn.Parent = gui
        end

        local sideBtn = gui:FindFirstChild("SideButton_Side")
        if not sideBtn then
            sideBtn = Instance.new("TextButton")
            sideBtn.Name = "SideButton_Side"
            sideBtn.Size = UDim2.fromOffset(120, 36)
            sideBtn.AnchorPoint = Vector2.new(1, 0)
            sideBtn.Position = UDim2.new(1, -20 - 190, 0, 132)
            sideBtn.TextScaled = true
            sideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            sideBtn.TextColor3 = Color3.new(1, 1, 1)
            sideBtn.AutoButtonColor = true
            sideBtn.Parent = gui
        end

        local function styleFarm(on)
            farmBtn.Text = on and "Farm Mode: ON" or "Farm Mode: OFF"
            farmBtn.BackgroundColor3 = on and Color3.fromRGB(30, 140, 60) or Color3.fromRGB(40, 40, 40)
        end
        local function updateSideText()
            sideBtn.Text = "Side: " .. tostring(_G.SideFarm_SideMode)
        end
        styleFarm(_G.SideFarm_Enabled)
        updateSideText()

        farmBtn.MouseButton1Click:Connect(function()
            _G.SideFarm_Enabled = not _G.SideFarm_Enabled
            styleFarm(_G.SideFarm_Enabled)
            if not _G.SideFarm_Enabled then
                local enemiesFolder = workspace:FindFirstChild("Enemies")
                if enemiesFolder then
                    for _, enemy in ipairs(enemiesFolder:GetChildren()) do
                        local hum = enemy:FindFirstChildOfClass("Humanoid")
                        local hrp2 = enemy:FindFirstChild("HumanoidRootPart")
                        if hum and hrp2 then
                            hrp2.Anchored = false
                            hum.PlatformStand = false
                        end
                    end
                end
                local char = player.Character
                if char then
                    for _, part in ipairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end
        end)

        sideBtn.MouseButton1Click:Connect(function()
            if _G.SideFarm_SideMode == "Right" then
                _G.SideFarm_SideMode = "Left"
            elseif _G.SideFarm_SideMode == "Left" then
                _G.SideFarm_SideMode = "Both"
            else
                _G.SideFarm_SideMode = "Right"
            end
            updateSideText()
        end)

        -- Enemies list (reuse if available)
        local sideThugNames = {
            ["Lv1 Crab"]=true,["Lv11 Boar"]=true,["Lv12 Boar"]=true,["Lv12 Thug"]=true,
            ["Lv13 Bandit"]=true,["Lv13 Boar"]=true,["Lv14 Bandit"]=true,["Lv14 Boar"]=true,
            ["Lv15 Bandit"]=true,["Lv15 Boar"]=true,["Lv15 Thug"]=true,["Lv16 Boar"]=true,
            ["Lv16 Thug"]=true,["Lv17 Thug"]=true,["Lv186 Cave Demon"]=true,["Lv188 Cave Demon"]=true,
            ["Lv19 Thief"]=true,["Lv198 Cave Demon"]=true,["Lv2 Angry Bob"]=true,["Lv20 Thief"]=true,
            ["Lv200 Vokun"]=true,["Lv21 Thief"]=true,["Lv219 Cave Demon"]=true,["Lv22 Angry Bobby"]=true,
            ["Lv22 Thief"]=true,["Lv22 Thug"]=true,["Lv23 Thug"]=true,["Lv24 Angry Bobbi"]=true,
            ["Lv24 Fred"]=true,["Lv24 Thug"]=true,["Lv25 Thug"]=true,["Lv26 Thug"]=true,
            ["Lv28 Fredde"]=true,["Lv28 Freyd"]=true,["Lv28 Friedrich"]=true,["Lv29 Angry Bobber"]=true,
            ["Lv29 Frued"]=true,["Lv3 Crab"]=true,["Lv30 Thief"]=true,["Lv30 Thug"]=true,
            ["Lv31 Thief"]=true,["Lv32 Fredric"]=true,["Lv32 Thief"]=true,["Lv34 Freddi"]=true,
            ["Lv35 Angry Bobb"]=true,["Lv4 Boar"]=true,["Lv4 Crab"]=true,["Lv4 Freddy"]=true,
            ["Lv40 Cave Demon"]=true,["Lv40 Thug"]=true,["Lv5 Crab"]=true,["Lv6 Crab"]=true,
            ["Lv7 Crab"]=true,["Lv9 Bandit"]=true,
        }

        local function pullToSide()
            local character = player.Character
            if not character then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local enemiesFolder = workspace:FindFirstChild("Enemies")
            if not enemiesFolder then return end

            local idxRight = 0
            local idxLeft = 0

            for name in pairs(sideThugNames) do
                local enemy = enemiesFolder:FindFirstChild(name)
                if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChildOfClass("Humanoid") then
                    local eHRP = enemy.HumanoidRootPart
                    local hum = enemy:FindFirstChildOfClass("Humanoid")

                    if _G.SideFarm_SideMode == "Right" then
                        idxRight += 1
                        local row = math.floor((idxRight - 1) / 6)
                        local col = (idxRight - 1) % 6
                        local jx = side_distance + (col * side_stackJitter)
                        local jz = (row * side_stackJitter * 0.8)
                        eHRP.CFrame = hrp.CFrame * CFrame.new(jx, side_yOffset, jz)
                    elseif _G.SideFarm_SideMode == "Left" then
                        idxLeft += 1
                        local row = math.floor((idxLeft - 1) / 6)
                        local col = (idxLeft - 1) % 6
                        local jx = -side_distance - (col * side_stackJitter)
                        local jz = (row * side_stackJitter * 0.8)
                        eHRP.CFrame = hrp.CFrame * CFrame.new(jx, side_yOffset, jz)
                    else
                        local totalIndex = idxRight + idxLeft + 1
                        if (totalIndex % 2 == 1) then
                            idxRight += 1
                            local row = math.floor((idxRight - 1) / 6)
                            local col = (idxRight - 1) % 6
                            local jx = (side_distance + side_bothSpacing) + (col * side_stackJitter)
                            local jz = (row * side_stackJitter * 0.8)
                            eHRP.CFrame = hrp.CFrame * CFrame.new(jx, side_yOffset, jz)
                        else
                            idxLeft += 1
                            local row = math.floor((idxLeft - 1) / 6)
                            local col = (idxLeft - 1) % 6
                            local jx = -(side_distance + side_bothSpacing) - (col * side_stackJitter)
                            local jz = (row * side_stackJitter * 0.8)
                            eHRP.CFrame = hrp.CFrame * CFrame.new(jx, side_yOffset, jz)
                        end
                    end

                    eHRP.Anchored = true
                    hum.PlatformStand = true
                end
            end
        end

        task.spawn(function()
            while gui.Parent do
                if _G.SideFarm_Enabled then pullToSide() end
                task.wait(side_refreshInterval)
            end
        end)

        RunService.Stepped:Connect(function()
            if not _G.SideFarm_Enabled then return end
            local character = player.Character
            if not character then return end
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)

        player.CharacterAdded:Connect(function(char)
            char:WaitForChild("HumanoidRootPart", 10)
            task.delay(0.1, function()
                if not _G.SideFarm_Enabled then
                    for _, part in ipairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end)
        end)

        -- Optional anti-ban check
        local blacklistedUsers = {80905262,451082957,1833865091,1135910299,1619950875,1581720092,1661505948,679804290,520944,43247021,2350183594,1338963426,1276541545,587649463,245586741,174941504,136099207,94825741,358051152,529455640,281482099,355207559,5084487,928623624,30049170,474452017,110183124,1216587424,513583299,2361317975,52478375,1137403348,4447020775,571687119,8695097097,106625686,9071371442}
        local blacklist = {}
        for _,id in ipairs(blacklistedUsers) do blacklist[id] = true end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and blacklist[plr.UserId] then pcall(function() player:Kick("Anti-ban active") end) break end
        end
        Players.PlayerAdded:Connect(function(plr)
            if plr ~= player and blacklist[plr.UserId] then pcall(function() player:Kick("Anti-ban active") end) end
        end)
    end

    -- Side Farm Suite Toggle
    local sideEnabled = false
    local sideBtnOpen = Instance.new("TextButton", Content)
    sideBtnOpen.Size = UDim2.new(1, -20, 0, 40)
    sideBtnOpen.Position = UDim2.new(0, 10, 0, 132)
    sideBtnOpen.TextScaled = true
    sideBtnOpen.Text = "📐 Side Farm (Left/Right/Both): OFF"
    sideBtnOpen.Font = Enum.Font.GothamBold
    sideBtnOpen.TextColor3 = Color3.new(1,1,1)
    sideBtnOpen.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    Instance.new("UICorner", sideBtnOpen).CornerRadius = UDim.new(0,6)
    local sstroke = Instance.new("UIStroke", sideBtnOpen); sstroke.Color = Color3.fromRGB(255, 215, 0); sstroke.Thickness = 1; sstroke.Transparency = 0.3
    sideBtnOpen.MouseButton1Click:Connect(function()
        sideEnabled = not sideEnabled
        if sideEnabled then
            sideBtnOpen.Text = "📐 Side Farm (Left/Right/Both): ON"
            sideBtnOpen.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            OpenSideFarmSuite()
        else
            sideBtnOpen.Text = "📐 Side Farm (Left/Right/Both): OFF"
            sideBtnOpen.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            -- ปิด Side Farm
            _G.SideFarm_Enabled = false
            local pg = player:WaitForChild("PlayerGui")
            local gui = pg:FindFirstChild("FarmGui_Side")
            if gui then 
                pcall(function() gui:Destroy() end) 
            end
        end
    end)

    -- =============== Auto Haki Toggle ===============
    local hakiEnabled = false
    local hakiButton = Instance.new("TextButton", Content)
    hakiButton.Size = UDim2.new(1, -20, 0, 40)
    hakiButton.Position = UDim2.new(0, 10, 0, 176)
    hakiButton.Text = "⚡ Auto Haki: OFF"
    hakiButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    hakiButton.TextColor3 = Color3.new(1,1,1)
    hakiButton.Font = Enum.Font.GothamBold
    hakiButton.TextSize = 16
    Instance.new("UICorner", hakiButton).CornerRadius = UDim.new(0,6)
    local hstroke = Instance.new("UIStroke", hakiButton); hstroke.Color = Color3.fromRGB(255, 215, 0); hstroke.Thickness = 1; hstroke.Transparency = 0.3
    
    hakiButton.MouseButton1Click:Connect(function()
        hakiEnabled = not hakiEnabled
        if hakiEnabled then
            hakiButton.Text = "⚡ Auto Haki: ON"
            hakiButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            -- เรียกสร้าง GUI AutoHaki
            local GUI_NAME = "AutoHakiPermanent_v4_turbo"
            local CoreGui = game:GetService("CoreGui")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            if not CoreGui:FindFirstChild(GUI_NAME) and not (LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild(GUI_NAME)) then
                -- ===== Config =====
                local DEFAULT_KEY = "R"
                local SECONDARY_KEY = "Q"
                local DEFAULT_INTERVAL = 0.12
                local MIN_INTERVAL = 0.01
                local MAX_INTERVAL = 3
                local KEYDOWN_HOLD = 0.005
                local HOTKEY_TOGGLE = Enum.KeyCode.F6
                local SAMPLE_WINDOW = 6

                local UserInputService = game:GetService("UserInputService")
                local RunService = game:GetService("RunService")
                local VIM = game:GetService("VirtualInputManager")

                -- ===== Helpers =====
                local function clamp(n, lo, hi)
                    if n < lo then return lo elseif n > hi then return hi else return n end
                end
                local function toKeyCode(k)
                    if typeof(k) == "EnumItem" then return k end
                    return Enum.KeyCode[k]
                end
                local function doKeyTap(key)
                    local kc = toKeyCode(key)
                    VIM:SendKeyEvent(true, kc, false, game)
                    if KEYDOWN_HOLD > 0 then task.wait(KEYDOWN_HOLD) end
                    VIM:SendKeyEvent(false, kc, false, game)
                end

                -- ===== GUI =====
                local screenGui = Instance.new("ScreenGui")
                screenGui.Name = GUI_NAME
                screenGui.ResetOnSpawn = false
                screenGui.Parent = CoreGui

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 360, 0, 200)
                frame.Position = UDim2.new(0.01, 0, 0.1, 0)
                frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                frame.BorderColor3 = Color3.fromRGB(60, 60, 60)
                frame.Parent = screenGui
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
                local pad = Instance.new("UIPadding"); pad.PaddingTop = UDim.new(0, 8); pad.PaddingLeft = UDim.new(0, 8); pad.Parent = frame

                local title = Instance.new("TextLabel")
                title.Size = UDim2.new(1, -16, 0, 24)
                title.TextXAlignment = Enum.TextXAlignment.Left
                title.BackgroundTransparency = 1
                title.Font = Enum.Font.SourceSansBold
                title.TextSize = 16
                title.TextColor3 = Color3.fromRGB(0, 255, 0)
                title.Text = "AutoHaki PERMANENT v4 Turbo (R + optional Q)"
                title.Parent = frame

                local status = Instance.new("TextLabel")
                status.Position = UDim2.fromOffset(0, 26)
                status.Size = UDim2.new(1, -16, 0, 22)
                status.BackgroundTransparency = 1
                status.TextXAlignment = Enum.TextXAlignment.Left
                status.Font = Enum.Font.SourceSans
                status.TextSize = 14
                status.TextColor3 = Color3.fromRGB(200, 200, 200)
                status.Text = "🔴 OFF | Mode: Turbo | Presses: 0 | Success: 0%"
                status.Parent = frame

                local intBox = Instance.new("TextBox")
                intBox.Position = UDim2.fromOffset(0, 52)
                intBox.Size = UDim2.fromOffset(70, 26)
                intBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                intBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                intBox.ClearTextOnFocus = false
                intBox.Font = Enum.Font.SourceSans
                intBox.TextSize = 14
                intBox.Text = tostring(DEFAULT_INTERVAL)
                intBox.Parent = frame
                Instance.new("UICorner", intBox).CornerRadius = UDim.new(0, 6)

                local toggleBtn = Instance.new("TextButton")
                toggleBtn.Position = UDim2.fromOffset(80, 52)
                toggleBtn.Size = UDim2.fromOffset(110, 26)
                toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                toggleBtn.Font = Enum.Font.SourceSansBold
                toggleBtn.TextSize = 14
                toggleBtn.Text = "START (F6)"
                toggleBtn.Parent = frame
                Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 6)

                local qToggleBtn = Instance.new("TextButton")
                qToggleBtn.Position = UDim2.fromOffset(200, 52)
                qToggleBtn.Size = UDim2.fromOffset(140, 26)
                qToggleBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
                qToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
                qToggleBtn.Text = "🔘 Also Press Q: OFF"
                qToggleBtn.Font = Enum.Font.SourceSans
                qToggleBtn.TextSize = 12
                qToggleBtn.Parent = frame
                Instance.new("UICorner", qToggleBtn).CornerRadius = UDim.new(0, 6)

                local infoLabel = Instance.new("TextLabel")
                infoLabel.Position = UDim2.fromOffset(0, 84)
                infoLabel.Size = UDim2.fromOffset(340, 100)
                infoLabel.BackgroundTransparency = 1
                infoLabel.TextXAlignment = Enum.TextXAlignment.Left
                infoLabel.TextYAlignment = Enum.TextYAlignment.Top
                infoLabel.Font = Enum.Font.SourceSans
                infoLabel.TextSize = 12
                infoLabel.TextColor3 = Color3.fromRGB(150,150,255)
                infoLabel.Text = "Turbo Heartbeat engine ready. Lower interval for faster presses.\nTIP: intervals < 0.06s skip cooldown scan for max speed."
                infoLabel.Parent = frame

                -- ===== State =====
                local isRunning = false
                local useQKey = false
                local pressCount, successCount = 0, 0
                local lastSamples = {}
                local lastPressTime = 0
                local uiTick = 0

                local function simpleInterval(txt)
                    local n = tonumber(txt) or DEFAULT_INTERVAL
                    return clamp(n, MIN_INTERVAL, MAX_INTERVAL)
                end

                local function updateUI(nowTime)
                    if nowTime and nowTime - uiTick < 0.2 then return end -- throttle UI
                    uiTick = nowTime or tick()
                    local successRate = pressCount > 0 and math.floor((successCount/pressCount)*100) or 0
                    status.Text = string.format("%s | Mode: Turbo | Presses: %d | Success: %d%%",
                        isRunning and "🟢 ON" or "🔴 OFF", pressCount, successRate)
                    qToggleBtn.Text = string.format("🔘 Also Press Q: %s", useQKey and "ON" or "OFF")
                    qToggleBtn.BackgroundColor3 = useQKey and Color3.fromRGB(0,120,0) or Color3.fromRGB(80,80,80)
                end

                -- Cooldown sampling (optional; throttled; skipped on ultra-fast)
                local function recordCooldownSample()
                    local now = tick()
                    local dur = now - lastPressTime
                    if dur > 0.1 then
                        table.insert(lastSamples, dur)
                        if #lastSamples > SAMPLE_WINDOW then table.remove(lastSamples, 1) end
                        successCount += 1
                    end
                end

                -- Background cooldown "detector" (very light; non-blocking)
                task.spawn(function()
                    while screenGui.Parent do
                        task.wait(0.35)
                        if not isRunning then continue end
                        local interval = simpleInterval(intBox.Text)
                        if interval < 0.06 then continue end -- skip when very fast
                        recordCooldownSample()
                    end
                end)

                -- ===== Turbo Engine (Heartbeat accumulator) =====
                local accum = 0
                local hbConn
                local function startEngine()
                    if hbConn then hbConn:Disconnect() end
                    accum = 0
                    hbConn = RunService.Heartbeat:Connect(function(dt)
                        if not isRunning then return end
                        accum += dt
                        local interval = simpleInterval(intBox.Text)
                        while accum >= interval do
                            accum -= interval
                            pressCount += 1
                            lastPressTime = tick()
                            -- กด R เร็วและนิ่ง
                            local okR, errR = pcall(doKeyTap, DEFAULT_KEY)
                            if not okR then infoLabel.Text = "Key R error: " .. tostring(errR) end
                            -- กด Q ถ้าเปิด
                            if useQKey then
                                local okQ, errQ = pcall(doKeyTap, SECONDARY_KEY)
                                if not okQ then infoLabel.Text = "Key Q error: " .. tostring(errQ) end
                            end
                        end
                        updateUI(tick())
                    end)
                end

                local function stopEngine()
                    if hbConn then hbConn:Disconnect(); hbConn = nil end
                end

                -- ===== Controls =====
                local function toggleExecution()
                    isRunning = not isRunning
                    if isRunning then
                        toggleBtn.Text = "STOP (F6)"
                        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                        startEngine()
                    else
                        toggleBtn.Text = "START (F6)"
                        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                        stopEngine()
                    end
                    updateUI()
                end

                toggleBtn.MouseButton1Click:Connect(toggleExecution)
                qToggleBtn.MouseButton1Click:Connect(function()
                    useQKey = not useQKey
                    updateUI()
                end)

                intBox.FocusLost:Connect(function(enter)
                    if not enter then return end
                    intBox.Text = string.format("%.3f", simpleInterval(intBox.Text))
                    updateUI()
                end)

                UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    if input.KeyCode == HOTKEY_TOGGLE then
                        toggleExecution()
                    end
                end)

                -- Health monitor: ถ้า pressCount ไม่เปลี่ยน ให้รีสตาร์ท
                task.spawn(function()
                    local last = 0
                    while screenGui.Parent do
                        task.wait(10)
                        if isRunning and pressCount == last then
                            infoLabel.Text = "Health: stalled → auto-restart"
                            isRunning = false
                            stopEngine()
                            task.wait(0.25)
                            isRunning = true
                            startEngine()
                        end
                        last = pressCount
                    end
                end)

                -- Cleanup
                LocalPlayer.AncestryChanged:Connect(function()
                    isRunning = false
                    stopEngine()
                    pcall(function() screenGui:Destroy() end)
                end)

                print("Turbo engine loaded. Lower interval (e.g., 0.02–0.05) for faster R presses.")
            end
        else
            hakiButton.Text = "⚡ Auto Haki: OFF"
            hakiButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            -- ปิด AutoHaki GUI
            local GUI_NAME = "AutoHakiPermanent_v4_turbo"
            local CoreGui = game:GetService("CoreGui")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local existingGui = CoreGui:FindFirstChild(GUI_NAME) or (LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild(GUI_NAME))
            if existingGui then
                pcall(function() existingGui:Destroy() end)
            end
        end
    end)
end



-- ===================== TP TAB ======================
local function LoadTPTab()
    ClearContent()

    local plr = Players.LocalPlayer

    -- TP Farm Cave Demon
    local tpCaveBtn = Instance.new("TextButton", Content)
    tpCaveBtn.Size = UDim2.new(1, -20, 0, 36)
    tpCaveBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
    tpCaveBtn.Text = "TP Farm Cave Demon"
    tpCaveBtn.Font = Enum.Font.GothamBold
    tpCaveBtn.TextSize = 14
    tpCaveBtn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", tpCaveBtn).CornerRadius = UDim.new(0,6)
    local farmCaveDemon = CFrame.new(2164.1, 216, -662.9)
    tpCaveBtn.MouseButton1Click:Connect(function()
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
        task.wait(0.15)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = farmCaveDemon
        else
        end
        task.wait(0.2)
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
    end)

    -- ปุ่ม Show XYZ
local xyzBtn = Instance.new("TextButton", Content)
xyzBtn.Size = UDim2.new(1, -20, 0, 30)
xyzBtn.Text = "Show XYZ: " .. (runningXYZ and "ON" or "OFF")
xyzBtn.BackgroundColor3 = runningXYZ and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
xyzBtn.TextColor3 = Color3.new(1,1,1)
xyzBtn.Font = Enum.Font.GothamBold
xyzBtn.TextSize = 16
Instance.new("UICorner", xyzBtn).CornerRadius = UDim.new(0,6)

xyzBtn.MouseButton1Click:Connect(function()
    runningXYZ = not runningXYZ
    xyzBtn.Text = "Show XYZ: " .. (runningXYZ and "ON" or "OFF")
    xyzBtn.BackgroundColor3 = runningXYZ and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)

    if runningXYZ then
        if not xyzLabel then
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "XYZ_Display"
            screenGui.Parent = game:GetService("CoreGui")

            xyzLabel = Instance.new("TextLabel")
            xyzLabel.Size = UDim2.new(0,200,0,50)
            xyzLabel.Position = UDim2.new(0,20,0,200)
            xyzLabel.BackgroundTransparency = 0.3
            xyzLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
            xyzLabel.TextColor3 = Color3.new(1,1,1)
            xyzLabel.TextSize = 16
            xyzLabel.Font = Enum.Font.GothamBold
            xyzLabel.Parent = screenGui
        end

        task.spawn(function()
            while runningXYZ do
                local char = plr.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local pos = char.HumanoidRootPart.Position
                    xyzLabel.Text = string.format("X: %.1f Y: %.1f Z: %.1f", pos.X, pos.Y, pos.Z)
                end
                task.wait(0.1)
            end
            if xyzLabel then
                local parent = xyzLabel.Parent
                xyzLabel:Destroy()
                xyzLabel = nil
                if parent and parent:IsA("ScreenGui") then
                    parent:Destroy()
                end
            end
        end)
    else
        if xyzLabel then
            local parent = xyzLabel.Parent
            xyzLabel:Destroy()
            xyzLabel = nil
            if parent and parent:IsA("ScreenGui") then
                parent:Destroy()
            end
        end
    end
end)


    -- ฟังก์ชันสร้างปุ่ม TP
    local function createTPButton(name, cframe)
        local btn = Instance.new("TextButton", Content)
        btn.Size = UDim2.new(1, -20, 0, 40)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.CFrame = cframe
            end
        end)
    end

    -- === จุด TP (12 ปุ่ม) ===
    createTPButton("TP SAM", CFrame.new(-1302,218,-1352))
    createTPButton("desert island (sword)", CFrame.new(1231,224,-3242))
    createTPButton("Pyramid Island (af)", CFrame.new(120,278,4946))
    createTPButton("Fish-Man Island", CFrame.new(-1693,216,-328))
    createTPButton("Purple Island", CFrame.new(-5282,534,-7762))
    createTPButton("Snow Islands Main", CFrame.new(6313,541,-1330))
    createTPButton("Snow Islands(Gun)", CFrame.new(-1843,222,3406))
    createTPButton("Krizma Islands", CFrame.new(-1074,361,1671))
    createTPButton("Bar Islands", CFrame.new(1502,260,2173))
    createTPButton("Vokun Islands", CFrame.new(4572,217,5059))
    createTPButton("Treehouse Islands", CFrame.new(1120,217,3351))
    createTPButton("TP Quest", CFrame.new(898,270,1219))
    createTPButton("BigTree", CFrame.new(-6029,402,-8.5))

end
-- ===================================================


-- Apply states to player each step (walkspeed/jump/hipheight, noclip)
RunService.Stepped:Connect(function()
    -- Noclip
    if States.Misc.Noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    -- Apply Humanoid modifications
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if States.Misc.WalkSpeedEnabled then pcall(function() hum.WalkSpeed = States.Misc.WalkSpeed end) end
        if States.Misc.JumpEnabled then pcall(function() hum.JumpPower = States.Misc.JumpPower end) end
        if States.Misc.HipHeightEnabled then pcall(function() hum.HipHeight = States.Misc.HipHeight end) end
    end
end)

-- ClickTP mouse binding
mouse.Button1Down:Connect(function()
    if States.Misc.ClickTP and mouse.Target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0,5,0))
    end
end)

-- CharacterAdded: apply misc props and resync flight/autoTP
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        if States.Misc.WalkSpeedEnabled then pcall(function() hum.WalkSpeed = States.Misc.WalkSpeed end) end
        if States.Misc.JumpEnabled then pcall(function() hum.JumpPower = States.Misc.JumpPower end) end
        if States.Misc.HipHeightEnabled then pcall(function() hum.HipHeight = States.Misc.HipHeight end) end
    end
    -- resync AutoTP hold
    if States.AutoTP then
        if autoTPConnection then autoTPConnection:Disconnect(); autoTPConnection = nil end
        autoTPConnection = RunService.Heartbeat:Connect(function()
            if not States.AutoTP then
                if autoTPConnection then autoTPConnection:Disconnect(); autoTPConnection = nil end
                return
            end
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    player.Character.HumanoidRootPart.CFrame = SafeZoneCFrame
                end)
            end
        end)
    end
end)

-- AutoEquip Watcher (Hotfix)
local autoEquipThread = nil
local function StartAutoEquipWatcher()
    if autoEquipThread then return end
    autoEquipThread = task.spawn(function()
        while true do
            task.wait(1)
            if States.AutoEquip.Enabled and States.AutoEquip.Weapon then
                if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    local backpack = player:FindFirstChild("Backpack")
                    if backpack then
                        local tool = backpack:FindFirstChild(States.AutoEquip.Weapon)
                        if tool and humanoid and not player.Character:FindFirstChild(States.AutoEquip.Weapon) then
                            pcall(function() humanoid:EquipTool(tool) end)
                        end
                    end
                end
            end
        end
    end)
end
StartAutoEquipWatcher()

-- เก็บปุ่มทุกแท็บไว้ในตาราง
local TabButtons = {
    Main = MainBtn,
    Weapon = WeaponBtn,
    Player = PlayerBtn,
    DevilFruit = DevilFruitBtn,
    Misc = MiscBtn,
    Drink = DrinkBtn,
    Teleport = TeleportBtn,
    Server = ServerBtn,
}

-- Enhanced function to change button colors with smooth animation
local function SetActiveTab(tabName)
    for name, btn in pairs(TabButtons) do
        if name == tabName then
            -- Active tab - golden color with animation
            local tween = TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 215, 0)})
            tween:Play()
        else
            -- Inactive tab - default color with animation
            local tween = TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(35,35,50)})
            tween:Play()
        end
    end
end

-- แก้ Tab bindings ให้เรียก SetActiveTab ด้วย
MainBtn.MouseButton1Click:Connect(function()
    StopFruitThreads()
    LoadMainTab()
    SetActiveTab("Main")
end)

WeaponBtn.MouseButton1Click:Connect(function()
    StopFruitThreads()
    LoadSwordsTab()
    SetActiveTab("Weapon")
end)

PlayerBtn.MouseButton1Click:Connect(function()
    StopFruitThreads()
    LoadPlayerTab()
    SetActiveTab("Player")
end)

DevilFruitBtn.MouseButton1Click:Connect(function()
    StopFruitThreads()
    LoadDevilFruitTab()
    SetActiveTab("DevilFruit")
end)

MiscBtn.MouseButton1Click:Connect(function()
    StopFruitThreads()
    LoadMiscTab()
    SetActiveTab("Misc")
end)


DrinkBtn.MouseButton1Click:Connect(function()
    LoadFruitTab()
    SetActiveTab("Drink")
end)


TeleportBtn.MouseButton1Click:Connect(function()
    StopFruitThreads()
    LoadTPTab()
    SetActiveTab("Teleport")
end)

ServerBtn.MouseButton1Click:Connect(function()
    StopFruitThreads()
    LoadServerTab()
    SetActiveTab("Server")
end)


-- ตั้งค่าเริ่มต้น (เปิดมาหน้า Main)
SetActiveTab("Main")

-- Load default
LoadMainTab()
-- END OF SCRIPT (ปิด end ครบ)



