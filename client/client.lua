vRP = Proxy.getInterface("vRP")
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance, user_id)
	local id = PlayerId()
	local playerName = GetPlayerName(id)

	SendNUIMessage({
		type = "bankBalance",
		balance = balance,
        userid = user_id
		})
end)

CreateThread(function()
    local locations = Config.ATMs
    while true do
        Citizen.Wait(2000) -- teoretic orice valoare mai mare de 1s consuma aproape nimic
        for i = 1, #locations do
        local location = locations[i]
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dst = #(pos - location)
        
        while dst <= 10.0 do
        if dst <= 3.0 then
            exports['vrp_textui']:Open('Apasa [E] pentru a deschide meniul ', 'darkgrey', 'left') 
            if IsControlJustPressed(0, 46) then
                TriggerServerEvent('NFR:balance')
                Citizen.Wait(100)
                SetDisplay(not display)
            end
        else 
            exports['vrp_textui']:Close()
        end
          Citizen.Wait(1)
          dst = #(GetEntityCoords(ped) - location)
        end
    end
    end
end)
RegisterNUICallback("withdraw", function(data)
    TriggerServerEvent('NFR:withdraw', tonumber(data.amount))
    TriggerServerEvent('NFR:balance')
    SetDisplay(false)
end)
RegisterNUICallback("deposit", function(data)
    TriggerServerEvent('NFR:deposit', tonumber(data.amount))
    TriggerServerEvent('NFR:balance')
    SetDisplay(false)
end)
RegisterNUICallback("transfer", function(data)
    TriggerServerEvent('NFR:transfer', tonumber(data.amount),data.userid)
    TriggerServerEvent('NFR:balance')
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    vRP.notify({""..data.error.."",4})
end)

RegisterNUICallback("exit", function()
    Citizen.Wait(10)
    SetDisplay(false)
    estelider = false
    TriggerServerEvent('petrol:stop')
end)



function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(10)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)