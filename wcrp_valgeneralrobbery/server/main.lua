VORP = exports.vorp_inventory:vorp_inventoryApi()

data = {}
TriggerEvent("vorp_inventory:getData",function(call)
    data = call
end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)



RegisterNetEvent("wcrp_robbery:startToRob")
AddEventHandler("wcrp_robbery:startToRob", function()
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local count = VORP.getItemCount(_source, "lockpick")

    if count >= 1 then
        playerjobloop()
        VORP.subItem(_source,"lockpick", 1)
        TriggerClientEvent('wcrp_robbery:startAnimation', _source)
        Wait(30000)
        TriggerClientEvent("vorp:TipBottom", _source, "You have successfully lockpicked the register", 6000)
        TriggerClientEvent('wcrp_robbery:startTimer', _source)
    else
        TriggerClientEvent("vorp:TipBottom", _source, "You dont have a lockpick", 6000)
    end     
end)



RegisterNetEvent("wcrp_robbery:payout")
AddEventHandler("wcrp_robbery:payout", function()
    local Character = VorpCore.getUser(source).getUsedCharacter
    local _source = source
        
    Character.addCurrency(0, 250)
    VORP.addItem(_source, "stolenmerch", 5)
    TriggerClientEvent("vorp:TipBottom",source, 'You got 250$!, & some stolen merchandise', 5000)

end)


RegisterNetEvent("policenotify")
AddEventHandler("policenotify", function(players, coords)
    local Character = VorpCore.getUser(source).getUsedCharacter
    for each, player in ipairs(players) do
        if Character ~= nil then
			if Character.job == 'police' then
				TriggerClientEvent("Witness:ToggleNotification2", player, coords)
			end
        end
    end
end)


            
      

