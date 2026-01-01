# MeuHub
MeuHubScripts
--[[ 
    MeuHub Base
    Criado por: Você
    Uso educacional
]]

-- 🔒 Proteção básica contra crash
pcall(function()

-- ===============================
-- 📦 SERVIÇOS
-- ===============================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ===============================
-- 🌐 UI LIBRARY (Rayfield)
-- ===============================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Meu Hub",
    LoadingTitle = "Meu Hub",
    LoadingSubtitle = "by Você",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MeuHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- ===============================
-- 📑 ABAS
-- ===============================
local FarmTab = Window:CreateTab("🌾 Farm")
local PlayerTab = Window:CreateTab("👤 Player")
local TeleportTab = Window:CreateTab("🗺️ Teleport")
local SettingsTab = Window:CreateTab("⚙️ Settings")

-- ===============================
-- 🌾 FARM TAB
-- ===============================
_G.AutoFarm = false

local function AutoFarmLoop()
    task.spawn(function()
        while _G.AutoFarm do
            task.wait(0.5)

            if LocalPlayer.Character
            and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                print("Auto Farm rodando...")
                -- Aqui você coloca a lógica real depois
            end
        end
    end)
end

FarmTab:CreateToggle({
    Name = "Auto Farm (Base)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        if Value then
            AutoFarmLoop()
        end
    end
})

-- ===============================
-- 👤 PLAYER TAB
-- ===============================
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 300},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        if LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        if LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

-- ===============================
-- 🗺️ TELEPORT TAB
-- ===============================
TeleportTab:CreateButton({
    Name = "Teleportar para Spawn",
    Callback = function()
        if LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(0, 10, 0)
        end
    end
})

-- ===============================
-- ⚙️ SETTINGS TAB
-- ===============================
SettingsTab:CreateButton({
    Name = "Recarregar Hub",
    Callback = function()
        Rayfield:Destroy()
        loadstring(game:HttpGet("SEU_LINK_RAW_AQUI"))()
    end
})

SettingsTab:CreateButton({
    Name = "Fechar Hub",
    Callback = function()
        Rayfield:Destroy()
    end
})

end)
