function Group:__init()
  if not self.owner then return false, 'owner_not_set' end
  local ownerId = lib.player.checkOnline(self.owner)
  if not ownerId then return false, 'owner_not_online' end
  local playerGroup = Group.getGroupById(self.owner)
  if playerGroup then return false, 'player_already_in_group' end

  if not self.name then return false, 'name_not_set' end
  self.members = {}
  self.invites = {}
  local firstName, lastName = lib.player.name(tonumber(ownerId))
  self:addMember({
    id       = self.owner,
    role     = 'owner',
    metadata = {}, 
    name     = ('%s %s'):format(firstName, lastName),
    src      = ownerId,
  })

  return true
end
