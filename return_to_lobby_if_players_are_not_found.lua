local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 300, 0, 40)
textLabel.Position = UDim2.new(0.5, -150, 0.8, -80)
textLabel.Text = ""
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
textLabel.TextStrokeTransparency = 0
textLabel.Parent = screenGui

local function displayText (message)
    textLabel.Text = message
    wait(3)
    textLabel.Text = ""
end

local scriptExecuted = false
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local lobbyPlaceId = 8304191830

local function isPlayerInLobby()
    return game.PlaceId == lobbyPlaceId
end

local function returnToLobby()
    replicatedStorage:WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("teleport_back_to_lobby"):InvokeServer("_lobbytemplategreen9")
end

local function buangScript()
    displayText("Executing BuangHub..!")
    script_key = _G.config.buangKey
    loadstring(game:HttpGet("https://raw.githubusercontent.com/buang5516/buanghub/main/PremiumBuangHub.lua"))()
    scriptExecuted = true
    removeScript()
end

local function checkPlayer()
    if scriptExecuted then return end

    local playerFound = 0
    for _, playerName in ipairs(_G.config.playerNames) do
        for _, p in ipairs(players:GetPlayers()) do
            if p.Name == playerName then
                playerFound = playerFound + 1
                break
            end
        end
    end

    if playerFound < _G.config.requiredPlayers then
        if not isPlayerInLobby() then
            returnToLobby()
        end
    else
        buangScript()
    end
end

local function removeScript()
    script:Destroy()
end

while not scriptExecuted do
    displayText("Checking players...")
    checkPlayer()
    wait(_G.config.waitTime)
end
