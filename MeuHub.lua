-- MeuHub Nível 3 – Blox Fruits
-- Compatível com Fluxus

-- ===============================
-- SERVIÇOS
-- ===============================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ===============================
-- ANTI AFK / ANTI KICK
-- ===============================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ===============================
-- UI (Rayfield)
-- ===============================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Meu Hub – Auto Farm",
    LoadingTitle = "Meu Hub",
    LoadingSubtitle = "Nível 3",
    KeySystem = false
})

local FarmTab = Window:CreateTab("🌾 Farm")
local SafetyTab = Window:CreateTab("🛡️ Safety")

-- ===============================
-- VARIÁVEIS
-- ===============================
_G.AutoFarm = false
_G.SelectedMob = "Bandit" -- padrão sea 1
_G.MobDistance = 3

-- ===============================
-- FUNÇÕES ÚTEIS
-- ===============================
local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function GetHRP()
    local char = GetCharacter()
    return char:WaitForChild("HumanoidRootPart")
end

local function EquipBasicWeapon()
    local char = GetCharacter()
    for _,tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = char
            return tool
        end
    end
end

-- ===============================
-- PEGAR MOBS
-- ===============================
local function GetMobs()
    local mobs = {}
    if workspace:FindFirstChild("Enemies") then
        for _,mob in pairs(workspace.Enemies:GetChildren()) do
            if mob.Name == _G.SelectedMob
            and mob:FindFirstChild("Humanoid")
            and mob.Humanoid.Health > 0
            and mob:FindFirstChild("HumanoidRootPart") then
                table.insert(mobs, mob)
            end
        end
    end
    return mobs
end

-- ===============================
-- JUNTAR MOBS (STACK)
-- ===============================
local function StackMobs(mobs)
    if #mobs == 0 then return end
    local baseCF = mobs[1].HumanoidRootPart.CFrame
    for _,mob in pairs(mobs) do
        mob.HumanoidRootPart.CFrame = baseCF
        mob.HumanoidRootPart.CanCollide = false
    end
end

-- ===============================
-- ATAQUE BÁSICO
-- ===============================
local function BasicAttack()
    local tool = GetCharacter():FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Handle") then
        tool:Activate()
    end
end

-- ===============================
-- AUTO FARM LOOP
-- ===============================
task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoFarm then
            local hrp = GetHRP()
            local mobs = GetMobs()

            if #mobs > 0 then
                StackMobs(mobs)

                hrp.CFrame = mobs[1].HumanoidRootPart.CFrame * CFrame.new(0, 0, _G.MobDistance)
                EquipBasicWeapon()
                BasicAttack()
            end
        end
    end
end)

-- ===============================
-- UI – FARM
-- ===============================
FarmTab:CreateToggle({
    Name = "Auto Farm (Completo)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
    end
})

FarmTab:CreateInput({
    Name = "Nome do Mob",
    PlaceholderText = "Ex: Bandit",
    Callback = function(Text)
        if Text ~= "" then
            _G.SelectedMob = Text
        end
    end
})

FarmTab:CreateSlider({
    Name = "Distância do Mob",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 3,
    Callback = function(Value)
        _G.MobDistance = Value
    end
})

-- ===============================
-- SAFETY
-- ===============================
SafetyTab:CreateButton({
    Name = "Anti AFK (Ativo)",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Safety",
            Text = "Anti AFK já está ativo",
            Duration = 4
        })
    end
})

print("MeuHub Nível 3 carregado com sucesso")
