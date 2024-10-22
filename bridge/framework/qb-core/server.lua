return {
  canUseItem = function(item)
    return lib.FW.Functions.CanUseItem(item)
  end,

  useableItem = function(item, cb)
    return lib.FW.Functions.CreateUseableItem(item,cb)
  end,
}