local blip = {}
blip.__index = blip

blip.new = function(id, data)
  local self = setmetatable(data, blip)
  self.id = id
  blip[id] = self
  self:__init()
  return self
end

blip.get = function(id)
  return blip[id]
end

blip.delete = function(id)
  local blip = blip[id]
  if blip then
    blip:hide()
  end
  blip[id] = nil
end

blip.update = function(id, data)
  local blip = blip[id]
  if blip then
    for k,v in pairs(data) do 
      blip[k] = v
    end
    blip:hide()
    blip:render()
  end
end


function blip:__init()
  assert(self.pos, 'blip must have a position')
  assert(self.name, 'blip must have a name')
  assert(self.sprite, 'blip must have a sprite')
  assert(self.display, 'blip must have a display')
  assert(self.scale, 'blip must have a scale')
  assert(self.color, 'blip must have a color')

print('blip', self.name, self.pos.x, self.pos.y, self.pos.z)

  self:render()
end

function blip:canRender()
  return not self.canSee and true or self.canSee()
end


function blip:render()
  if self.blip then return end
  if not self:canRender() then return end
  local blip
  if self.area then
    blip = AddBlipForArea(self.pos.x, self.pos.y, self.pos.z, self.area.width, self.area.height)
  else
    blip = AddBlipForCoord(self.pos.x, self.pos.y, self.pos.z)
  end
  SetBlipSprite(blip, self.sprite or 1)
  SetBlipDisplay(blip, self.display or 4)
  SetBlipScale(blip, self.scale or 1.0)
  SetBlipColour(blip, self.color or 1)
  SetBlipAsShortRange(blip, self.shortRange or false)
  SetBlipCategory(blip, self.category or 1)
  SetBlipAlpha(blip, self.alpha or 255)
  SetBlipRotation(blip, self.rotation or 0)

  if self.route then
    SetBlipRoute(blip, self.route or true)
  end

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(self.name or 'Blip')
  EndTextCommandSetBlipName(blip)

  self.blip = blip
end

function blip:hide()
  if not self.blip then return end
  RemoveBlip(self.blip)
  self.blip = nil
end


CreateThread(function()
  while true do
    local wait_time = 1000
    for k,v in pairs(blip) do
      if type(v) == 'table' and v.id then
        if v.canSee then
          if v:canRender() then
            v:render()
          else
            v:hide()
          end
        end
      end
    end


    Wait(wait_time)
  end
end)




lib.blip = {
  register = function(id, data)
    return blip.new(id, data)
  end,

  destroy = function(id)
    return blip.delete(id)
  end,

  get = function(id)
    return blip.get(id)
  end,

  update = function(id, data)
    return blip.update(id, data)
  end
}

return lib.blip
