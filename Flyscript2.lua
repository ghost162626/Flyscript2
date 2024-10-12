local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local ChatService = game:GetService("Chat")

local flying = false
local bodyGyro
local textLabel

-- Criar a interface do usuário
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
textLabel = Instance.new("TextLabel", screenGui)
textLabel.Size = UDim2.new(0, 200, 0, 50)
textLabel.Position = UDim2.new(0.5, -100, 0, 0)
textLabel.Text = ""
textLabel.Visible = false

local function showMessage(text)
    textLabel.Text = text
    textLabel.Visible = true
    wait(0.4)
    textLabel.Visible = false
end

local function fly()
    flying = not flying

    if flying then
        character.Humanoid.PlatformStand = true
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Parent = character.PrimaryPart
        bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyGyro.P = 3000
        
        while flying do
            local direction = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + workspace.CurrentCamera.CFrame.RightVector
            end

            character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame + direction * 5 * 0.1 + Vector3.new(0, 0.1, 0)) -- Ajuste de altura
            bodyGyro.CFrame = CFrame.new(character.PrimaryPart.Position, character.PrimaryPart.Position + direction)
            wait(0.1)
        end
        
        bodyGyro:Destroy()
        character.Humanoid.PlatformStand = false
        showMessage("Voo Desativado")
    else
        showMessage("Voo Ativado")
    end
end

-- Comando de chat
ChatService.OnPlayerChatted:Connect(function(player, message)
    if message:lower() == "/fly" then
        fly()
        showMessage(flying and "Voo Ativado" or "Voo Desativado")
    end
end)
