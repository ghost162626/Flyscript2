local function showMessage(text)
    textLabel.Text = text
    textLabel.Visible = true
    wait(0.4)
    textLabel.Visible = false
end

-- Atualize esta parte do código para adicionar seu texto
local function fly()
    flying = not flying

    if flying then
        character.Humanoid.PlatformStand = true
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Parent = character.PrimaryPart
        bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyGyro.P = 3000
        
        while flying do
            -- Lógica de movimento permanece a mesma
            wait(0.1)
        end
        
        bodyGyro:Destroy()
        character.Humanoid.PlatformStand = false
        showMessage("by ghost")
    else
        showMessage("Voo Desativado")
    end
end
