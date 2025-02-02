function Group:getClientData()
  return {
    id       = self.id,
    task     = self.task,
    owner    = self.owner,
    name     = self.name,
    members  = self.members,
  }
end

function Group:updateClients()
  for _, member in pairs(self.members) do
    if member.src then 
      -- TriggerClientEvent('clean_groups:updateGroup', member.src, self:getClientData())
      Player(member.src).state.group = self:getClientData()
    end 
  end
end