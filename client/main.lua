local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX             = nil
local myJob     = nil
local selling   = false
local has       = false
local copsc     = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(10)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
  TriggerServerEvent('fetchjob')
end)

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('getjob')
AddEventHandler('getjob', function(jobName)
  myJob = jobName
end)


currentped = nil
Citizen.CreateThread(function()

  while true do
    Citizen.Wait(10)
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local handle, ped = FindFirstPed()
    repeat
      success, ped = FindNextPed(handle)
      local pos = GetEntityCoords(ped)
      local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
      if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
        if DoesEntityExist(ped)then
          if IsPedDeadOrDying(ped) == false then
            if IsPedInAnyVehicle(ped) == false then
              local pedType = GetPedType(ped)
              if pedType ~= 28 and IsPedAPlayer(ped) == false then
                currentped = pos
                if distance <= 2 and ped  ~= GetPlayerPed(-1) and ped ~= oldped then
                  TriggerServerEvent('checkD')
                  if has == true then
                  if IsControlJustPressed(1, 86) then
                        oldped = ped
                        SetEntityAsMissionEntity(ped)
                        TaskStandStill(ped, 9.0)
                        TaskTurnPedToFaceEntity(ped, GetPlayerPed(-1), 5000)
                        pos1 = GetEntityCoords(ped)
                        TriggerServerEvent('drugs:trigger')
                        Citizen.Wait(2850)
                        TriggerEvent('sell')
                        SetPedAsNoLongerNeeded(oldped)
                       
                    end
                  end
                end
              end
            end
          end
        end
      end
    until not success
    EndFindPed(handle)
  end
  end)

RegisterNetEvent('sell')
AddEventHandler('sell', function()
 
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 313.04,-2008.91,20.79, true)

    if distance <= 400 then
      
      TriggerServerEvent('drugs:sell')
      
    elseif distance > 400 then
      TriggerServerEvent('sell_dis')
    end
end)

RegisterNetEvent('checkR')
AddEventHandler('checkR', function(test)
  has = test
end)

RegisterNetEvent('notifyc')
AddEventHandler('notifyc', function()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
   	crossing = GetStreetNameFromHashKey(crossing)
    if crossing ~= nil then
      local coords      = GetEntityCoords(GetPlayerPed(-1))
      TriggerEvent('skinchanger:getSkin', function(skin)
      TriggerServerEvent('esx-qalle-camerasystem:addWitness', skin, "DrogOffer")
      TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'Det är någon som försökt sälja knark till mig kom fort!', {
        x = coords.x,
        y = coords.y,
        z = coords.z
    })
  end)
end
end)

RegisterNetEvent('animationyes')
AddEventHandler('animationyes', function()
RequestAnimDict("mp_common")
TaskPlayAnim(oldped, 'mp_common','givetake1_a' ,3.0, -1, -1, 50, 0, false, false, false)
TaskPlayAnim(PlayerPedId(), 'mp_common','givetake1_a' ,3.0, -1, -1, 50, 0, false, false, false)
if GetPedType(oldped) == 4 then
PlayAmbientSpeechWithVoice(oldped, 'GENERIC_THANKS', 'S_M_Y_HWAYCOP_01_BLACK_FULL_02', 'SPEECH_PARAMS_FORCE_SHOUTED', 0)
Citizen.Wait(1500)
ClearPedTasksImmediately(PlayerPedId())
else
PlayAmbientSpeechWithVoice(oldped, 'GENERIC_THANKS', 'A_F_M_BEACH_01_WHITE_FULL_01', 'SPEECH_PARAMS_FORCE_SHOUTED', 0)  
Citizen.Wait(1500)
ClearPedTasksImmediately(PlayerPedId())
end
end)

RegisterNetEvent('animationcops')
AddEventHandler('animationcops', function()
local prop_name = prop_name or 'prop_amb_phone'
local bone = GetPedBoneIndex(oldped, 28422)
prop = CreateObject(prop_name, 1.0, 1.0, 1.0, 1, 1, 0)
AttachEntityToEntity(prop, oldped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)       	        
RequestAnimDict("cellphone@")
TaskPlayAnim(oldped, 'cellphone@','cellphone_call_listen_base' ,3.0, -1, -1, 50, 0, false, false, false)
Citizen.Wait(1000)
if GetPedType(oldped) == 4 then
PlayAmbientSpeechWithVoice(oldped, 'PHONE_CALL_COPS', 'S_M_M_GENERICPOSTWORKER_01_WHITE_MINI_01', 'SPEECH_PARAMS_FORCE_SHOUTED',0)
else
PlayAmbientSpeechWithVoice(oldped, 'PHONE_CALL_COPS', 'A_F_M_BEVHILLS_02_WHITE_FULL_02', 'SPEECH_PARAMS_FORCE_SHOUTED', 0)

end
end)

RegisterNetEvent('animationno')
AddEventHandler('animationno', function()
RequestAnimDict("mini@hookers_sp")
TaskPlayAnim(oldped, 'mini@hookers_sp','idle_reject' ,3.0, -1, -1, 50, 0, false, false, false)
if GetPedType(oldped) == 4 then
PlayAmbientSpeechWithVoice(oldped, 'GENERIC_NO', 'A_M_M_BEVHILLS_02_BLACK_FULL_01', 'SPEECH_PARAMS_FORCE_SHOUTED',0)
else
PlayAmbientSpeechWithVoice(oldped, 'GENERIC_NO', 'A_F_M_BEACH_01_WHITE_FULL_01', 'SPEECH_PARAMS_FORCE_SHOUTED', 0)
Citizen.wait(1500)
ClearPedTasksImmediately(oldped)
end

end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
