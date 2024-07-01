local cache = _ENV.cache
cache.playerId = PlayerId()
cache.serverId = GetPlayerServerId(cache.playerId)

function cache:set(key,value)
  if value ~= self[key] then
    print('Setting ', key, value, self[key])
    TriggerEvent(('dirk_lib:cache:%s'):format(key), value, self[key])
    self[key] = value
    return true
  end
  return false
end

local GetVehiclePedIsIn = GetVehiclePedIsIn
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehicleMaxNumberOfPassengers = GetVehicleMaxNumberOfPassengers
local GetCurrentPedWeapon = GetCurrentPedWeapon


CreateThread(function()
  while true do
    local wait_time = 100
    local ped = PlayerPedId()
    cache:set('ped', ped)

    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle > 0 then
      cache:set('vehicle', vehicle)
      if not cache.seat or GetPedInVehicleSeat(vehicle, cache.seat) ~= ped then
        local max_seats = GetVehicleMaxNumberOfPassengers(vehicle)
        for i = -1, max_seats do
          if GetPedInVehicleSeat(vehicle, i) == ped then
            cache:set('seat', i)
            cache:set('driver', i == -1)
            break
          end
        end
      end
    else
      cache:set('vehicle', false)
      cache:set('seat', false)
    end

    local _, weapon = GetCurrentPedWeapon(ped)
    cache:set('weapon', weapon)

    Wait(wait_time)
  end
end)

lib.cache = function(key)
  return cache[key]
end
