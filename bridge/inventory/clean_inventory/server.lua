return {

  --- Add Item to inventory either playerid or invId
  ---@param invId string | number Inventory ID or Player ID
  ---@param item string Item Name
  ---@param count number [Optional] Item Count
  ---@param slot number [Optional] Item Slot
  ---@param md table [Optional] Item Metadata
  ---@return boolean
  addItem  = function(invId, item, count, md, slot) 
    return exports.clean_inventory:addItem(invId, item, count, md, slot)
  end,

  --- Remove Item from inventory either playerid or invId
  ---@param invId string | number Inventory ID or Player ID
  ---@param item string Item Name
  ---@param count number [Optional] Item Count
  ---@param slot number [Optional] Item Slot
  ---@param md table [Optional] Item Metadata
  ---@return boolean
  removeItem = function(invId, item, count, md, slot)
    return exports.clean_inventory:removeItem(invId, item, count, md, slot)
  end,

  --- Check if player has item in inventory
  ---@param invId string | number Inventory ID or Player ID
  ---@param item string Item Name
  ---@param count number [Optional] Item Count
  ---@param slot number [Optional] Item Slot
  ---@param md table [Optional] Item Metadata
  ---@return nil | number | boolean  Returns nil if player does not have item, returns number of items if they have it
  hasItem = function(invId, item, count, md, slot) 
    return exports.clean_inventory:hasItem(invId, item, count, md, slot)
  end,

  

  getItemLabel = function(item)
    local item_exists =  exports.clean_inventory:Items(item)
    return item_exists and item_exists.label or false
  end,



  registerStash = function(id, data)
    return exports.clean_inventory:registerInventory(nil, {
      type = data.type or 'stash', 
      maxWeight = data.maxWeight or 1000,
      maxSlots = data.maxSlots or 50,
      
    })
  end,
  




} 