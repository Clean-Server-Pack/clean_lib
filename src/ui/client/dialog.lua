local dialog = {}
dialog.__index = dialog

dialog.new = function(id,data)
  assert(id, 'Dialog ID is required')
  assert(data and type(data) == 'table', 'Dialog data is required')
  assert(data.dialog, 'Dialog text is required')
  assert(data.title, 'Dialog title is required')
  local self = setmetatable(data, dialog)
  self.id = id  
  dialog[id] = self
  self:__init()
  return self
end

dialog.get = function(id)
  return dialog[id]
end
  
local generate_action_id = function(to_check)
  local id = string.format('dialog_action-%s', math.random(1000,9999))
  if to_check[id] then
    Wait(0)
    return generate_action_id(to_check)
  end
  return id
end


function dialog:__init()
  self.formatted_responses = {}
  
  for k,v in ipairs(self.responses) do 
    local action_id = v.actionid or generate_action_id(self.responses)
    table.insert(self.formatted_responses, {
      label = v.label,
      icon = v.icon,
      description = v.description,
      dontClose = v.dontClose,
      actionid = action_id,
      dialog = v.dialog,
      colorScheme = v.colorScheme
    })
    v.actionid = action_id
  end
end

function dialog:viewCamera()
  local coords = GetOffsetFromEntityInWorldCoords(entity, 0, 1.5, 0.3)
  local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  SetEntityLocallyInvisible(cache.ped)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 500, true, true)
  SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
  SetCamRot(cam, 0.0, 0.0, GetEntityHeading(entity) + 180, 5)
  SetCamFov(cam, 40.0)
  self.cam = cam
end

function dialog:closeCamera()
  if not self.cam then return; end 
  RenderScriptCams(false, true, 500, true, true)
  DestroyCam(self.cam)
end 

function dialog:open(another_menu)
  self.isOpen = true 

  if self.focusHead and not another_menu then 
    self:viewCamera()
  end

  CreateThread(function()
    while self.isOpen do
      Wait(0)
      SetEntityLocallyInvisible(cache.ped)
    end
  end)

  SetNuiFocus(true, true)
  SendNuiMessage(json.encode({
    action = 'DIALOG_STATE',
    data = {
      dialog = self.dialog,
      id = self.id,
      title = self.title,
      icon = self.icon,
      prevDialog = self.prevDialog,
      audioFile = self.audioFile,
      metadata = self.metadata,
      responses = self.formatted_responses
    }
  }))
end

function dialog:close()
  self.isOpen = false
  SetNuiFocus(false, false)
  SendNuiMessage(json.encode({
    action = 'DIALOG_STATE'
  }))
  if self.focusHead then 
    self:closeCamera()
  end

  if self.onClose then 
    self.onClose()
  end
end


function dialog:get_response_by_actionid(actionid)
  for k,v in ipairs(self.responses) do 
    if v.actionid == actionid then
      return v
    end
  end
  return nil
end

function dialog:trigger_action(actionid)
  if actionid == 'close' then
    self:close()
    return
  end
  local response = self:get_response_by_actionid(actionid)
  if response then
    if response.action then
      response.action()
    end

    if response.dialog then
      local dialog = dialog.get(response.dialog)
      if dialog then
        dialog:open(true)
      end
    end

    if not response.dontClose and not response.dialog then
      self:close()
    end
  end
end

local get_open_dialog = function()
  for k,v in pairs(dialog) do 
    if type(v) == 'table' and v.isOpen then
      return v
    end
  end
  return nil
end

RegisterNUICallback('dialogSelected', function(data, cb)
  local current_dialog = get_open_dialog()
  if not current_dialog then
    return
  end
  local id = current_dialog.id
  local actionid = data.actionid
  if dialog[id] then
    dialog[id]:trigger_action(actionid)
  end
end)  

RegisterNuiCallback('prevDialog', function(data,cb)
  local current_dialog = get_open_dialog()

  --\\ Close last one 
  if current_dialog then
    dialog[current_dialog.id].isOpen = false
  end

  local id = data.dialog
  if dialog[id] then
    dialog[id]:open(true)
  end

end)

local registerDialog = function(id, data)
  return dialog.new(id, data)
end


local openDialog = function(id)
  if dialog[id] then
    dialog[id]:open()
  end
end


local closeDialog = function()
  for k,v in pairs(dialog) do 
    if v.isOpen then
      v:close()
    end
  end
end

lib.dialog = {
  register = registerDialog,
  open = openDialog,
  close = closeDialog
}

-- RegisterCommand('test_dialog', function()
--   registerDialog('dialog_id', {
--     dialog = "Is there anything I can do to postpone this?",
--     title = "Officer",
--     icon = "fa-user-tie",
--     audioFile = "audio.mp3",

--     metadata = {
--       {
--         icon = "fa-user-tie",
--         label = "Officer",
--         data = "Grade 4",
--         type = 'text',
--         progress = 75
--       },
--       {
--         icon = "fa-user-tie",
--         label = "Officer",
--         data = "Grade 4",
--         type = 'text',
--         progress = 75
--       },
--       {
--         icon = "fa-user-tie",
--         label = "Officer",
--         data = "Grade 4",
--         type = 'text'
--       }
--     },

--     responses = {
--       {
--         label = "Yes",
--         icon = "fa-user-tie",
--         description = "This is a description",
--         dontClose = true,
--         action = function()
--           print('yes')
--         end, 
--         colorScheme = "#ff0000"
--       },
--       {
--         label = "No",
--         icon = "fa-user-tie",
--         dontClose = true,
--         action = function()
--           print('no')
--         end
--       },
--       {
--         label = "Maybe So",
--         icon = "fa-user-tie",
--         dontClose = true,
--         action = function()
--           print('maybe so')
--         end
--       },
--       {
--         label = "Yes",
--         icon = "fa-user-tie",
--         description = "This is a description",
--         dontClose = true,
--         action = function()
--           print('yes')
--         end,
--       },
--       {
--         label = "No",
--         icon = "fa-user-tie",
--         dontClose = true,
--         action = function()
--           print('no')
--         end
--       },
--       {
--         label = "Maybe So",
--         icon = "fa-user-tie",
--         dontClose = true,
--         action = function()
--           print('maybe so')
--         end
--       }
--     }
--   })


--   Wait(0)
--   openDialog('dialog_id')
-- end)









