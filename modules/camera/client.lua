camera = {
  current = false,
  new = function(data)
    camera.fade_time = data.fadeTime or 250
    camera.current = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(camera.current, data.pos.x, data.pos.y, data.pos.z)
    SetCamRot(camera.current, data.rot.x, data.rot.y, data.rot.z)
  end,

  view = function(data)
    if not camera.current then return end
    DoScreenFadeOut(1000)
    Wait(1000)
    SetCamActive(camera.current, true)
    RenderScriptCams(true, false, 0, true, true)
    DoScreenFadeIn(1000)
    Wait(1000)
    return true
  end,

  exit = function(data)
    if not camera.current then return end
    DoScreenFadeOut(camera.fade_time)
    Wait(camera.fade_time)
    RenderScriptCams(false, false, 0, true, true)
    SetCamActive(camera.current, false)
    DestroyCam(camera.current)
    camera.current = false
    DoScreenFadeIn(camera.fade_time)
    Wait(camera.fade_time)
    return true
  end,



}




lib.camera = {
  focusEntity = function(entity, data)
    print('focus entity', entity, data)
    camera.exit(data)
    camera.new(data)
    PointCamAtEntity(camera.current, entity, data.offset.x, data.offset.y, data.offset.z, true)

    camera.view(data)
  end,

  focusHead = function(entity, data)
    camera.exit()
    local forward_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 1.0, 1.0)
    local head_pos = GetPedBoneCoords(entity, 31086, 0.0, 0.0, 0.0)
    camera.new({
      pos = vector3(forward_pos.x, forward_pos.y, head_pos.z),
      rot = data.rot,
    })

    while not camera.current do Wait(0); end
    PointCamAtCoord(camera.current, head_pos.x, head_pos.y, head_pos.z)

    camera.view(data)
  end,

  focusPoint  = function(data)
    camera.exit()
    camera.new(data)
    camera.view(data)
  end,

  exit = function()
    camera.exit()
  end,
}

return lib.camera
