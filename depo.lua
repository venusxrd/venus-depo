QBCore = nil
Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        sleep = 100
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        
        for k, v in pairs(Config.Depo) do
            local dist = #(plyCoords - v)

            if dist < Config.Mesafe then
                sleep = 3
                QBCore.Functions.DrawText3D(v.x, v.y, v.z, Config.Yazi)
                if IsControlJustPressed(0, 38) then
                    local cid = QBCore.Functions.GetPlayerData().citizenid
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Kişisel Depo - "..cid,  {
                        maxweight = Config.Kilo,
                        slots = Config.Slots,
                        owner = cid
                    })
                end
            end
        end
        Wait(sleep)
    end
end)