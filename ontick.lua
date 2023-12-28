local stress = 0
local morphine = 0
local stressWait = 0
local drugsWait = 0
local aiming = 0
local melee = 0
local still = 0
local stealth = 0
local chute = 0
local IsAlreadyDrunk 	= false
local IsAlreadyDrug 	= false
local IsAlreadyWeed 	= false
local DrunkLevel     	= -1
local DrugLevel     	= -1
local WeedLevel     	= -1
local isAfk				= false
AddEventHandler('ox:statusTick', function(data)
	local playerPed  = PlayerPedId()
	local prevHealth = GetEntityHealth(playerPed)
	local health	 = prevHealth
	local prevArmour = GetPedArmour(playerPed)
	local armour = prevArmour
		if data.hunger <= 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif data.thirst <= 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif data.stress then
			if stressWait > 0 then 
				stressWait = stressWait - 1
			elseif data.stress >= 80 then
				stressWait = 3
				ShakeGameplayCam('VIBRATE_SHAKE', 0.75)
				TriggerScreenblurFadeIn(0) 
				Citizen.Wait(2500)
				TriggerScreenblurFadeOut(0)
			elseif data.stress >= 65 then
				stressWait = 4
				ShakeGameplayCam('VIBRATE_SHAKE', 0.50)
				TriggerScreenblurFadeIn(0) 
				Citizen.Wait(2500)
				TriggerScreenblurFadeOut(0)
			elseif data.stress >= 50 then
				stressWait = 5
				ShakeGameplayCam('VIBRATE_SHAKE', 0.30)
				TriggerScreenblurFadeIn(0) 
				Citizen.Wait(2500)
				TriggerScreenblurFadeOut(0)
			elseif data.stress >= 35 then
				stressWait = 6
				ShakeGameplayCam('VIBRATE_SHAKE', 0.20)
			elseif data.stress >= 15 then
				stressWait = 7
				ShakeGameplayCam('VIBRATE_SHAKE', 0.10)
			end
		elseif data.drunk then
			if data.drunk > 0 then	
				local start = true
				if IsAlreadyDrunk then
					start = false
				end
				-- local level = 0
				-- if data.drunk >= 10 then
				-- 	level = 0
				-- elseif data.drunk >= 25 then
				-- 	level = 1
				-- else
				-- 	level = 2
				-- end
				-- if level ~= DrunkLevel then
					Drunk(2, start)
				-- end
				-- IsAlreadyDrunk = true
				-- DrunkLevel = level
			-- end
			else        
				if IsAlreadyDrunk then
					Reality()
				end
				IsAlreadyDrunk = false
				-- DrunkLevel = -1
			end

		-- elseif data.drugs then
		-- 	if data.drugs <= 5 then
		-- 		TriggerEvent('ox_status:set','drugs', 0)
		-- 		local playerPed = PlayerPedId()             
		-- 		ClearTimecycleModifier()
		-- 		ResetScenarioTypesEnabled()
		-- 		SetPedMotionBlur(playerPed, false)
		-- 		SetPedMoveRateOverride(PlayerId(),1.0)
		-- 		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		-- 		SetPedIsDrunk(PlayerPedId(), false)		
		-- 		SetPedMotionBlur(playerPed, false)
		-- 		ResetPedMovementClipset(PlayerPedId())
		-- 		AnimpostfxStopAll()
		-- 		ShakeGameplayCam("DRUNK_SHAKE", 0.0)
		-- 		SetTimecycleModifierStrength(0.0)	
		-- 	end
		--[[elseif v.name == 'weed' then
			if v.percent > 0 then
				local start = true
				if IsAlreadyWeed then
					start = false
				end
				local level = 0
				if v.percent <= 95 then
					level = 0
				else
					overdose()
				end
				if level ~= WeedLevel then
				end
				IsAlreadyWeed = true
				WeedLevel     = level
				TriggerEvent('isonweed', true)
			end
	
			if v.percent == 0 then
				if IsAlreadyWeed then
					Normal2()
				end
				IsAlreadyWeed = false
				WeedLevel     = -1
			end]]
		end
	-- end
	if health ~= prevHealth then 
		SetEntityHealth(playerPed, health) 
	end
end)

function Normal()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()             
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        SetPedMotionBlur(playerPed, false)
		SetPedMoveRateOverride(PlayerId(),1.0)
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		SetPedIsDrunk(PlayerPedId(), false)		
		SetPedMotionBlur(playerPed, false)
		ResetPedMovementClipset(PlayerPedId())
		AnimpostfxStopAll()
		ShakeGameplayCam("DRUNK_SHAKE", 0.0)
		SetTimecycleModifierStrength(0.0)	
    end)
end

function Normal2()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()             
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        SetPedMotionBlur(playerPed, false)

		SetPedMoveRateOverride(PlayerId(),1.0)
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		SetPedIsDrunk(PlayerPedId(), false)		
		SetPedMotionBlur(playerPed, false)
		ResetPedMovementClipset(PlayerPedId())
		AnimpostfxStopAll()
		ShakeGameplayCam("DRUNK_SHAKE", 0.0)
		SetTimecycleModifierStrength(0.0)	
		TriggerEvent('isonweed', false)
    end)
end
function overdose()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        SetEntityHealth(playerPed, 0)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(playerPed, 0)
        SetPedMotionBlur(playerPed, false)
    end)
end


