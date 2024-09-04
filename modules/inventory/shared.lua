local inventory =  lib.load(('@clean_lib.bridge.inventory.%s.shared'):format(lib.settings.inventory))

lib.inventory = {
  img_path = function()
    return inventory.img_path() or 'nui://unknown_path/web/images/'
  end, 
}


return lib.inventory