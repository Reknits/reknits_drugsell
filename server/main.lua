ESX = nil
local CopsConnected       	   = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local selling = false
	local success = false
	local copscalled = false
	local notintrested = false

  RegisterNetEvent('drugs:trigger')
  AddEventHandler('drugs:trigger', function()
	selling = true
		if selling == true then
			if CopsConnected < Config.RequiredCopsAll then
				TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst för att sälja droger", CopsConnected, Config.RequiredCopsAll)
				return
			end
			TriggerEvent('pass_or_fail')
  			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 1)
  			TriggerClientEvent("pNotify:SendNotification", source, {
            text = "Försöker kränga produkten..",
            type = "success",
            queue = "lmao",
            timeout = 2500,
            layout = "bottomCenter"
        	})
 	end
end)

RegisterServerEvent('fetchjob')
AddEventHandler('fetchjob', function()
    local xPlayer  = ESX.GetPlayerFromId(source)
    TriggerClientEvent('getjob', source, xPlayer.job.name)
end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end
 CountCops()

  RegisterNetEvent('drugs:sell')
  AddEventHandler('drugs:sell', function()
  	local xPlayer = ESX.GetPlayerFromId(source)
	local meth = xPlayer.getInventoryItem('meth_pooch').count
	local coke 	  = xPlayer.getInventoryItem('coke_pooch').count
	local weed = xPlayer.getInventoryItem('weed_pooch').count
	local opium = xPlayer.getInventoryItem('opium_pooch').count
	local paymentc = math.random (250,450)
	local paymentw = math.random (150,250)
	local paymentm = math.random (150,250)
	local paymento = math.random (250,450)
	if coke >= 1 and success == true then
		if CopsConnected < Config.RequiredCopsCoke then
			TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst", CopsConnected, Config.RequiredCopsCoke)
			return
		end
			 	TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Du sålde kokain för " .. paymentc .." Kr" ,
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "bottomCenter"
			})
			TriggerClientEvent("animationyes", source)
			xPlayer.removeInventoryItem('coke_pooch', 1)
  			xPlayer.addAccountMoney('black_money', paymentc)
  			selling = false
		  elseif weed >= 1 and success == true then
			if CopsConnected < Config.RequiredCopsWeed then
				TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst", CopsConnected, Config.RequiredCopsWeed)
				return
			end
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Du sålde cannabis för " .. paymentw .." Kr" ,
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "bottomCenter"
			})
			TriggerClientEvent("animationyes", source)
			TriggerClientEvent("test", source)
  			xPlayer.removeInventoryItem('weed_pooch', 1)
  			xPlayer.addAccountMoney('black_money', paymentw)
  			selling = false
			elseif meth >= 1 and success == true then
				if CopsConnected < Config.RequiredCopsMeth then
					TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst", CopsConnected, Config.RequiredCopsMeth)
					return
				end
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Du sålde meth för " .. paymentm .." Kr",
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "bottomCenter"
			})
			
			TriggerClientEvent("animationyes", source)
  			xPlayer.removeInventoryItem('meth_pooch', 1)
			  xPlayer.addAccountMoney('black_money', paymentm)
			  selling = false
			  elseif opium >= 1 and success == true then
				if CopsConnected < Config.RequiredCopsOpium then
					TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst", CopsConnected, Config.RequiredCopsOpium)
					return
				end
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Du sålde opium för " .. paymento .." Kr",
					type = "success",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "bottomCenter"
			})
			TriggerClientEvent("animationyes", source)
			xPlayer.removeInventoryItem('opium_pooch', 1)
  			xPlayer.addAccountMoney('black_money', paymento)
  			selling = false
			elseif selling == true and success == false and notintrested == true then
				if CopsConnected < Config.RequiredCopsAll then
					TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst", CopsConnected, Config.RequiredCopsAll)
					return
				end
				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Inte intresserad",
					type = "error",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "bottomCenter"
			})
			TriggerClientEvent("animationno", source)
  			selling = false
  			elseif meth < 1 and coke < 1 and weed < 1 and opium < 1 then
				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
				text = "Du har inga droger att sälja",
				type = "warning",
				progressBar = false,
				queue = "lmao",
				timeout = 2000,
				layout = "bottomCenter"
			})
			elseif copscalled == true and success == false then
				if CopsConnected < Config.RequiredCopsAll then
					TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst", CopsConnected, Config.RequiredCopsAll)
					return
				end
  				TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = "Usch! Jag är ingen knarkare! Jag ringer polisen!",
					type = "error",
					progressBar = false,
					queue = "lmao",
					timeout = 2000,
					layout = "bottomCenter"
			})
			TriggerClientEvent("animationcops", source)
			TriggerClientEvent("notifyc", source)
  			selling = false
  		end
end)

RegisterNetEvent('pass_or_fail')
AddEventHandler('pass_or_fail', function()

  		local percent = math.random(1, 9)

  		if percent == 3 then
  			success = false
  			notintrested = true
  		elseif percent ~= 8 then
  			success = true
  			notintrested = false
  		else
  			notintrested = false
  			success = false
  			copscalled = true
  		end
end)

RegisterNetEvent('sell_dis')
AddEventHandler('sell_dis', function()
	if CopsConnected < Config.RequiredCopsAll then
		TriggerClientEvent('esx:showNotification', source, "Inte tillräckligt med poliser i tjänst", CopsConnected, Config.RequiredCopsAll)
		return
	end
		TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Usch! I dessa kvarter vill vi inte ha några droger!",
		type = "error",
		progressBar = false,
		queue = "lmao",
		timeout = 2000,
		layout = "bottomCenter"
	})
end)

RegisterNetEvent('checkD')
AddEventHandler('checkD', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local meth = xPlayer.getInventoryItem('meth_pooch').count
	local coke = xPlayer.getInventoryItem('coke_pooch').count
	local weed = xPlayer.getInventoryItem('weed_pooch').count
	local opium = xPlayer.getInventoryItem('opium_pooch').count

	if meth >= 1 or coke >= 1 or weed >= 1 or opium >= 1 then
		TriggerClientEvent("checkR", source, true)
	else
		TriggerClientEvent("checkR", source, false)
	end

end)

