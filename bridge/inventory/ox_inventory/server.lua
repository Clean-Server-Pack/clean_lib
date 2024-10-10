return {

  --- Add Item to inventory either playerid or invId
  ---@param invId string | number Inventory ID or Player ID
  ---@param item string Item Name
  ---@param count number [Optional] Item Count
  ---@param slot number [Optional] Item Slot
  ---@param md table [Optional] Item Metadata
  ---@return boolean
  addItem  = function(invId, item, count, md, slot)
    return exports.ox_inventory:AddItem(invId, item, count or 1, md, slot)
  end,

  --- Remove Item from inventory either playerid or invId
  ---@param invId string | number Inventory ID or Player ID
  ---@param item string Item Name
  ---@param count number [Optional] Item Count
  ---@param slot number [Optional] Item Slot
  ---@param md table [Optional] Item Metadata
  ---@return boolean
  removeItem = function(invId, item, count, md, slot)
    return exports.ox_inventory:RemoveItem(invId, item, count or 1, md, slot)
  end,

  --- Check if player has item in inventory
  ---@param invId string | number Inventory ID or Player ID
  ---@param item string Item Name
  ---@param count number [Optional] Item Count
  ---@param slot number [Optional] Item Slot
  ---@param md table [Optional] Item Metadata
  ---@return nil | number | boolean  Returns nil if player does not have item, returns number of items if they have it
  hasItem = function(invId, item, count, md, slot)
    if not slot then 
      return exports.ox_inventory:GetItem(invId, item, md, true) 
    else 
      local item_in_slot = exports.ox_inventory:GetSlot(invId, slot)
      if not item_in_slot then return false end 
      if item_in_slot.name ~= item then return false end
      if md then 
        for k,v in pairs(md) do 
          if item_in_slot.metadata[k] ~= v then return false end 
        end 
      end
      if count then 
        if item_in_slot.count < count then return false end 
      end
      return true
    end 
    return exports.ox_inventory:GetItemCount(invId, itemName, slot, md)
  end,
  




} 