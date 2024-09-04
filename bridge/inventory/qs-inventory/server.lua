return {

  useableItem = function(item_name, callback)
    exports['qs-inventory']:CreateUseableItem(item_name, function(src, item)
      callback(src, item)
    end)
  end
}