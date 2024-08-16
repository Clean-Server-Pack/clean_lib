-- types || playerLoaded, playerLogout, playerDied
local settings = lib.settings

local job = {}
local isLoggedIn = false

if settings.framework == 'qb-core' then
  AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    lib.player.emit('playerLoaded')
  end)

  AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    lib.player.emit('playerLogout')
  end)

  AddEventHandler('QBCore:Client:JobUpdate', function(job)
    print('Job is ', job.name)
    job.name = job.name
  end)

elseif settings.framework == 'es_extended' then

end

local onEventCallbacks = {
  ["playerLoaded"] = function(func)
    func(isLoggedIn)
  end,
  ["playerLogout"] = function(func)
    func(isLoggedIn)
  end,
}

lib.player = {

  job    = job,

  loaded = function()
    return isLoggedIn
  end,

  emit = function(_type, data)
    assert(_type, 'type must be a string')
    TriggerEvent(('clean_lib:player:%s'):format(_type), data)
  end,

  on = function(_type, func)
    assert(_type, 'type must be a string')
    assert(type(func) == 'function', 'function must be a function')
    AddEventHandler(('clean_lib:player:%s'):format(_type), func)

    local callback = onEventCallbacks[_type]

    if callback then
      callback(func)
    else
      lib.print("debug", string.format('No callback for : %s', _type))
    end
  end,

}

return lib.player
