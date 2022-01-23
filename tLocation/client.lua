ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


ConfHs0              = {}
ConfHs0.DrawDistance = 100
ConfHs0.Size         = {x = 5.0, y = 5.0, z = 1.0}
ConfHs0.Color        = {r = 255, g = 255, b = 255}
ConfHs0.Type         = -1

local position = {
        {x = -1034.74,   y = -2732.55,  z = 20.17 },
}  


RMenu.Add('location', 'main', RageUI.CreateMenu("Location", "Séléctionne un véhicule"))
Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('location', 'main'), true, true, true, function()
            RageUI.Button("Scooter", nil, {RightLabel = "~g~300$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
                TriggerServerEvent('TomN:Location', 300)
                spawnCar("faggio")
                RageUI.CloseAll()
            end
            end)
            RageUI.Button("Blista", nil, {RightLabel = "~g~650$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
                TriggerServerEvent('TomN:Location', 650)
                spawnCar("blista")
                RageUI.CloseAll()
            end
            end)
            RageUI.Button("Bmx", nil, {RightLabel = "~g~75$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
                TriggerServerEvent('TomN:Location', 75)
                spawnCar("bmx")
                RageUI.CloseAll()
            end
            end)
        end, function()
        end)
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la location de véhicule.")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('location', 'main'), not RageUI.Visible(RMenu:Get('location', 'main')))
                    end   
                end
            end
        end
    end)
local blips = {
    {title="Location", colour=0, id=38, x = -1034.74, y = -2732.55, z = 20.17, scale=0.8}

}
Citizen.CreateThread(function()
for _, info in pairs(blips) do
  info.blip = AddBlipForCoord(info.x, info.y, info.z)
  SetBlipSprite(info.blip, info.id)
  SetBlipDisplay(info.blip, 4)
  SetBlipScale(info.blip, info.scale)
  SetBlipColour(info.blip, info.colour)
  SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(info.title)
  EndTextCommandSetBlipName(info.blip)
end
end)
function spawnCar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, -1029.55, -2730.97, 20.15, 242.66, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "TomN"
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end
DecorRegister("Yay", 4)
pedHash = "s_m_m_security_01"
zone = vector3(-1034.49, -2732.1, 19.17)
Heading = 145.64
Ped = nil
HeadingSpawn = 145.64
Citizen.CreateThread(function()
    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
    DecorSetInt(Ped, "Yay", 5431)
    FreezeEntityPosition(Ped, 1)
    TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
    end)
function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end