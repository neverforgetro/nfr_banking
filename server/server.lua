local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")
RegisterNetEvent('NFR:balance')
AddEventHandler('NFR:balance', function()
    local _source = source
	local thePlayer = _source
	local user_id = vRP.getUserId({thePlayer})
    local bankMoney = vRP.getBankMoney({user_id})
    TriggerClientEvent('currentbalance1', thePlayer, bankMoney, user_id)
end)

RegisterServerEvent('NFR:withdraw')
AddEventHandler('NFR:withdraw', function(amount)
    local _source = source
	local user_id = vRP.getUserId({_source})
    local bankMoney = vRP.getBankMoney({user_id})
    local value = bankMoney-amount
    if amount > bankMoney then
        vRPclient.notify(_source,{"Nu detii aceasta suma!"},4)
    else
        vRP.setBankMoney({user_id,value})
        vRP.giveMoney({user_id,amount})
        vRPclient.notify(_source,{"Ai extras "..amount.."$ din contul tau bancar"},4)
    end
end)
RegisterServerEvent('NFR:deposit')
AddEventHandler('NFR:deposit', function(amount)
    local _source = source
	local user_id = vRP.getUserId({_source})
    local pocketMoney = vRP.getMoney({user_id})
    local value = pocketMoney-amount
    if amount > pocketMoney then
        vRPclient.notify(_source,{"Nu detii aceasta suma!"},4)
    else
        vRP.setMoney({user_id,value})
        vRP.giveBankMoney({user_id,amount})
        vRPclient.notify(_source,{"Ai depus "..amount.."$ in contul tau bancar"},4)
    end
end)
RegisterServerEvent('NFR:transfer')
AddEventHandler('NFR:transfer', function(amount, userid)
    local _source = source
    local touser_id = vRP.getUserId({userid})
    local tosource =  vRP.getUserSource({touser_id})
	local user_id = vRP.getUserId({_source})
    local bankMoney = vRP.getBankMoney({user_id})
    local value = bankMoney-amount
        if amount > bankMoney then 
            vRPclient.notify(_source,{"Nu detii aceasta suma!"},4)
        else
            vRP.setBankMoney({user_id,value})
            vRPclient.notify(_source,{"Ai trimis "..amount.." $ catre ID: "..user_id..""},4)

            vRP.giveBankMoney({user_id,amount})
            vRPclient.notify(_source,{"Ai primit "..amount.." din partea lui ID:"..user_id..""},4)
        end
end)