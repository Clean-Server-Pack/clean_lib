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
      Player(member.src).state.group = self:getClientData()
    end 
  end
end