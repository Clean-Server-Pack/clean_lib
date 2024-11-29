local clean_hud = exports['clean_hud']

lib.inputDialog = function(title, inputs, options)
  local icon = 'keyboard'
  if input then return end
  input = promise.new()
  options = options or {}

  if clean_hud then 
    clean_hud:toggleAllHud(false)
  end 


  SetNuiFocus(true, true)
  SendNuiMessage(json.encode({
    action = 'OPEN_INPUT_DIALOG',
    data   = {
      info    = {
        title = title,
        icon  = icon,
        allowCancel = options.allowCancel ~= nil and options.allowCancel or true,
      },
      inputs  = inputs,
    },
  }))

  return Citizen.Await(input)
end

lib.closeInputDialog = function()
  if not input then return end


  if clean_hud then 
    print('clean_hud')
    clean_hud:toggleAllHud(true)
  end

  SendNuiMessage(json.encode({
    action = 'CLOSE_INPUT_DIALOG',
  }))
  SetNuiFocus(false, false)

  input:resolve(nil)
  input = nil
end

RegisterNuiCallback('INPUT_DIALOG_RESOLVE', function(data, cb)
  input:resolve(data)
  input = nil
  if clean_hud then 
    print('clean_hud')
    clean_hud:toggleAllHud(true)
  end

  SetNuiFocus(false, false)
  cb({})
end)

RegisterCommand('test_input', function()
  local input = lib.inputDialog('Group Info', {
    {type = 'input', label = 'Name', description = 'The name of your group!', required = true, min = 4, max = 16},
  })
  print(json.encode(input))
end)