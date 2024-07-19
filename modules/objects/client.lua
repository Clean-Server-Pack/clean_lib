object = {}
object.__index = object

object.new = function(id, data)

  local self = setmetatable(data, object)
  self.id = id
  object[id] = self
  self:__init()
  return self
end

object.get = function(id)
  return object[id]
end

object.delete = function(id)
  object[id] = nil
end


function object:__init()
  self.resource = cache.resource
  assert(self.type, 'object must have a specified type : ped, vehicle, object')
  assert(self.model, 'object must have a model')
  assert(self.pos, 'object must have a position')
  self.renderDist = self.renderDist or 50.0

  local stock_funcs = {
    onEnter = function()
      print('onEnter')
      local can_spawn = self.canSpawn and self.canSpawn() or true
      if not can_spawn then return end
      self:spawn()
    end,

    onExit = function()
      self:despawn()
    end,

    onInside = function()
      local can_spawn = self.canSpawn and self.canSpawn() or true
      if not can_spawn then
        self:despawn()
        return
      end
      self:spawn()
    end,
  }

  if type(self.renderDist) == 'table' then --\\ Poly?
    local settings = {
      type   = 'poly',
      points = self.renderDist,
    }
    settings.onEnter  = stock_funcs.onEnter
    settings.onExit   = stock_funcs.onExit
    settings.onInside = stock_funcs.onInside
    lib.zones.register(self.id, settings)
  else
    local settings = {
      type   = 'circle',
      pos    = self.pos,
      radius = self.renderDist,
    }
    settings.onEnter  = stock_funcs.onEnter
    settings.onExit   = stock_funcs.onExit
    settings.onInside = stock_funcs.onInside
    lib.zones.register(self.id, settings)
  end

  AddEventHandler('onResourceStop', function(resource)
    if self.resource == resource or resource == 'dirk_lib' then
      self:despawn()
    end
  end)

  print(('object %s registered'):format(self.id))

end

function object:despawn()
  if not self.entity then return end
  DeleteEntity(self.entity)
  self.entity = nil

  if self.onDespawn then
    self:onDespawn()
  end
end

function object:spawn()
  if self.entity then return end
  local model_loaded = lib.request.model(self.model, 15000)
  assert(model_loaded, 'Failed to load model : ' .. self.model)

  if self.type == 'ped' then
    self.entity = CreatePed(1, self.model, self.pos, self.pos.w or 0.0, false, false)
  elseif self.type == 'vehicle' then
    self.entity = CreateVehicle(self.model, self.pos, self.pos.w or 0.0, false, false)
  elseif self.type == 'object' then
    print('creating object')
    self.entity = CreateObject(self.model, self.pos, false, false, false)
    SetEntityHeading(self.entity, self.pos.w or 0.0)
  end

  if self.entity then
    SetEntityAsMissionEntity(self.entity, true, true)
    SetModelAsNoLongerNeeded(self.model)
  end

  if self.onSpawn then
    self:onSpawn({
      entity = self.entity
    })
  end

  return self.entity
end


lib.objects = {
  register = function(name, new_data)
    return object.new(name, new_data)
  end,

  get = function(id)
    return object.get(id)
  end,

  destroy = function(id)
    return object.delete(id)
  end

  destroy = function(id)
    return object.delete(id)
  end
}


return lib.objects
