local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage(
        {
            type = "ui",
            status = bool
        }
    )
end

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            if nearATM() then
                exports["vrp_textui"]:Open("Apasa [E] pentru a deschide meniul ", "#00FF00", "left")
                if IsControlJustPressed(1, Config.KeyToOpenMenu) then
                    SetDisplay(true)
                    TriggerScreenblurFadeIn(750)
                    TriggerServerEvent("nfr_banking:requestMoneyAmountInBank")
                end
            else
                exports["vrp_textui"]:Close()
                SetDisplay(false)
            end

            if IsControlJustPressed(1, 322) then
                SetDisplay(false)
            end
        end
    end
)

RegisterNetEvent("nfr_banking:updateBankBalance")
AddEventHandler(
    "nfr_banking:updateBankBalance",
    function(balance, userID)
        SendNUIMessage({type = "updateBankBalance", balance = balance, userID = userID})
    end
)

RegisterNUICallback(
    "exit",
    function()
        if display then
            TriggerScreenblurFadeOut(750) 
            SetDisplay(false) 
        end
    end
)

RegisterNUICallback(
    "action",
    function(data)
        TriggerServerEvent("nfr_banking:action", data.data)
    end
)

function nearBank()
    local playerPed = GetPlayerPed(-1)
    local playerLocation = GetEntityCoords(playerPed, 0)
    for _, bankCoords in pairs(Config.Banks) do
        local distance =
            #(vector3(bankCoords.x, bankCoords.y, bankCoords.z) -
            vector3(playerLocation["x"], playerLocation["y"], playerLocation["z"]))
        if distance <= 3 then
            return true
        end
    end
end

function nearATM()
    local playerPed = PlayerPedId()
    local playerLocation = GetEntityCoords(playerPed, 0)
    for _, atmCoords in pairs(Config.ATMs) do
        local distance =
            #(vector3(atmCoords.x, atmCoords.y, atmCoords.z) -
            vector3(playerLocation["x"], playerLocation["y"], playerLocation["z"]))
        if distance <= 2 then
            return true
        end
    end
end

Citizen.CreateThread(
    function()
        while display do
            Citizen.Wait(10)
            DisableControlAction(0, 1, display)
            DisableControlAction(0, 2, display)
            DisableControlAction(0, 142, display)
            DisableControlAction(0, 18, display)
            DisableControlAction(0, 106, display)
        end
    end
)

Citizen.CreateThread(
    function()
        if Config.ShowBankBlips then
            for _, bankCoords in ipairs(Config.Banks) do
                local bankBlip = AddBlipForCoord(bankCoords.x, bankCoords.y, bankCoords.z)
                SetBlipSprite(bankBlip, bankCoords.id)
                SetBlipDisplay(bankBlip, 4)
                SetBlipScale(bankBlip, 0.9)
                SetBlipColour(bankBlip, 2)
                SetBlipAsShortRange(bankBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(tostring(bankCoords.name))
                EndTextCommandSetBlipName(bankBlip)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        if Config.ShowATMBlips then
            for _, atmCoords in ipairs(Config.ATMs) do
                local atmBlip = AddBlipForCoord(atmCoords.x, atmCoords.y, atmCoords.z)
                SetBlipSprite(atmBlip, atmCoords.id)
                SetBlipDisplay(atmBlip, 4)
                SetBlipScale(atmBlip, 0.9)
                SetBlipColour(atmBlip, 2)
                SetBlipAsShortRange(atmBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(tostring(atmCoords.name))
                EndTextCommandSetBlipName(atmBlip)
            end
        end
    end
)
