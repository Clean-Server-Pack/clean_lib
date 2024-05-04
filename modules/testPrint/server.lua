-- local cb_event = ('__dirk_cb:%s')

-- RegisterNetEvent(cb_event:format(cache.resource), function(key, ...)
--   local exists = callbacks[key]
--   if not exists then 
--     error(('Callback %s does not exist'):format(key))
--   end
--   return cb and cb(...) 
-- end)