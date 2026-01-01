-- MeuHub Nível 4 – Blox Fruits
-- Auto Quest + Combat + Fly Farm + Fast Punch
-- Compatível com Fluxus

-- ===============================
-- SERVIÇOS
-- ===============================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- ===============================
-- ANTI AFK
-- ===============================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ===============================
-- FUNÇÕES BASE
-- ===============================
local function Char()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function HRP()
    return Char():WaitForChild("HumanoidRootPart")
end

-- ===============================
-- EQUIPAR COMBAT
-- ===============================
local function EquipCombat()
    local char = Char()
    for _,tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Combat" then
            tool.Parent = char
            return tool
        end
    end
end

-- ===============================
-- PEGAR QUEST (SEA 1)
-- ===============================
local function GetQuest()
    for _,npc in pairs(workspace.NPCs:GetChildren()) do
        if npc:FindFirstChild("Head")
        and npc.Head:FindFirstChild("QuestPrompt") then
            HRP().CFrame = npc.Head.CFrame * CFrame.new(0, 0, -3)
            task.wait(0.5)
            fireproximityprompt(npc.Head.QuestPrompt)
            task.wait(0.5)
            return
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
            if mob:FindFirstChild("Humanoid")
            and mob.Humanoid.Health > 0
            and mob:FindFirstChild("HumanoidRootPart") then
                table.insert(mobs, mob)
            end
        end
    end
    return mobs
end

-- ===============================
-- STACK MOBS
-- ===============================
local function StackMobs(mobs)
    if #mobs == 0 then return end
    local cf = mobs[1].HumanoidRootPart.CFrame
    for _,mob in pairs(mobs) do
        mob.HumanoidRootPart.CFrame = cf
        mob.HumanoidRootPart.CanCollide = false
    end
end

-- ===============================
-- FAST PUNCH + "ÁREA"
-- ===============================
local function FastPunch(mobs)
    local tool = Char():FindFirstChild("Combat")
    if not tool then return end

    for _,mob in pairs(mobs) do
        HRP().CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 6, 0)
        tool:Activate()
        task.wait(0.05) -- velocidade do soco
    end
end

-- ===============================
-- UI (Rayfield)
-- ===============================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Meu Hub – Nível 4",
    LoadingTitle = "Auto Quest & Combat",
    LoadingSubtitle = "by thebased77",
    KeySystem = false
})

local FarmTab = Window:CreateTab("🌾 Farm")

_G.AutoFarm = false

FarmTab:CreateToggle({
    Name = "Auto Quest + Farm (Combat)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoFarm = v
    end
})

-- ===============================
-- LOOP PRINCIPAL
-- ===============================
task.spawn(function()
    while task.wait(0.15) do
        if _G.AutoFarm then
            EquipCombat()
            GetQuest()

            local mobs = GetMobs()
            if #mobs > 0 then
                StackMobs(mobs)
                FastPunch(mobs)
            end
        end
    end
end)

print("MeuHub Nível 4 carregado")
