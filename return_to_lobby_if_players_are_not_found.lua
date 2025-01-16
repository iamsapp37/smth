local waitTime = 10
local buangKey = "put your script key in here"
local playerNames = {
    "buang",
    "buang2",
    "buang3"
}
local requiredPlayers = 2

local scriptExecuted = false
function isPlayerInLobby()
    local player = game:GetService("Players").LocalPlayer
    local currentPlaceId = game.PlaceId
    local lobbyPlaceId = 8304191830
    return currentPlaceId == lobbyPlaceId
end

function checkPlayer()
    if scriptExecuted then return end

    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local playerFound = 0

    for _, playerName in ipairs(playerNames) do
        for _, p in ipairs(players:GetPlayers()) do
            if p.Name == playerName then
                playerFound = playerFound + 1
                break
            end
        end
    end

    if playerFound < requiredPlayers then
        if not isPlayerInLobby() then
            returnToLobby()
        end
    else
        buangScript()
    end
end

function returnToLobby()
    local args = {
        [1] = "_lobbytemplategreen9"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("teleport_back_to_lobby"):InvokeServer(unpack(args))
end

function buangScript()
    script_key = buangKey
    loadstring(game:HttpGet("https://raw.githubusercontent.com/buang5516/buanghub/main/PremiumBuangHub.lua"))()
    scriptExecuted = true
end

while true do
    wait(waitTime)
    checkPlayer()
end
