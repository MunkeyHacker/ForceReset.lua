local module = {}

local Players = game:GetService("Players")
local player = Players.LocalPlayer

module.mode = "Humanoid"

function module.doReset()

    local char = player.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")

    if module.mode == "Humanoid" then
        if hum then hum.Health = 0 end

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

function module.init(tab)

    local box = tab:AddLeftGroupbox("Force Reset")

    box:AddDropdown("FRMode",{
        Values = {"Humanoid","Destroy","LoadCharacter","Void"},
        Default = 1,
        Text = "Reset Mode"
    })

    Options.FRMode:OnChanged(function()
        module.mode = Options.FRMode.Value
    end)

    box:AddButton("Force Reset",function()
        module.doReset()
    end)

end

return module