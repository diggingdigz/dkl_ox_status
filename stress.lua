Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local weapon = GetSelectedPedWeapon(ped)
		local stress = 0.10
		if IsPedShooting(ped) then
		  TriggerEvent('ox_status:add', 'stress', stress)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedOnAnyBike(ped) then
		  TriggerEvent('ox_status:minus','stress',1)
		  Citizen.Wait(3000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped)
		local speed = GetEntitySpeed(GetVehiclePedIsIn(ped,true)) * 2.6
		if IsPedInAnyVehicle(ped,false)	and speed >= 120 then
			TriggerEvent('ox_status:add','stress', 1)
			Citizen.Wait(3000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedInMeleeCombat(ped) then
			TriggerEvent('ox_status:add','stress',1)
			Citizen.Wait(3000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedSwimming(ped) then
		  TriggerEvent('ox_status:minus','stress',1)
		  Citizen.Wait(3000)
		end
	end
end)