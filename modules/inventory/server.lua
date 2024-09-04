local inventory = lib.load(('@clean_lib.bridge.inventory.%s.server'):format(lib.settings.inventory))

lib.inventory = {}

lib.inventory.useableItem = function(item_name, callback)
  local useableItem = inventory.useableItem
  if useableItem then
    useableItem(item_name, callback)
  else 
    if lib.settings.framework == 'qb-core' then 
      lib.FW.Functions.CreateUseableItem(item_name, function(src, item)
        callback(src, item)
      end)
    elseif lib.settings.framework == 'es_extended' then 
      lib.FW.RegisterUsableItem(item_name, function(src, item)
        callback(src, item)
      end)
    end
  end
end

lib.inventory.addItem = function(item_name, count, slot, metadata)
  local addItem = inventory.addItem
  if addItem then
    return addItem(item_name, count, slot, metadata)
  else 
    if lib.settings.framework == 'qb-core' then 
      return lib.FW.Functions.AddItem(item_name, count, slot, metadata)
    elseif lib.settings.framework == 'es_extended' then 
      return lib.FW.AddItem(item_name, count, slot, metadata)
    end
  end
end

return lib.inventory