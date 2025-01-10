lib.inputDialog = function(title, inputs, options)
  local icon = 'keyboard'
  if input then return end
  input = promise.new()
  options = options or {}


  SetNuiFocus(true, true)
  SendNuiMessage(json.encode({
    action = 'OPEN_INPUT_DIALOG',
    data   = {
      info    = {
        title = title,
        description = options.description,     
        icon  = icon,
        allowCancel = options.allowCancel ~= nil and options.allowCancel or true,
        fromContext = options.fromContext,
        fromDialog = options.fromDialog
      },
      inputs  = inputs,
    },
  }))

  return Citizen.Await(input)
end

lib.closeInputDialog = function()
  if not input then return end

  SendNuiMessage(json.encode({
    action = 'CLOSE_INPUT_DIALOG',
  }))
  SetNuiFocus(false, false)

  input:resolve(nil)
  input = nil
end

RegisterNuiCallback('INPUT_DIALOG_RESOLVE', function(data, cb)
  print('INPUT_DIALOG_RESOLVE', json.encode(data, {indent = true}))
  if data and type(data) == 'table' and (data.fromContext or data.fromDialog) then 
    print('GOIGN BACK TO CONTEXT or DIALOG', data.fromContext, data.fromDialog)
    input:resolve(nil)
    input = nil
    cb({})
    if data.fromContext then 
      lib.openContext(data.fromContext)
    elseif data.fromDialog then 
      lib.openDialog(data.fromDialog)
    end 
    return
  end 


  input:resolve(data)
  input = nil

  SetNuiFocus(false, false)
  cb({})
end)

RegisterCommand('test_input', function()
  local input = lib.inputDialog('Group Info', {
    {type = 'input', label = 'Name', description = 'The name of your group!', required = true, min = 4, max = 16},
  })
  print(json.encode(input))
end)