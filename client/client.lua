local display = false

Citizen.CreateThread(
    function()
        while true do
            Wait(7)
            if nearBank() or nearATM() then
                exports["vrp_textui"]:Open("Apasa [E] pentru a deschide meniul ", "#00FF00", "left")
                if IsControlJustPressed(1, Config.KeyToOpenMenu) then
                    SetDisplay(true)
                    TriggerServerEvent("bank:balance")
                end
            else
                exports["vrp_textui"]:Close()
            end

            if IsControlJustPressed(1, 322) then
                SetDisplay(false)
                SendNUIMessage({type = "close"})
            end
        end
    end
)

RegisterNUICallback(
    "exit",
    function()
        TriggerScreenblurFadeOut(750)
        SetDisplay(false)
    end
)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        status = bool
    })
end

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
            DisableControlAction(0, 322, display)
            DisableControlAction(0, 106, display)
        end
    end
)
