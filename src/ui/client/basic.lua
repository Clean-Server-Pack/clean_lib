lib.showHelpNotification = function(msg)
  AddTextEntry('clean_lib_help', msg)
  BeginTextCommandDisplayHelp('clean_lib_help')
  EndTextCommandDisplayHelp(0, false, true, -1)
end

lib.drawText3D = function(x,y,z,scale, scale_factor, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov * scale_factor
  if onScreen then
    SetTextScale(0.0, scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

lib.testUIMode = function()
  SetNuiFocus(true, true)
  SendNuiMessage(json.encode({
    action = 'OPEN_TEST_UI',
    data   = {}
  }, { sort_keys = true }))
end

RegisterNuiCallback('CLOSED_TEST_UI', function(data, cb)
  SetNuiFocus(false, false)
  cb({})
end)


DevTool.register('testUI', {
  label = 'UI Test Bed',
  command = true, 
  description = 'Show a list of all the UI elements and allow you to test them',
  icon = 'fas fa-tv',
  action = function()
    lib.testUIMode()
  end
})  

