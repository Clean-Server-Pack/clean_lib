Group  = {}
Group.__index = Group

---@class GroupProps
---@field id string
---@field name string
---@field owner string
---@field members GroupMemberProps[]
---@field task nil | TaskProps
---@field metadata table<string, any> | nil
---@field invites string[]

---@class TaskProps
---@field id string
---@field label string



-- RegisterNetEvent('clean_groups:updateGroup', function(data)
--   if not data then 
--     Group:leave()
--     return 
--   end
--   Group:update(data)
-- end)

AddStateBagChangeHandler('group', ('player:%s'):format(cache.serverId), function(_, _, value)
  lib.print.info('Group state bag change', value)
  -- SendNuiMessage(json.encode({
  --   action = 'UPDATE_GROUP',
  --   data   = value
  -- }))
end)