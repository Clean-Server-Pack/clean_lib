---@param vehicle number
---@param props VehicleProperties
---@diagnostic disable-next-line: duplicate-set-field
function lib.setVehicleProperties(vehicle, props)
  Entity(vehicle).state:set('dirk_lib:setVehicleProperties', props, true)
end
