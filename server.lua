local deleteInterval = 5 * 60 * 1000 -- Co ile będzie usuwać puste pojazdy
local warningTime = 120 * 1000 -- Ile przed usunięciem ma wysyłać komunikat

function deleteEmptyVehicles()
    for _, vehicle in ipairs(GetAllVehicles()) do
        if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
            DeleteEntity(vehicle)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(deleteInterval - warningTime)

        TriggerClientEvent('txcl:showAnnouncement', -1, "Puste pojazdy zostaną usunięte za 2 minuty", "Smieciarka")

        Citizen.Wait(warningTime)

        deleteEmptyVehicles()

        TriggerClientEvent('txcl:showAnnouncement', -1, "Wszystkie puste pojazdy zostały usunięte.", "Smieciarka")
    end
end)