-- types || playerLoaded, playerLogout, playerDied
local settings = lib.settings

local job = {}


if settings.framework == 'qb-core' then 
  AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    lib.player.emit('playerLoaded')
  end)

  AddEventHandler('QBCore:Client:JobUpdate', function(job)
    print('Job is ', job.name)
    job.name = job.name
  end)

elseif settings.framework == 'es_extended' then 

end




lib.player = {

  job    = job, 

  loaded = function()
    return true  
  end,

  emit = function(_type, data)
    assert(_type, 'type must be a string')
    TriggerEvent(('dirk_lib:player:%s'):format(_type), data)
  end,

  on = function(_type, func)
    assert(_type, 'type must be a string')
    assert(type(func) == 'function', 'function must be a function') 
    AddEventHandler(('dirk_lib:player:%s'):format(_type), func)

    if _type == 'playerLoaded' then 
      if lib.player.loaded() then 
        func()
      end
    end
  end,
}

return lib.player
