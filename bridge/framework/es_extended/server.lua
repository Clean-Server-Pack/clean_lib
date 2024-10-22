return {
  canUseItem = function(item)
    return lib.FW.UsableItemsCallbacks[item]
  end,

  useableItem = function(item, cb)
    return lib.FW.RegisterUsableItem(item, cb)
  end,

  getItemLabel = function(item)
    return lib.FW.GetItemLabel(item)
  end,
}