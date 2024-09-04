local settings = lib.settings
local inventory_bridge = lib.loadBridge('inventory', settings.inventory, 'server')
local framework_bridge = lib.loadBridge('framework', settings.framework, 'server')

return {
  ---@param item_name: string
  ---@param callback: function
    ---@param item: table
  ---@return void
  useableItem       = inventory_bridge.useableItem or framework_bridge.useableItem,

  ---@param item_name: string
  ---@param count?: number
  ---@param slot?: number
  ---@param metadata?: table
  addItem           = inventory_bridge.addItem or framework_bridge.addItem,

  ---@param item_name: string
  ---@param count?: number
  ---@param slot?: number
  ---@param metadata?: table
  removeItem        = inventory_bridge.removeItem or framework_bridge.removeItem,

  ---@param inventory_id: string
  clearInventory    = inventory_bridge.clearInventory or framework_bridge.clearInventory,

  ---@param item_name: string
  ---@param metadata: table
  ---@param combine?: boolean
  editMetadata      = inventory_bridge.editMetadata or framework_bridge.editMetadata,

  ---@param inventory_id: string
  getInv            = inventory_bridge.getInv or framework_bridge.getInv,

  ---@param inventory_id: string
  getItems          = inventory_bridge.getItems or framework_bridge.getItems,

  ---@param inventory_id: string
  ---@param slot: number
  getItemBySlot     = inventory_bridge.getItemBySlot or framework_bridge.getItemBySlot,

  ---@param inventory_id: string
  ---@param item_name: string
  getItemByName     = inventory_bridge.getItemByName or framework_bridge.getItemByName,

  ---@param inventory_id: string
  ---@param metadata: table
  getItemByMetadata = inventory_bridge.getItemByMetadata or framework_bridge.getItemByMetadata,

  ---@param item: string
  ---@return table
  item              = inventory_bridge.item or framework_bridge.item,

  ---@param inventory_id: string
  ---@param label: string
  ---@param max_slots: number
  ---@param max_weight: number
  registerStash     = inventory_bridge.registerStash or framework_bridge.registerStash
}