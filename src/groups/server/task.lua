---@function Group.setTask 
---@description Sets a task for a group
---@param groupId string
---@param taskId string
---@param taskLabel string
---@param args table<string, any>
---@return boolean, string
Group.setTask = function(groupId, taskId, taskLabel, args)
  local group = Group.get(groupId)
  if not group then return false, 'group_not_found' end
  if group.task then return false, 'group_has_task' end
  group.task = {
    id = taskId,
    label = taskLabel,
    args = args
  }
  group:updateClients()
  for _, member in pairs(group.members) do
    TriggerClientEvent('clean_groups:executeTask', member.src, taskId, args)
  end
  return true
end

lib.setGroupTask = Group.setTask

RegisterNetEvent('clean_groups:setTask', function(groupId, task, args)
  local src = source
  local player = lib.player.identifier(src)
  local group = Group.getGroupById(player)
  if not group then return false, 'group_not_found' end
  if group.owner ~= player then return false, 'not_owner' end
  return Group.setTask(groupId, task, args)
end)


