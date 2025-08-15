-- LocalScript in StarterPlayerScripts
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Which team color to target
local TARGET_TEAMCOLOR = BrickColor.new("Bright red")

-- Find closest red-team player
local function getClosestRedPlayer()
    local closestPlayer = nil
    local closestDist = math.huge
    local myCharacter = LocalPlayer.Character
    if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myCharacter.HumanoidRootPart.Position

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.TeamColor == TARGET_TEAMCOLOR then
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPlayer = plr
                end
            end
        end
    end
    return closestPlayer
end

-- Update camera to lock on
RunService.RenderStepped:Connect(function()
    local targetPlayer = getClosestRedPlayer()
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPlayer.Character.HumanoidRootPart.Position)
    end
end)
