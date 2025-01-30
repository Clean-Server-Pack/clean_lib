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

local Groups = {}
Group  = {}
Group.__index = Group

---@function Group.generateId
---@description Generates a unique group identifier
---@return string
Group.generateId = function()
  local id = ('group_%s'):format(math.random(1000, 9999))
  if Groups[id] then 
    Wait(0)
    return Group.generateId()
  end
  return id
end

---@function lib.registerGroup
---@description Registers a group
---@param data GroupProps
---@return Group | false, string
lib.registerGroup = Group.register

Group.register = function(data --[[ GroupProps ]])
  local self = setmetatable(data, Group)
  self.id    = Group.generateId()
  local can_create, reason = self:__init()
  if not can_create then 
    return false, reason
  end
  Groups[self.id] = self
  return self 
end 

lib.callback.register('clean_groups:registerGroup', function(src, data)
  local ownerId = lib.player.identifier(src)
  if not ownerId then return false, 'invalid_owner' end
  data.owner = ownerId
  local newGroup, reason = Group.register(data)
  
  return newGroup and newGroup.id or false, reason
end)

---@function Group.getGroupById
---@description Gets a group by the owner's identifier
---@param owner string | number
---@return Group | false, string
Group.getGroupById = function(owner)
  local citizen_id = type(owner) == 'string' and owner or lib.player.identifier(owner)
  if not citizen_id then return false, 'invalid_owner_arg or player not online' end
  for k,v in pairs(Groups) do
    for _, member in pairs(v.members) do
      if member.id == citizen_id then
        return v
      end
    end
  end
  return false, 'group_not_found'
end

---@function lib.getGroupById
---@description Gets a group by the one of the member's identifier
---@param owner string | number
---@return Group | false, string
lib.getGroupById = Group.getGroupById

---@function Group.get
---@description Gets a group by its identifier
---@param id string
---@return Group | nil
Group.get = function(id)
  return Groups[id]
end

---@function lib.getGroup
---@description Gets a group by its identifier
---@param id string
---@return Group | nil
lib.getGroup = Group.get



---@function Group.getAll
---@description Gets all groups
---@return table<string, Group>
Group.getAll = function()
  return Groups
end

---@function lib.getAllGroups
---@description Gets all groups
---@return table<string, Group>
lib.getAllGroups = Group.getAll

---@function Group.destroy
---@description Destroys a group by its identifier
---@param id string
Group.destroy = function(id)
  local group = Group.get(id)
  if not group then return end
  for _, member in pairs(group.members) do
    TriggerClientEvent('clean_groups:updateGroup', member.src)
  end
  Groups[id] = nil
end

---@function lib.destroyGroup
---@description Destroys a group by its identifier
---@param id string
lib.destroyGroup = Group.destroy

lib.callback.register('clean_groups:disbandGroup', function(src)
  local player = lib.player.identifier(src)
  local group = Group.getGroupById(player)
  if not group then return false, 'group_not_found' end
  if group.owner ~= player then return false, 'not_owner' end
  if group.task then return false, 'group_has_task' end
  Group.destroy(group.id)
  return true
end)

lib.callback.register('clean_groups:getNearbyPlayers', function(src)
  local myGroup = Group.getGroupById(src)
  local groups = lib.settings.groups
  local players = GetPlayers()
  local nearby = {}
  local myPed = GetPlayerPed(src)
  local myPos = GetEntityCoords(myPed)
  for _, player in ipairs(players) do
    if tonumber(player) ~= tonumber(src) then
      local inGroup = Group.getGroupById(tonumber(player))
      local ped = GetPlayerPed(player)
      local pos = GetEntityCoords(ped)
      local distance = #(myPos - pos)
      if distance <= groups.maxDistanceInvite then
        table.insert(nearby, {
          id           = player,
          name         = lib.player.name(tonumber(player)),
          distance     = distance,
          inMyGroup    = inGroup?.id == myGroup.id,
          inOtherGroup = inGroup and inGroup.id ~= myGroup.id
        })
      end
      

    end
  end
  return nearby
end)
