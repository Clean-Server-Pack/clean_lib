local GroupTasks = {}
local GroupTask = {}
GroupTask.__index = GroupTask

function GroupTask:__init()
  assert(self.id, 'GroupTask id is required')
  assert(self.action, 'GroupTask action is required')
  return true
end

---@class TaskProps
---@field id string
---@field action fun(args: table<string, any>): void
---@field dirkup? fun(args: table<string, any>): void


---@function GroupTask.register || lib.registerGroupTask
---@description Registers a group task
---@param id string
---@param data TaskProps
---@return GroupTask | false, string
GroupTask.register = function(id, data)
  local self = setmetatable(data, GroupTask)
  self.id = id
  local init, reason = self:__init()
  if not init then return false, reason end
  GroupTasks[id] = self
  return self
end

lib.registerGroupTask = GroupTask.register

function GroupTask:execute(args)
  if not LocalPlayer.state.group then return end
  local task = LocalPlayer.state.group.task
  if not task then return end
  if task.id ~= self.id then return end
  self.action(args)
end

RegisterNetEvent('dirk_groups:startTask', function(id, args)
  local task = GroupTasks[id]
  if not task then return end
  task:execute(args)
end)

function GroupTask:kill(args)
  local group = LocalPlayer.state.group
  if not group then return false, 'not_in_group' end
  if not group.task then return false, 'no_task_to_dirkup' end
  if group.task.id ~= self.id then return false, 'invalid_task' end
  if not self.dirkup then return false, 'no_dirkup' end
  self.dirkup(args)
end

RegisterNetEvent('dirk_groups:endTask', function(id, args)
  local task = GroupTasks[id]
  if not task then return end
  local killed, reason = task:kill(args)
end)

