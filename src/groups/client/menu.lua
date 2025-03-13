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


local registerGroupsMenu = function()
  -- local self = LocalPlayer.state.group
  -- if not self then return end
  -- local getOptions  = function()
  --   local options = {}
  --   if not self.name then 
  --     table.insert(options, {
  --       title = 'Create Group', 
  --       icon = 'users',
  --       description = 'Create a group',
  
  --       onSelect = function()
  --         -- Choose group name
  --         -- Input menu
  --         -- callback to see if you can create a group. 
  --         local input = lib.inputDialog('Group Info', {
  --           {type = 'input', label = 'Name', description = 'The name of your group!', required = true, min = 4, max = 16},
  --         }, {
  --           fromContext = 'groupMenu',
  --         })
  --         if not input then return end


  --         local groupId, reason = lib.callback.await('dirk_groups:registerGroup', input)
  --         lib.notify({
  --           title = groupId and locale('GroupCreated') or locale('GroupNotCreated'),
  --           icon = groupId and 'users' or 'user-slash',
  --           description = groupId and locale('GroupCreatedDesc') or locale('GroupNotCreatedDesc'),
  --         })
           
  --       end
  --     })
  --   else 
  --     -- Show members and show option to leave. 
  --     -- if role == 'owner' show option to disband and kick members.
  --     table.insert(options, {
  --       title = 'Group Info', 
  --       icon = 'users',
  --       description = 'View your group information',
  
  --       onSelect = function()
  --         lib.notify({
  --           title = 'Group Info',
  --           icon = 'users',
  --           description = 'Group Name: ' .. self.name,
  --         })
  --       end
  --     })
      
  --     if self.owner == cache.citizenId then 
  --       table.insert(options, {
  --         title = 'Disband Group', 
  --         icon = 'user-slash',
  --         description = 'Disband your group',
    
  --         onSelect = function()
  --           local disbanded, reason = lib.callback.await('dirk_groups:disbandGroup')
  --           lib.notify({
  --             title = disbanded and locale('GroupDisbanded') or locale('GroupNotDisbanded'),
  --             icon = disbanded and 'users' or 'user-slash',
  --             description = disbanded and locale('GroupDisbandedDesc') or locale('GroupNotDisbandedDesc'),
  --           })
  --         end
  --       })
  --     else 
  --       table.insert(options, {
  --         title = 'Leave Group', 
  --         icon = 'user-slash',
  --         description = 'Leave your group',
    
  --         onSelect = function()
  --           lib.notify({
  --             title = 'Leaving Group',
  --             icon = 'users',
  --             description = 'You have left the group',
  --           })
  --           TriggerServerEvent('dirk_groups:leaveGroup')
  --         end
  --       })
  --     end

  --   end 
  --   return options
  -- end 
  -- lib.registerContext('groupMenu', {
  --   title = 'Group Menu',
  --   icon = 'users',
  --   options = getOptions,
  -- })
end

RegisterCommand('groups:menu', function()
  lib.openContext('groupMenu')
end)

TriggerEvent('chat:addSuggestion', '/groups:menu', locale('GroupMenuChatSuggestion'), {})

AddEventHandler('dirk_lib:cache:playerLoaded', function(loaded)
  if not loaded then return end
  registerGroupsMenu()
  lib.callback.await('dirk_groups:playerLoaded')
end)