lib.inputDialog = function(title, inputs, options)
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
        icon  = options.icon or 'keyboard',
        allowCancel = options.allowCancel ~= nil and options.allowCancel or true,
        prevContext = options.prevContext,
        prevDialog  = options.prevDialog
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

RegisterNuiCallback('INPUT_GO_BACK', function(data, cb)
  lib.closeInputDialog()
  if data?.prevContext then 
    cb({})
    return lib.openContext(data.prevContext)
  elseif data?.prevDialog then 
    cb({})
    return lib.openDialog(data.prevDialog)
  end 
end)

RegisterNuiCallback('INPUT_DIALOG_SUBMIT', function(data, cb)
  if data then 
    data.prevContext = nil
    data.prevDialog = nil
  end
  input:resolve(data)
  input = nil
  SetNuiFocus(false, false)
  cb({})
end)

