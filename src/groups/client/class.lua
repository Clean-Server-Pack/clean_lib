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

function Group:update(data)
  for k,v in pairs(data) do
    self[k] = v
  end
  LocalPlayer.state.group = data
  return self
end 

function Group:leave()
  self = {}
  LocalPlayer.state.group = nil
end



RegisterNetEvent('clean_groups:updateGroup', function(data)
  if not data then 
    Group:leave()
    return 
  end
  Group:update(data)
end)

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
    Group:leave()
  end
end)