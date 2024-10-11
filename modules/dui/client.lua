--[[
[Mycroft Studios](https://github.com/Mycroft-Studios) 🤝 [DirkScripts](https://github.com/DirkDigglerz)
]]
------------------- ✨ Performance ✨ ---------------------
local setmetatable = setmetatable
local joaat= joaat
local CreateRuntimeTxd = CreateRuntimeTxd
local IsNamedRendertargetRegistered = IsNamedRendertargetRegistered
local RegisterNamedRendertarget = RegisterNamedRendertarget
local IsNamedRendertargetLinked = IsNamedRendertargetLinked
local LinkNamedRendertarget = LinkNamedRendertarget
local GetNamedRendertargetRenderId = GetNamedRendertargetRenderId
local CreateRuntimeTextureFromDuiHandle = CreateRuntimeTextureFromDuiHandle
local SetDuiUrl = SetDuiUrl
local GetEntityCoords = GetEntityCoords
local DoesEntityExist = DoesEntityExist
local CreateDui = CreateDui
local GetDuiHandle = GetDuiHandle
local DrawSprite = DrawSprite
local SetTextRenderId = SetTextRenderId
local SetScriptGfxDrawOrder = SetScriptGfxDrawOrder
local DisableAllControlActions = DisableAllControlActions
local GetDisabledControlNormal = GetDisabledControlNormal
local RequestStreamedTextureDict = RequestStreamedTextureDict
local Wait = Wait
local IsDisabledControlJustPressed = IsDisabledControlJustPressed
local IsDisabledControlJustReleased = IsDisabledControlJustReleased
local GetNuiCursorPosition = GetNuiCursorPosition
local math = math
local SendDuiMouseWheel = SendDuiMouseWheel
local SendDuiMouseUp = SendDuiMouseUp
local SendDuiMouseWheel = SendDuiMouseWheel
local SendDuiMouseMove = SendDuiMouseMove
local SendDuiMessage = SendDuiMessage
local ClearFocus = ClearFocus
local SetNuiFocus = SetNuiFocus
------------------------------------------------------------
RequestStreamedTextureDict( "desktop_pc", false)
local Duis = {}
Dui = {}
Dui.__index = Dui

function Dui:__check()
  if not self.type then 
    return false, 'Dui must have a type'
  end

  if self.type == 'renderTarget' then 
    assert(self.targetEntity, 'Dui must have a targetEntity')
    assert(self.renderTarget, 'Dui must have a renderTarget')
  end

  if self.type == 'runtimeTexture' then 
    assert(self.originalTxd, 'Dui must have a originalTxd')
  end

  self.res = self.res or {x = 1280, y = 1080}
  self.url = self.url or '' 
  return true
end

function Dui:setUrl(url)
  self.url = url
  SetDuiUrl(self.object, url)
end

function Dui:attemptDraw()
  if self.type ~= 'renderTarget' then return end
  if not DoesEntityExist(self.targetEntity) then
    return false
  end

  if IsEntityOnScreen(self.targetEntity) and not IsEntityOccluded(self.targetEntity) then
    return self:draw()
  end
  
  return false
end

function Dui:getCursor()
  local sx, sy = self.res.x, self.res.y
  local cx, cy = GetNuiCursorPosition()
  cx, cy = (cx / sx), (cy / sy)
  return cx, cy
end

function Dui:handleControls()
  DisableAllControlActions(0)
  
  local cursorX, cursorY = self:getCursor() -- get cursor position
  self.lastCursorX = self.lastCursorX or 0
  self.lastCursorY = self.lastCursorY or 0

  if cursorX ~= self.lastCursorX or cursorY ~= self.lastCursorY then -- see if the cursor has moved
    self.lastCursorX = cursorX -- update X position
    self.lastCursorY = cursorY -- update Y position
    -- calcuate the difference in position and the dui resoltuion
    local duiX, duiY = math.floor(cursorX * self.res.x + 0.5), math.floor(cursorY * self.res.y + 0.5)
    SendDuiMouseMove(self.object, duiX, duiY) -- send mouse position to dui
  end

  DrawSprite("desktop_pc", "arrow", cursorX, cursorY, 0.05/4.5, 0.035, 0, 255, 255, 255, 255) -- draw sprite to show where the cursor is
  if IsDisabledControlJustPressed(0, 24) then -- LEFT CLICK press
    SendDuiMouseDown(self.object, "left")
  end
  if IsDisabledControlJustReleased(0, 24) then -- LEFT CLICK release
    SendDuiMouseUp(self.object, "left")
  end
  if IsDisabledControlJustPressed(0, 25) then -- Right CLICK press
    SendDuiMouseDown(self.object, "right")
  end
  if IsDisabledControlJustReleased(0, 25) then -- RIGHT CLICK release
    SendDuiMouseUp(self.object, "right")
  end
  if (IsDisabledControlJustPressed(0, 180)) then -- SCROLL DOWN
    SendDuiMouseWheel(self.object, -150, 0.0)
  end
  if (IsDisabledControlJustPressed(0, 181)) then -- SCROLL UP
    SendDuiMouseWheel(self.object, 150, 0.0)
  end

  if (IsControlJustPressed(2, 202)) then 
    self:toggleFocus()
  end
  return true
end

function Dui:registerRenderTarget()
  if not IsNamedRendertargetRegistered(self.renderTarget) then
    RegisterNamedRendertarget(self.renderTarget, false)
    if not IsNamedRendertargetLinked(self.renderModel) then
      LinkNamedRendertarget(self.renderModel)
    end
    self.rtHandle = GetNamedRendertargetRenderId(self.renderTarget)
  end
end

function Dui:createDui()
  self.object = CreateDui(self.url, self.res.x or 1920, self.res.y or 1080)
  self.handle = GetDuiHandle(self.object)
  if not self.txn then
    print('creating self.txn', self.txd, tostring(self.id), self.handle)
    self.txn = CreateRuntimeTextureFromDuiHandle(self.txd, tostring(self.id), self.handle)
    print('created self.txn', self.txn)
  end
end

--## This is used for drawing to renderTargets
function Dui:draw()
  --- Do stuff for renderTargets here yeah 
  SetTextRenderId(self.rtHandle) -- set render ID to the render target
  SetScriptGfxDrawOrder(4)
  SetScriptGfxDrawBehindPausemenu(true) -- allow it to draw behind pause menu
  DrawSprite(tostring(self.id), tostring(self.id), 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255) -- draw Dui Sprite
  -- process controls if interacting with the Dui
  if self.controls then
    self:handleControls()
  end
  SetTextRenderId(1) -- Reset Render ID (1 is default)
  return true
end

function Dui:toggleControls(state)
  self.controls = state ~= nil and state or not self.controls
end

function Dui:sendMessage(action, data)
  SendDuiMessage(self.object, json.encode({
    action = action,
    data = data
  }))
end

function Dui:toggleFocus()
  if not self.focus then
    local object = self.targetEntity
    if not object or object < 1 then return end
    SetFocusEntity(object)
    self:toggleControls(true)
    SetPlayerControl(PlayerId(), false, 0)
  else
    ClearFocus()
    self:toggleControls(false)
    SetPlayerControl(PlayerId(), true, 0)
  end
  self.focus = not self.focus
end

function Dui:create()
  if self.type == 'renderTarget' then 
    if IsNamedRendertargetRegistered(self.renderTarget) then
      ReleaseNamedRendertarget(self.renderTarget)
    end
    self:registerRenderTarget()
  elseif self.type == 'runtimeTexture' then
  end 
  self:createDui()
end

function Dui:remove()
  if self.type == 'renderTarget' then 
    if IsNamedRendertargetRegistered(self.renderTarget) then
      ReleaseNamedRendertarget(self.renderTarget)
    end
  end
  if self.object then
    self:setUrl('https://www.google.co.uk/')
    DestroyDui(self.object)
  end
end

function Dui:__init()


  self.renderModel = GetEntityModel(self.targetEntity)
  self.txd         = CreateRuntimeTxd(tostring(self.id))

  if self.type == 'renderTarget' then 
    if IsNamedRendertargetRegistered(self.renderTarget) then
      ReleaseNamedRendertarget(self.renderTarget)
    end

    lib.zones.register(self.id, {
      type = 'circle',
      pos  = GetEntityCoords(self.targetEntity),
      radius = self.renderDistance,
      onEnter = function()
        self:create()
        self.shouldRender = true 
      end,
      onExit = function()
        self.shouldRender = false
        self:remove()
      end
    })
  elseif self.type == 'runtimeTexture' then 
    self:create()
    lib.print.info('Creating runtime texture', self.id, self.originalTxd, self.originalTxn, self.txd, self.txn)
    AddReplaceTexture(self.originalTxd, self.originalTxn, self.txd, self.txn)
  end
end

---@class dui
---@field type string The type of Dui
--- Options for renderTarget
---@field targetEntity? number The Entity Handle of the Rendered Object
---@field targetModel? string The render target Model
---@field renderTarget? table The render target texture

---Options for runtimeTexture
---@field originalTxd string The original texture dictionary
---@field originalTxn string The original texture name

---@field renderDistance number the distance for rendering the Dui
---@field res table The browser resolution {x=int, y=int}
---@field url string The URL of the DUI browser
---@field handle string DUI browser handle
Dui.register = function(id, data)
  local self = setmetatable(data, Dui)
  self.id = id
  local is_valid, reason = self:__check()
  if not is_valid then
    return false, reason
  end
  self:__init()
  Duis[id] = self
  return self 
end

Dui.get = function(id)
  return Duis[id]
end

Dui.getNearest = function(pos)
  if not pos then pos = GetEntityCoords(cache.ped) end
  local nearest = nil
  local nearest_dist = 9999
  for k,v in pairs(Duis) do
    if v.type == 'renderTarget' then 
      local dist = #(pos - GetEntityCoords(v.targetEntity))
      if dist < nearest_dist then 
        nearest = v
        nearest_dist = dist
      end
    end
  end
  return nearest, nearest_dist
end

Dui.destroy = function(id)
  local dui = Duis[id]
  if dui then
    dui:__destroy()
    Duis[id] = nil
  end
end

function Dui:__destroy()
  if self.type == 'renderTarget' then 
    if IsNamedRendertargetRegistered(self.renderTarget) then
      ReleaseNamedRendertarget(self.renderTarget)
    end
  end
  if self.object then
    DestroyDui(self.object)
  end
end

CreateThread(function()
  while true do 
    local wait_time = 1000
    for k,v in pairs(Duis) do
      if v.type == 'renderTarget' and v.shouldRender then 
        local is_drawing = v:attemptDraw()
        
        wait_time = is_drawing and 0 or wait_time
      end
    end
    Wait(wait_time)
  end 
end)


lib.dui = {
  register = Dui.register,
  destroy = Dui.destroy,
  get = Dui.get,
  getNearest = Dui.getNearest
}

return lib.dui

--[[ Usage Examples ]]
--[[

--renderTarget providing an entity to render to 
local dui = lib.dui.register('example', {
  type = 'renderTarget',
  targetEntity = 0,
  renderDistance = 20.0,
  res = {x = 1920, y = 1080},
  url = 'https://example.com'
})


--renderTarget providing a model to render to
local dui = lib.dui.register('example', {
  type = 'renderTarget',
  targetModel = 'prop_cs_tablet',
  renderDistance = 20.0,
  res = {x = 1920, y = 1080},
  url = 'https://example.com'
})

--runtimeTexture
local dui = lib.dui.register('example', {
  type = 'runtimeTexture',
  originalTxd = 'example',
  originalTxn = 'example',
  renderDistance = 20.0,
  res = {x = 1920, y = 1080},
  url = 'https://example.com'
})




]]
