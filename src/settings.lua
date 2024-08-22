return {
  language        = GetConvar('language', 'en'),
  server_name     = GetConvar('server_name', 'CleanRP'),
  framework       = GetConvar('framework', 'qbx_core'),
  inventory       = GetConvar('inventory', 'ox_inventory'),
  target          = GetConvar('target', 'ox_target'),
  keys            = GetConvar('keys', 'ox_keys'),
  jail            = GetConvar('jail', 'ox_jail'),
  time            = GetConvar('time', 'clean_weather'),
  progress        = GetConvar('progress', 'clean_lib'),
  phone           = GetConvar('phone', 'lb-phone'),
  fuel            = GetConvar('fuel', 'ox_fuel'),
  dispatch        = GetConvar('dispatch', 'ox_dispatch'),

  primaryColor    = GetConvar('primaryColor', 'clean'),
  primaryShade    = GetConvarInt('primaryShade', 9),
  logo            = GetConvar('logo', 'https://via.placeholder.com/150')
}

