
-- MeuHub Base (Compatível com Fluxus)

-- ===============================
-- SERVIÇOS
-- ===============================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ===============================
-- TESTE DE EXECUÇÃO
-- ===============================
print("MeuHub iniciou")

-- ===============================
-- UI LIBRARY (Rayfield)
-- ===============================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ===============================
-- JANELA
-- ===============================
local Window = Rayfield:CreateWindow({
    Name = "Meu Hub",
    LoadingTitle = "Meu Hub",
    LoadingSubtitle = "by thebased77",
    KeySystem = false
})

-- ===============================
-- ABAS
-- ===============================
local FarmTab = Window:CreateTab("Farm")
local PlayerTab = Window:CreateTab("Player")

-- ===============================
-- FARM
-- ===============================
_G.AutoFarm = false

FarmTab:CreateToggle({
    Name = "Auto Farm (Teste)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value

        task.spawn(function()
            while _G.AutoFarm do
                task.wait(1)
                print("Auto Farm rodando")
            end
        end)
    end
})

-- ===============================
-- PLAYER
-- ===============================
PlayerTab:CreateButton({
    Name = "Notificação de Teste",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Meu Hub",
            Text = "Funcionando no Fluxus!",
            Duration = 4
        })
    end
})
