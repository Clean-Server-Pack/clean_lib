local interact = {}
interact.__index = interact

local supported_zone_types = {
  poly = true, 
  circle = true,
  circle2D = true,
  box    = true, 
}

local support_types = {
  marker = true, 
  text   = true
}

interact.new = function(id,data)
  local self = setmetatable(data, interact)
  self.id = id
  interact[id] = self
  self:init()
  return self
end

interact.get = function(id)
  return interact[id]
end

interact.delete = function(id)
  interact[id] = nil
end


function interact:init()
  assert(self.type, 'interact must have a specified type : marker, text')
  assert(self.zone_type, 'interact must have a specified type : circle, circle2D, poly, box')
  assert(supported_zone_types[self.zone_type], 'unsupported interact type')

  lib.zones.register(self.id, {
    type    = self.zone_type,
    pos     = self.pos, 
    radius  = self.radius,
    polygon = self.polygon,
    size    = self.size,  

    onEnter = function(data)
      self.displaying = true
      if self.onShow then 
        self.onShow(data)
      end
    end,

    onExit = function(data)
      self.displaying = false

      if self.onHide then 
        self.onHide(data)
      end
    end
  })
end

function interact:draw()
  if not self.displaying then return end

  if self.type == 'marker' then 



  elseif self.type == 'text' then 
    print('draw text')
  
  end


  return true 
end

local type = type 
CreateThread(function()
  while true do 
    local wait_time = 1000 
    for k,v in pairs(interact) do 
      if type(v) == 'table' and v.id and v.displaying then 
        if v.whileDisplay then 
          v.whileDisplay()
          wait_time = 0 
        end

        local drawing = v:draw()
        wait_time = drawing and 0 or wait_time
      end
    end
    Wait(wait_time)
  end
end)

lib.interact = {
  register = function(name, data)
    return interact.new(name, data)
  end,

  get = function(name)
    return interact.get(name)
  end,

  destroy = function(name)
    return interact.delete(name)
  end,
}

return lib.interact


--[[
  Usage 


  lib.interact.register('test', {


    -- zone_type = 'circle',
    pos       = vector4(0,0,0,0),
    radius    = 10,

    -- zone_type = 'poly',
    -- polygon = {
      vector3(0,0,0),
      vector3(0,0,0),
    },

    -- zone_type = 'box',
    -- size = vector3(1,1,1),

    -- type = 'marker',
    color = vector4(255,255,255,255),
    scale = vector3(1,1,1),
    dir?  = vector3(0,0,0),
    rot?  = vector3(0,0,0),
    bob?  = boolean,
    face? = boolean,
    txd?  = string,
    txn?  = string,
    drawEnts? = boolean,

    -- type = 'text',
    -- text = 'Hello World',



  })

]]