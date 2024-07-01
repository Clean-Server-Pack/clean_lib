-- types || playerLoaded, playerLogout, playerDied
local settings = lib.settings

local job = {}
local isLoaded = false

if settings.framework == 'qb-core' then
  AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoaded = true
    lib.player.emit('playerLoaded')
  end)

  AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoaded = false
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
    func(isLoaded)
  end,
  ["playerLogout"] = function(func)
    func(isLoaded)
  end,
}

lib.player = {

  job    = job,

  loaded = function()
    return isLoaded
  end,

  emit = function(_type, data)
    assert(_type, 'type must be a string')
    TriggerEvent(('dirk_lib:player:%s'):format(_type), data)
  end,

  on = function(_type, func)
    assert(_type, 'type must be a string')
    assert(type(func) == 'function', 'function must be a function')
    AddEventHandler(('dirk_lib:player:%s'):format(_type), func)

    local callback = onEventCallbacks[_type]

    if callback then
      callback(func)
    else
      lib.print("debug", string.format('No callback for : %s', _type))
    end
  end,
}

return lib.player
