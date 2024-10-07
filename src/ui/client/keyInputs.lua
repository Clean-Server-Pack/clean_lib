-- type KeyInputProps = {
--   qwerty: string
--   label: string
--   icon: string
--   delay?: number
--   hidden?: boolean
--   pressed?: boolean
-- }
-- type DirectionProps = 'row' | 'column' | 'row-reverse' | 'column-reverse'
-- type PositionProps = 'top-right' | 'right-center' | 'bottom-right' | 'top-left' | 'left-center' | 'bottom-left' | 'bottom-center' | 'top-center' | { top?: string | number, right?: string | number, bottom?: string | number, left?: string | number, transform?: string } |
-- {  
-- top?: string | number
--   right?: string | number
--   bottom?: string | number
--   left?: string | number
--   transform?: string
-- }


local invoking_resource = nil
AddEventHandler('onResourceStop', function(resource)
  if resource == invoking_resource then
    lib.hideKeys()
  end
end)

local keyInputOpen = false
local stored_checks = {}
local stored_functions = {}
lib.showKeys = function(data)
  invoking_resource = GetInvokingResource()
  if keyInputOpen then
    lib.hideKeys()
  end
  assert(type(data) == 'table', 'arg must be a table for lib.showKeys')
  assert(type(data.position) == 'string' or type(data.position) == 'table', 'data.position must be a string or table for lib.showKeys')
  assert(type(data.inputs) == 'table', 'data.inputs must be a table for lib.showKeys')
  assert(#data.inputs > 0, 'data.inputs must have at least one input for lib.showKeys')
  local current_inputs = {}
  for k,v in ipairs(data.inputs) do 
    assert(type(v.key) == 'string', 'data.inputs['..k..'].key must be a string for lib.showKeys even if its a number just put it in quotes')
    local key_info = lib.getKey(v.key)
    assert(key_info, 'data.inputs['..k..'].key must be a valid key for lib.showKeys')
    assert(type(v.label) == 'string', 'data.inputs['..k..'].label must be a string for lib.showKeys')
    assert(type(v.icon) == 'string', 'data.inputs['..k..'].icon must be a string for lib.showKeys')
    assert(type(v.delay) == 'number' or v.delay == nil, 'data.inputs['..k..'].delay must be a number or nil for lib.showKeys')
    
    v.qwerty         = key_info.qwerty
    v.control        = key_info.control

    if v.canInteract then 
      stored_checks[v.qwerty] = v.canInteract
    end

    if v.action then
      stored_functions[v.qwerty] = v.action
    end

    if not v.action then 
      stored_functions[v.qwerty] = function()
        if v.clientEvent then
          TriggerEvent(v.clientEvent, v.args and table.unpack(v.args) or nil)
        elseif v.serverEvent then
          TriggerServerEvent(v.serverEvent, v.args and table.unpack(v.args) or nil)
        elseif v.export then
          exports[v.export](v.args and table.unpack(v.args) or nil)
        end
      end
    end 

    table.insert(current_inputs, {
      key = v.key,
      label = v.label,
      icon = v.icon,
      control = v.control,
      canHold = v.canHold or false,
      qwerty = v.qwerty,
      delay = v.delay or false,
      hidden = v.canInteract and not v.canInteract() or false,
      pressed = false
    })
  end

  keyInputOpen = true

  SendNuiMessage(json.encode({
    action = 'SET_KEY_INPUTS',
    data = {
      position = data.position,
      inputs = current_inputs,
      direction = data.direction or 'column'
    }
  }, {sort_keys = true}))

  -- Catch when a control is pressed and released and update current_pressed if theres a difference

  CreateThread(function()
    while keyInputOpen do
      local changed_inputs = false 
      for index, control in pairs(current_inputs) do
        local is_hidden  = stored_checks[control.qwerty] and not stored_checks[control.qwerty]() or false
        DisableControlAction(1, tonumber(control.control), not is_hidden)
        local is_pressed = IsDisabledControlPressed(1, tonumber(control.control))
  
        if is_pressed and not control.delay then 
          if stored_functions[control.qwerty] then
            stored_functions[control.qwerty]()
          end
        end
  
        if control.pressed ~= is_pressed then
          changed_inputs = true
          control.pressed = is_pressed
        end
  
        if control.hidden ~= is_hidden then
          changed_inputs = true
          control.hidden = is_hidden
        end
      end  
      
      if changed_inputs then
        if #current_inputs == 0 then
          lib.hideKeys()
        else 
          if not keyInputOpen then return end
          SendNuiMessage(json.encode({
            action = 'SET_KEY_INPUTS',
            data = {
              position = data.position,
              direction = data.direction or 'column',
              inputs = current_inputs
            }
          }, {sort_keys = true}))
        end
      end
      
      Wait(0)
    end
  end)
end

RegisterNuiCallback('KEY_INPUT', function(data, cb)
  if stored_functions[data.qwerty] then
    stored_functions[data.qwerty]()
  end
end)

lib.hideKeys = function()
  keyInputOpen = false
  SendNuiMessage(json.encode({
    action = 'HIDE_KEY_INPUTS'
  }))
end

lib.isKeysOpen = function()
  return keyInputOpen
end


-- CreateThread(function()
--   Wait(2000)
--   lib.showKeys({
--     position = 'bottom-center',
--     direction='row',
--     inputs = {
--       {
--         key = 'e',
--         label = 'Interact',
--         icon = 'fas fa-handshake',
--         delay = 6000,
        
--         canInteract = function()
--           return true
--         end,

--         action = function()
--           print('Interacted')
--         end
--       },
--       {
--         key = 'g',
--         label = 'Greet',
--         icon = 'fas fa-handshake',
--         canInteract = function()
--           return true
--         end,
--         action = function()
--           print('Greeted')
--         end
--       },
--       {
--         key = 'h',
--         label = 'Hug',
--         icon = 'fas fa-handshake',
--         canInteract = function()
--           return true
--         end,
--         action = function()
--           print('Hugged')
--         end
--       },
--       {
--         key = 'x',
--         label = 'Kiss',
--         icon = 'fas fa-handshake',
--         canInteract = function()
--           return true
--         end,
--         action = function()
--           print('Kissed')
--         end
--       },
--       {
--         key = 'y',
--         label = 'Wave',
--         icon = 'fas fa-handshake',
--         canInteract = function()
--           return true
--         end,
--         action = function()
--           print('Waved')
--         end
--       },
--       {
--         key = 'z',
--         label = 'Dance',
--         icon = 'fas fa-handshake',
--         canInteract = function()
--           return true
--         end,
--         action = function()
--           print('Danced')
--         end
--       },
--     }
--   })
-- end)

--[[
  Usage of lib.showKeys


]]