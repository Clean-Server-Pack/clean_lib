local groups = lib.settings.groups
local rawLocales = json.decode(LoadResourceFile(cache.resource, ('locales/%s.json'):format(lib.settings.language)))

local locale = function(str, ...)
  local lstr = rawLocales[str]

  if lstr then
    if ... then
      return lstr and lstr:format(...)
    end

    return lstr
  end

  return str
end


lib.callback.register('clean_groups:invitePlayers', function(src, players)
  local group = Group.getGroupById(src)
  if group.task then return end
  if not group then return end
  local citizenId = lib.player.identifier(src)
  if group.owner ~= citizenId then return end
  
  for _,player in pairs(players) do
    player = tonumber(player)
    if player then
      group:invitePlayer(player)
    end
  end
end)

function Group:invitePlayer(trg)
  local citizenId = type(trg) == 'string' and trg or lib.player.identifier(trg)
  local isOnline  = lib.player.checkOnline(citizenId)
  if not isOnline then return false, 'not_online' end
  local group = Group.getGroupById(citizenId)
  if group then return false, 'in_group' end

  -- if lib.table.includes(self.invites, citizenId) then return false, 'already_invited' end
  local index = #self.invites + 1
  self.invites[index] = citizenId

  lib.notify(trg, {
    title = locale( 'GroupInvite'),
    icon  = 'fas fa-users',
    description = locale( 'GroupInviteDesc'):format(self.name),
  })

  TriggerClientEvent('clean_pause:newMessage', trg, {
    date = os.time(),
    title = locale( 'GroupInvite'),
    message = locale( 'GroupInviteDesc'):format(self.name),
    icon = 'fas fa-users',
    groupInvite = {
      id = self.id,
      name = self.name,
    }
  })

  SetTimeout(groups.inviteValidTime * 60000, function()
    if self.invites[index] == citizenId then
      self.invites[index] = nil
    end
  end)

  return true
end

function Group:respondInvite(src, accepted)
  local citizenId = lib.player.identifier(src)
  if not lib.table.includes(self.invites, citizenId) then return false, 'no_invite' end
  
  for k,v in pairs(self.invites) do
    if v == citizenId then
      table.remove(self.invites, k)
    end
  end
  
  if not accepted then return true end

  self:addMember({
    id = citizenId,
    role = 'member',
    name = lib.player.name(src),
    src = src,
  })
  return true
end


lib.callback.register('clean_groups:inviteRespond', function(src, accepted, groupId)
  local alreadyGroup = Group.getGroupById(src)
  if alreadyGroup then return false, 'already_in_group' end
  local group = Group.get(groupId)
  if not group then return end
  if group.task then return false, 'group_has_task' end
  return group:respondInvite(src, accepted)
end)