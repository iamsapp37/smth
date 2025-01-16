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
    script_key = _G.config.buangKey
    loadstring(game:HttpGet("https://raw.githubusercontent.com/buang5516/buanghub/main/PremiumBuangHub.lua"))()
    scriptExecuted = true
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

while not scriptExecuted do
    wait(_G.config.waitTime)
    checkPlayer()
end
