local settings = lib.settings
local inventory_bridge = lib.loadBridge('inventory', settings.inventory, 'client')
local framework_bridge = lib.loadBridge('framework', settings.framework, 'client')

return {


  ---@function lib.inventory.displayMetadata 
  ---@description # Display metadata of an item with the specific key
  ---@param labels table | string # table of metadata to display the string of the metadata key
  ---@param value? string # value of the metadata key
  ---@return boolean 
  displayMetadata = inventory_bridge.displayMetadata or framework_bridge.displayMetadata,
}