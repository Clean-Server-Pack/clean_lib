---@function Group.startTask || lib.setGroupTask
---@description Sets a task for a group
---@param groupId string
---@param taskId string
---@param taskLabel string
---@param args table<string, any>
---@return boolean, string
Group.startTask = function(groupId, taskId, taskLabel, args)
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
    if member.src then 
      TriggerClientEvent('dirk_groups:startTask', member.src, taskId, args)
    end
  end
  return true
end

lib.startGroupTask = Group.startTask

---@function Group.endTask || lib.endGroupTask
---@description Ends a task for a group
---@param groupId string
---@param args table<string, any>
---@return boolean, string
Group.endTask = function(groupId, args)
  local group = Group.get(groupId)
  if not group then return false, 'group_not_found' end
  if not group.task then return false, 'no_task_to_end' end
  for _, member in pairs(group.members) do
    if member.src then 
      TriggerClientEvent('dirk_groups:endTask', member.src, group.task.id, args)
    end
  end

  group.task = nil
  group:updateClients()
  return true
end

lib.endGroupTask = Group.endTask

-- SECURE EVENTS>?<
RegisterNetEvent('dirk_groups:startTask', function(groupId, task, args)
  local src = source
  local player = lib.player.identifier(src)
  local group = Group.getGroupById(player)
  if not group then return false, 'group_not_found' end
  if group.owner ~= player then return false, 'not_owner' end
  return Group.startTask(groupId, task, args)
end)

RegisterNetEvent('dirk_groups:endTask', function(task, args)
  local src = source
  local player = lib.player.identifier(src)
  local group = Group.getGroupById(player)
  if not group then return false, 'group_not_found' end
  if group.owner ~= player then return false, 'not_owner' end
  return Group.endTask(groupId, args)
end)


