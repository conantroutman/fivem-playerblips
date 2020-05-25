local players = nil
local availableColors = {28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59}
local occupiedColors = {}

RegisterNetEvent('checkPlayerPaused')
RegisterNetEvent('playerConnecting')


AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)

end)

AddEventHandler('checkPlayerPaused', function(player)
    print(player)
    --TriggerClientEvent("isPaused", player)
end)

