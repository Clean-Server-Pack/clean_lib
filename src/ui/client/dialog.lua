local settings = lib.settings
local dialogs = {}
local dialog = {}
dialog.__index = dialog

dialog.register = function(id,data)
  assert(id, 'Dialog ID is required')
  assert(data and type(data) == 'table', 'Dialog data is required')
  assert(data.dialog, 'Dialog text is required')
  assert(data.title, 'Dialog title is required')
  local self = setmetatable(data, dialog)
  self.id = id  
  self.resource = GetInvokingResource() or GetCurrentResourceName() or 'unknown'
  dialogs[id] = self
  self:__init()
  return self
end

AddEventHandler('onResourceStop', function(resource)
  for k,v in pairs(dialogs) do 
    if v.resource == resource then
      v:close()
    end 
  end
end)

dialog.get = function(id)
  return dialogs[id]
end
  
function dialog:__init()
  local is_func = type(self.responses) == 'function' or rawget(self.responses, '__cfx_functionReference')
  if not is_func then 
    for k,v in ipairs(self.responses) do 
      v.action      = msgpack.unpack(msgpack.pack(v.action))
    end
  end 

  return true 
end

function dialog:viewCamera()
  if not self.entity or not DoesEntityExist(self.entity) then return; end
  local coords = GetOffsetFromEntityInWorldCoords(self.entity, 0, 1.5, 0.3)
  local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  SetEntityLocallyInvisible(cache.ped)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 500, true, true)
  SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
  SetCamRot(cam, 0.0, 0.0, GetEntityHeading(self.entity) + 180, 5)
  SetCamFov(cam, 40.0)
  self.cam = cam
end
 
function dialog:closeCamera()
  if not self.cam then return; end 
  RenderScriptCams(false, true, 500, true, true)
  DestroyCam(self.cam)
end 

function dialog:open(another_menu, entity)
  self.isOpen = true 

  if not another_menu then 
    self.entity = entity
  end 

  if self.entity and not another_menu then 
    self:viewCamera()
  end

  CreateThread(function()
    while self.isOpen and self.entity ~= cache.ped do
      Wait(0)
      SetEntityLocallyInvisible(cache.ped)
    end
  end)

  local is_func = type(self.responses) == 'function' or rawget(self.responses, '__cfx_functionReference')
  if is_func then 
    self.responses = self.responses()
    for k,v in ipairs(self.responses) do 
      local action_id = v.actionid or generate_action_id(self.responses)
      table.insert(self.formatted_responses, {
        label = v.label,
        icon = v.icon,
        description = v.description,
        dontClose = v.dontClose,
        disabled = v.disabled,
        actionid = action_id,
        dialog = v.dialog,
      })
      v.actionid = action_id
    end 
  end 

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
      clickSounds = self.clickSounds or settings.dialogClickSounds or false,
      hoverSounds = self.hoverSounds or settings.dialogHoverSounds or false,
      responses = self.formatted_responses
    }
  }))
end

function dialog:close(keep_cam)
  self.isOpen = false
  SetNuiFocus(false, false)

  SendNuiMessage(json.encode({
    action = 'DIALOG_STATE'
  }))
  if not keep_cam and not self.disableFocus then 
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
    print('theresa response')
    print('dont close', response.dontClose)
    print('dialog', response.dialog)
    print('prevDialog', self.prevDialog)
    
    if not response.dontClose and not response.dialog and not self.prevDialog then
      print('closing')
      self:close()
    end

    if response.action then
      response.action()
    end

    if response.dialog then
      local dialog = dialog.get(response.dialog)
      if dialog then
        dialog:open(true)
      end
    end

    if response.context then 
      lib.openContext(response.context)
    end 
  end
end

local get_open_dialog = function()
  for k,v in pairs(dialogs) do 
    if type(v) == 'table' and v.isOpen then
      return v
    end
  end
  return nil
end

RegisterNUICallback('DIALOG_SELECTED', function(data, cb)
  local current_dialog = get_open_dialog()
  if not current_dialog then
    return
  end
  local id = current_dialog.id
  local actionid = data.actionid
  if dialogs[id] then
    dialogs[id]:trigger_action(actionid)
  end
end)  

RegisterNuiCallback('DIALOG_GO_BACK', function(data,cb)
  local current_dialog = get_open_dialog()  

  --\\ Close last one 
  if not current_dialog then
    return
  end

  local prevDialog, prevContext = current_dialog.prevDialog, current_dialog.prevContext

  if prevDialog and dialogs[prevDialog] then
    dialogs[current_dialog.id].isOpen = false
    dialogs[prevDialog]:open(true)
  end

  if prevContext then
    dialogs[current_dialog.id]:close()
    lib.openContext(prevContext)
  end
end)



lib.registerDialog = dialog.register
lib.openDialog     = function(entity, id)
  local dialog = dialog.get(id)
  if dialog then
    dialog:open(false, entity)
  end 
end

lib.closeDialog    = function(id, keep_cam)
  for k,v in pairs(dialogs) do 
    if not id or v.id == id then
      v:close(keep_cam)
    end
  end
end

-- local var = 0
-- CreateThread(function()
--   lib.registerDialog('dialog_id', {
--     dialog = "Is there anything I can do to postpone this?",
--     title = "Officer",
--     icon = "fa-user-tie",
--     audioFile = "audio.mp3",

--     metadata = {
--       {
--         icon = "fa-user-tie",
--         label = "Officer",
--         data = "Grade 4",
--         progress = 0
--       },
--       {
--         icon = "fa-user-tie",
--         label = "Officer",
--         data = "Grade 4",
--         progress = 75
--       },
--       {
--         icon = "fa-user-tie",
--         label = "Officer",
--         data = "Grade 4",
--       }
--     },

--     responses = function()
--       return {
--         {
--           label = "Yes",
--           icon = "fa-user-tie",
--           -- description = "This is a description of the response lets make the length of this response longer to see how it looks on the screen and if it will wrap around",    
--           dontClose = true,
--           action = function()
--             print('yes')
--           end, 
--         },
--         {
--           label = "No",
--           icon = "fa-user-tie",
--           dontClose = true,
--           action = function()
--             print('no')
--           end
--         },
--         {
--           label = "Maybe So",
--           icon = "fa-user-tie",
--           dontClose = true,
--           action = function()
--             print('maybe so')
--           end
--         },
--         {
--           label = "Yes",
--           icon = "fa-user-tie",
--           description = "This is a description",
--           dontClose = true,
--           action = function()
--             print('yes')
--           end,
--         },
--         {
--           label = "No",
--           icon = "fa-user-tie",
--           dontClose = true,
--           action = function()
--             print('no')
--           end
--         },
--         {
--           label = "Maybe So",
--           icon = "fa-user-tie",
--           dontClose = true,
--           action = function()
--             print('maybe so')
--           end
--         },
--       }
--     end
--   })
-- end)

-- RegisterCommand('test_dialog', function()
--   print('test')



--   Wait(0)
--   lib.openDialog(cache.ped, 'dialog_id')
-- end)

-- RegisterCommand('update_dialog', function()
--   var = var + 10
--   print('update')
--   lib.openDialog(cache.ped, 'dialog_id')

-- end)