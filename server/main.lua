local QBCore = exports['qb-core']:GetCoreObject()

-- Create the cigarette pack
QBCore.Functions.CreateUseableItem("redwoodcigs", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('cigarettes:client:UseCigPack', src, item)
end)

QBCore.Functions.CreateUseableItem("cardiaquecigs", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('cigarettes:client:UseCigPack', src, item)
end)

QBCore.Functions.CreateUseableItem("yukoncigs", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('cigarettes:client:UseCigPack', src, item)
end)

-- Create the cigarette
QBCore.Functions.CreateUseableItem("cigarette", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName("lighter") then
			if Player.Functions.RemoveItem(item.name, 1, item.slot) then
				TriggerClientEvent("cigarettes:client:UseCigarette", src)
			end
    else
        TriggerClientEvent("QBCore:Notify", source, "You don't have a lighter", "error")
    end
end)

-- Cigarette Pack Damage
RegisterNetEvent('cigarettes:server:RemoveCigarette', function(hp, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if hp == 1 then
        Player.Functions.RemoveItem('redwoodcigs', 1, data.slot)
        TriggerClientEvent("cigarettes:client:removeCigPack")
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

-- Cigarette Pack Opened
RegisterNetEvent('cigarettes:server:addCigarette', function(hp, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("cigarette", 1)
end)
