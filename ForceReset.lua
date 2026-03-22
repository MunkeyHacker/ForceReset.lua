local module = {}

local Players = game:GetService("Players")
local player = Players.LocalPlayer

module.meta = {
    name = "Force Reset",
    tab = "Movement",
    side = "Right",
    priority = 2
}

module.mode = "Humanoid"

local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

function module.doReset()

    local char = getChar()
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")

    if module.mode == "Humanoid" then

        if hum then
            hum.Health = 0
        end

    elseif module.mode == "Destroy" then

        char:Destroy()

    elseif module.mode == "LoadCharacter" then

        player:LoadCharacter()

    elseif module.mode == "Void" then

        if root then
            root.CFrame = CFrame.new(0,-500,0)
        end

    end

end

-- public call (other modules / keybind engine etc)
function module.reset()
    module.doReset()
end

function module.init(ctx)

    local box = ctx.box

    box:AddDropdown("FRMode",{
        Values = {"Humanoid","Destroy","LoadCharacter","Void"},
        Default = "Humanoid",
        Text = "Reset Mode"
    })

    Options.FRMode:OnChanged(function()
        module.mode = Options.FRMode.Value
    end)

    box:AddButton("Force Reset",function()
        module.reset()
    end)

end

return module
