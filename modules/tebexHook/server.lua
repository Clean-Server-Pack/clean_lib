local TebexHooks = {}
local TebexHook  = {}
TebexHook.__index = TebexHook

function TebexHook:__init()
  assert(self.id, 'TebexHook requires an id')
  assert(not self.onPurchase and not self.onRemove and not self.onRenew, 'TebexHook needs to implement onPurchase or onRemove, onRenew')
  assert(self.label, 'TebexHook requires a label')

  local commands = {
    onPurchase = 'dirk_purchase_%s',
    onRemove   = 'dirk_remove_%s',
    onRenew    = 'dirk_renew_%s'
  }

  for _type, command in pairs(commands) do
    if self[_type] then
      RegisterCommand(string.format(command, self.id), function(src, args, raw)
        local src = src
        if src ~= 0 then return end
        local cfxId = args[1]
        if not cfxId or cfxId == 0 then return end
        self[_type](cfxId, args)
      end, true)
    end
  end

  return true
end

TebexHook.register = function(data)
  local self = setmetatable(data, TebexHook)
  local init, reason = self:__init()
  if not init then
    print('Failed to initialize TebexHook: '..reason)
    return
  end
  TebexHooks[self.id] = self
  return self 
end

lib.registerTebexHook = TebexHook.register

-- USEAGE
-- lib.registerTebexHook({
--   id = 'vip',
--   label = 'VIP',

--   onPurchase = function(args)

--   end,

--   onRemove = function(args)

--   end,

--   onRenew = function(args)

--   end
-- })