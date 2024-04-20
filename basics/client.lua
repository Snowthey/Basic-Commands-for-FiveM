RegisterCommand('invencible', function(source, args)
    local ped = PlayerPedId()
    if args[1] == 'on' or args[1] == 'ON' then
        SetEntityInvincible(ped, true)
        notify('~g~Invencible mode')
    elseif args[1] == 'off' or args[1] == 'Off' then
        SetEntityInvincible(ped, false)
        notify('~g~Beatable mode')
    end
end)

RegisterCommand('escape', function()
    ClearPlayerWantedLevel(player)
end)

RegisterCommand('guns', function(source, args)
    local ped = PlayerPedId()
    local AkHash = GetHashKey('weapon_assaultrifle')
    local pistolHash = GetHashKey('WEAPON_APPISTOL')
    if args[1] == 'leo' then
        print(args[1])
        GiveWeaponToPed(ped, pistolHash, 10000, false, true)
        GiveWeaponComponentToPed(ped, pistolHash, GetHashKey('COMPONENT_APPISTOL_CLIP_02'))
        GiveWeaponComponentToPed(ped, pistolHash, GetHashKey('COMPONENT_COMPONENT_AT_PI_FLSHAT_AR_FLSH'))
        GiveWeaponComponentToPed(ped, pistolHash, GetHashKey('COMPONENT_AT_PI_SUPP'))
        GiveWeaponComponentToPed(ped, pistolHash, GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE'))
        notify('~g~Gun in hands!')
    elseif args[1] == 'civ' then
        GiveWeaponToPed(ped, AkHash, 10000, false, true)
        GiveWeaponComponentToPed(ped, AkHash, GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02'))
        GiveWeaponComponentToPed(ped, AkHash, GetHashKey('COMPONENT_AT_AR_AFGRIP'))
        GiveWeaponComponentToPed(ped, AkHash, GetHashKey('COMPONENT_AT_AR_SUPP_02'))
        GiveWeaponComponentToPed(ped, AkHash, GetHashKey('COMPONENT_AT_SCOPE_MACRO'))
        GiveWeaponComponentToPed(ped, AkHash, GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE'))
        GiveWeaponComponentToPed(ped, AkHash, GetHashKey('COMPONENT_AT_AR_FLSH'))
        notify('~g~Gun in hands!')
    else
        notify('~g~Please select between leo and civ')
    end
end)

RegisterCommand('removeGuns', function(source, args)
    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped, p1)
end)

RegisterCommand('vehicle', function()
    local ped = PlayerPedId()
    local vehicleHash = GetHashKey('kuruma')

    RequestModel(vehicleHash)

    while not HasModelLoaded(vehicleHash) do
        Wait(0)
    end

    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    vehicle = CreateVehicle(vehicleHash, coords, heading, true, false)

    SetPedIntoVehicle(ped, vehicle, -1)

    SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
    SetVehicleNeonLightEnabled(vehicle, 0, true)
    SetVehicleNeonLightEnabled(vehicle, 1, true)
    SetVehicleNeonLightEnabled(vehicle, 2, true)
    SetVehicleNeonLightEnabled(vehicle, 3, true)
    SetVehicleNeonLightsColour(vehicle, 255, 1, 1)
    SetVehicleWindowTint(vehicle, 1)
    SetVehicleTyreSmokeColor(vehicle , 255, 1, 1)
    notify('~g~Car created successful')
    
end)

RegisterCommand('dv', function()
    local ped = PlayerPedId()

    if IsPedInAnyVehicle(ped) then
        local vehicle1 = GetVehiclePedIsIn(ped)
        SetEntityAsMissionEntity(vehicle1, true, true)
        DeleteVehicle(vehicle1)
        notify('~g~Car deleted successful')
    else
        notify('~r~You are not in a vehicle')
    end
    
end)

function notify(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(true, true)
end
