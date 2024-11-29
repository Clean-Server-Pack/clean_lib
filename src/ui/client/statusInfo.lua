--[[
type Status = {
  id: string; 
  title: string;
  icon?: string;
  description: string;
  time?: number;
  progress?: number; 
  progText?: string;
}
]]

local StatusInfos = {}
local StatusInfo = {}
StatusInfo.__index = StatusInfo

function StatusInfo:serialize()
  return {
    id          = self.id,
    title       = self.title,
    icon        = self.icon,
    description = self.description,
    time        = self.time,
    progress    = self.progress,
    progText    = self.progText
  }
end

function StatusInfo:__init()
  -- Display it. 
  SendNuiMessage(json.encode({
    action = 'ADD_STATUS',
    data   = self:serialize()
  }))
end

function StatusInfo:__destroy()
  print('Destroying status', self.id)
  -- Remove it. 
  SendNuiMessage(json.encode({
    action = 'REMOVE_STATUS',
    data     = self.id
  }))
end

function StatusInfo:update(data)
  for k, v in pairs(data) do
    self[k] = v
  end
  SendNuiMessage(json.encode({
    action = 'UPDATE_STATUS',
    data   = self:serialize()
  }))
end

RegisterNuiCallback('STATUS_TIMER_OVER', function(data, cb)
  local status = StatusInfo.get(data.id)
  if status then
    if status.onTimeUp then
      status.onTimeUp()
    end
    if status.destroyOnTimeUp == nil or status.destroyOnTimeUp then
      SetTimeout(2500, function()
        StatusInfo.destroy(data.id)
      end)
    end
  end
  cb({})
end)

StatusInfo.register = function(id, data)
  assert(id, "StatusInfo.register: id is nil")
  assert(data and type(data) == "table", "StatusInfo.register: data is nil or not a table")
  local self = setmetatable(data, StatusInfo)
  self.id = id
  self:__init()
  StatusInfos[id] = self
end 

StatusInfo.get = function(id)
  return StatusInfos[id]
end

StatusInfo.getAll = function()
  return StatusInfos
end

StatusInfo.destroy = function(id)
  local status = StatusInfo.get(id)
  if status then
    status:__destroy()
    StatusInfos[id] = nil
  end
end

StatusInfo.update = function(id, data)
  local status = StatusInfo.get(id)
  if status then
    status:update(data)
  end
end

RegisterCommand('test_status', function()
  StatusInfo.register('test', {
    title       = 'Test Status',
    description = 'This is a test status.',
    time       = 10,
    onTimeUp = function()
      print('Time is up!')
    end, 

    progress   = 50, 
    progText   = 'Boxes Left' 
  })

  Wait(7000)

  StatusInfo.get('test'):update({
    title       = 'Test Status',
    progress    = 65,
    description = 'This is a test status. Updated.'
  })
end)

lib.registerStatusInfo = StatusInfo.register
lib.getStatusInfo = StatusInfo.get
lib.getStatusInfos = StatusInfo.getAll
lib.updateStatusInfo = StatusInfo.update
lib.destroyStatusInfo = StatusInfo.destroy
