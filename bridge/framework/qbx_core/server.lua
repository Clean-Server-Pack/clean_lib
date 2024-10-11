return {
  canUseItem = function(item)
    return exports.qbx_core:CanUseItem(item)
  end,

  useableItem = function(item, cb)
    return exports.qbx_core:CreateUseableItem(item, cb)
  end,
}