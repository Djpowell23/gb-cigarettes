local QBCore = exports['qb-core']:GetCoreObject()

local cigpackHp = 20
local cigpackData = {}

-- Cigarette Pack
RegisterNetEvent('cigarettes:client:UseCigPack', function(ItemData) -- On Item Use (registered server side)
    LocalPlayer.state:set("inv_busy", true, true)
    QBCore.Functions.Progressbar("pickup_sla", "Opening Cigarette Pack...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_clipboard@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(playerPed, "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("You got a cigarette from the pack", "success")
        TriggerServerEvent('QBCore:Server:AddItem', "cigarette", 1) -- give cigarette from pack
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cigarette"], "add")
        end, function()
        QBCore.Functions.Notify("Cancelled...", "error")
    end)
    LocalPlayer.state:set("inv_busy", false, true)
    cigpackHp = ItemData.info.uses
    cigpackData = ItemData
    TriggerServerEvent("cigarettes:server:RemoveCigarette", cigpackHp, cigpackData)
end)

-- Cigarette Use
RegisterNetEvent('cigarettes:client:UseCigarette')
AddEventHandler('cigarettes:client:UseCigarette', function()
    QBCore.Functions.Progressbar("smoke_joint", "Lighting cigarette...", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
        TriggerEvent('animations:client:EmoteCommandStart', {"smoke"})
    }, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cigarette"], "remove") -- update cig count
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"smoke3"})
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"smoke"})
        end
        TriggerEvent("evidence:client:SetStatus", "tobaccosmell", 300)
        TriggerEvent('animations:client:SmokeCig')
    end)
end)

RegisterNetEvent('cigarettes:client:UpdateCigPack', function(cigpackHp)
    hp = cigpackHp
end)