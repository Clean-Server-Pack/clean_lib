return {
  debug           = GetConvarInt('clean_lib:debug', 1),
  language        = GetConvar('clean_lib:language', 'en'),
  server_name     = GetConvar('clean_lib:server_name', 'CleanRP'),
  framework       = GetConvar('clean_lib:framework', 'qbx_core'),
  inventory       = GetConvar('clean_lib:inventory', 'ox_inventory'),
  target          = GetConvar('clean_lib:target', 'ox_target'),
  keys            = GetConvar('clean_lib:keys', 'ox_keys'),
  jail            = GetConvar('clean_lib:jail', 'ox_jail'),
  time            = GetConvar('clean_lib:time', 'clean_weather'),
  progress        = GetConvar('clean_lib:progress', 'clean_lib'),
  phone           = GetConvar('clean_lib:phone', 'lb-phone'),
  fuel            = GetConvar('clean_lib:fuel', 'ox_fuel'),
  dispatch        = GetConvar('clean_lib:dispatch', 'ox_dispatch'),

  primaryColor    = GetConvar('clean_lib:primaryColor', 'clean'),
  primaryShade    = GetConvarInt('clean_lib:primaryShade', 9),
  logo            = GetConvar('clean_liblogo', 'https://via.placeholder.com/150'),
  -- notify_audio    = GetConvar('notify_audio', true),
  -- notify_position = GetConvar('notify_position', 'top-right'),

  esxCharTables   = GetConvar('clean_lib:esxCharTables', 'esx_characters'),
}