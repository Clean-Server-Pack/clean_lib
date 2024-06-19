local awaitingCallbacks = {}
local timers = {}
local callback_event = '__dirk_cb_%s'
local callback_timeout = 300000 


RegisterNetEvent(callback_event:format(cache.resource), function(key, ...)
  local cb = awaitingCallbacks[key]
  awaitingCallbacks[key] = nil
  return cb and cb(...)
end)


local eventTimer = function(event,delay)
  if delay and type(delay) == 'number' and delay > 0 then 
    local time = GetGameTimer()


    if (timer[event] or 0) > time then 
      return false 
    end 

    timers[event] = time + delay 

    return true
  end
  return true
end


local triggerServerCallback = function(_,event, delay, cb, ...)
  if not eventTimer(event, delay) then return end 

  local key 


  repeat 
    key = ('%s_%s'):format(event, math.random(0, 9999999))
  until not awaitingCallbacks[key]
  TriggerServerEvent(callback_event:format(event), cache.resource, key, ...)

  local promise = not cb and promise.new()

  awaitingCallbacks[key] = function(response, ...)
    response = {response, ...}

    if promise then 
      return promise:resolve(response)
    end 

    if cb then 
      cb(table.unpack(response))
    end
  end

  if promise then 
    SetTimeout(callback_timeout, function() promise:reject(('Callback %s timed out'):format(event)) end)

    return table.unpack(Citizen.Await(promise))
  end
end 


lib.callback = setmetatable({}, {
  __call = function(_, event, delay, cb, ...)
    if not cb then 
      warn(('Callback %s does not have a callback'):format(event))
    else 
      local cbType = type(cb)
      assert(cbType == 'function', ('Callback %s must have a function for argument 3'):format(event))
    end

    return triggerServerCallback(_, event, delay, cb, ...)
  end
})


lib.callback.await = function(event, ...)
  return triggerServerCallback(_, event, false, ...)
end


local callbackResponse = function(success,result, ...)
  if not success then
    if result then
      return print(('^1SCRIPT ERROR: %s^0\n%s'):format(result,
      Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString()) or ''))
    end

    return false
  end

  return result, ...
end

local pcall = pcall


lib.callback.register = function(event, cb)
  if not cb then 
    warn(('Callback %s does not have a callback'):format(event))
  else 
    local cbType = type(cb)
    assert(cbType == 'function', ('Callback %s must have a function for argument 2'):format(event))
  end

  RegisterNetEvent(callback_event:format(event), function(resource, key, ...)
    TriggerServerEvent(callback_event:format(resource), key, callbackResponse(pcall(cb, ...)))
  end)
end


return lib.callback