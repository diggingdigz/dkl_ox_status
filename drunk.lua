local ox_inventory = exports.ox_inventory
local onDrunk = 0
RegisterNetEvent('drunkfx:onBeer')
AddEventHandler('drunkfx:onBeer', function(drunk,thirst)
    onDrunk = onDrunk + drunk
    TriggerEvent('ox_status:add', 'drunk', drunk)
    TriggerEvent('ox_status:add', 'thirst', thirst)
    if onDrunk >= 50 then
        Drunk(2,true)
    elseif onDrunk >= 30 then
        Drunk(1,true)
    elseif onDrunk >= 10 then
        Drunk(0,true)
    end
    Citizen.Wait(onDrunk*1000)
    TriggerEvent('ox_status:set','drunk', 0)
	onDrunk = 0
    Reality()
end)

function Drunk(level, start) 
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        if start then
        DoScreenFadeOut(800)
        Wait(1000)
        end
        if level == 0 then
            RequestAnimSet("move_m@drunk@slightlydrunk")
        
        while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
            Citizen.Wait(0)
        end
            SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        elseif level == 1 then
            RequestAnimSet("move_m@drunk@moderatedrunk")
        
        while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
            Citizen.Wait(0)
        end
            SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
        elseif level == 2 then
            RequestAnimSet("move_m@drunk@verydrunk")
        
        while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
            Citizen.Wait(0)
        end
            SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
        end
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(playerPed, true)
        SetPedIsDrunk(playerPed, true)
        if start then
        DoScreenFadeIn(800)
        end
    end)
end

function Reality()
    Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
    DoScreenFadeOut(800)
    Wait(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
	SetPedMoveRateOverride(PlayerId(),1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    DoScreenFadeIn(800)
    end)
end