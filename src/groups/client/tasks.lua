local GroupTasks = {}
local GroupTask = {}
GroupTask.__index = GroupTask

---@class TaskProps
---@field id string
---@field label string
---@field action fun(args: table<string, any>): void

function GroupTask:__init()
  if not self.id then return false, 'No ID provided' end
  if not self.label then return false, 'No label provided' end
  if not self.action then return false, 'No action provided' end
  return true
end

---@function GroupTask:execute
---@description Executes a task without any checks or telling the server
---@param args table<string, any>
---@return void
function GroupTask:execute(args)
  if not LocalPlayer.state.group then return end
  local task = LocalPlayer.state.group.task?.id 
  if not task then return end
  if task ~= self.id then return end
  self.action()
end

---@function GroupTask:start iternal way of setting a task
---@description Starts a task for a group
---@param args table<string, any>
---@return boolean, string

function GroupTask:start(args)
  local group = LocalPlayer.state.group
  if not group then return false, 'not_in_group' end
  if cache.citizenId ~= group.owner then return false, 'not_group_owner' end
  if group.task then return false, 'task_already_started' end
  TriggerServerEvent('clean_groups:setTask', group.id, self.id, self.label, args)
end

RegisterNetEvent('clean_groups:executeTask', function(id, args)
  local task = GroupTasks[id]
  if not task then return end
  task:execute(args)
end)


---@function GroupTask.register
---@description Registers a group task
---@param id string
---@param data TaskProps
---@return GroupTask | false, string
GroupTask.register = function(id, data)
  local self = setmetatable(data, GroupTask)
  local init, reason = self:__init()
  if not init then return false, reason end
  GroupTasks[id] = self
  return self
end



---@function lib.registerGroupTask
---@description Registers a group task
---@param id string
---@param data TaskProps
---@return GroupTask | false, string
lib.registerGroupTask = GroupTask.register


---@function lib.setGroupTask
---@description Sets a task for a group to all clients in the group 
---@param groupId string
---@param taskId string
---@param args table<string, any>
---@return boolean, string
lib.setGroupTask = function(groupId, taskId, args)
  local task = GroupTasks[taskId]
  if not task then return false, 'invalid_task' end
  task:start(args)
end





-- Examples 
-- GroupTask.register('task_1', {
--   id = 'task_1',
--   label = 'Task 1',
--   action = function(args)
--     print('Task 1 executed')
--     print(json.encode(args, { indent = true }))
--   end
-- })

-- RegisterCommand('groupTask', function()
--   local task = GroupTasks['task_1']
--   if not task then return false, 'invalid_task' end
--   task:start(args)
-- end)