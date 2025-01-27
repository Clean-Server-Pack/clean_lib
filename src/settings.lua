return {

  debug           = GetConvar('clean_lib:debug', 'true') == 'true',
  currency        = GetConvar('clean_lib:currency', '$'),
  language        = GetConvar('clean_lib:language', 'en'),
  server_name     = GetConvar('clean_lib:server_name', 'CleanRP'),
  framework       = GetConvar('clean_lib:framework', 'qbx_core'),
  inventory       = GetConvar('clean_lib:inventory', 'ox_inventory'),
  itemImgPath     = GetConvar('clean_lib:itemImgPath', 'nui://clean_inventory/web/images/'),
  target          = GetConvar('clean_lib:target', 'ox_target'),
  keys            = GetConvar('clean_lib:keys', 'ox_keys'),
  interact        = GetConvar('clean_lib:interact', 'sleepless_interact'),
  time            = GetConvar('clean_lib:time', 'clean_weather'),
  fuel            = GetConvar('clean_lib:fuel', 'ox_fuel'),
  
  garage          = GetConvar('clean_lib:garage', 'ox_garage'),
  ambulance       = GetConvar('clean_lib:ambulance', 'qb-ambulancejob'),
  prison          = GetConvar('clean_lib:prison', 'ox_jail'),
  dispatch        = GetConvar('clean_lib:dispatch', 'ox_dispatch'),
  phone           = GetConvar('clean_lib:phone', 'lb-phone'),

  --## Menus/Progress etc  
  notify          = GetConvar('clean_lib:notify', 'clean_lib'),
  notifyPosition  = GetConvar('clean_lib:notifyPosition', 'top-right'),
  notifyAudio     = GetConvar('clean_lib:notifyAudio', 'true') == 'true',

  progress        = GetConvar('clean_lib:progress', 'clean_lib'),
  progBarPosition = GetConvar('clean_lib:progBarPosition', 'bottom-center'),

  showTextUI       = GetConvar('clean_lib:showTextUI', 'clean_lib'),
  showTextPosition = GetConvar('clean_lib:showTextPosition', 'bottom-center'),
  
  contextMenu        = GetConvar('clean_lib:contextMenu', 'clean_lib'),
  contextClickSounds = GetConvar('clean_lib:contextClickSounds', 'true') == 'true',
  contextHoverSounds = GetConvar('clean_lib:contextHoverSounds', 'true') == 'true',

  dialog            = GetConvar('clean_lib:dialog', 'clean_lib'),
  dialogClickSounds = GetConvar('clean_lib:dialogClickSounds', 'true') == 'true',
  dialogHoverSounds = GetConvar('clean_lib:dialogHoverSounds', 'true') == 'true',


  primaryColor    = GetConvar('clean_lib:primaryColor', 'clean'),
  primaryShade    = GetConvarInt('clean_lib:primaryShade', 9),
  customTheme     = json.decode(GetConvar('clean_lib:customTheme', json.encode({
    "#f8edff",
    "#e9d9f6",
    "#d0b2e8",
    "#b588da",
    "#9e65cf",
    "#914ec8",
    "#8a43c6",
    "#7734af",
    "#692d9d",
    "#5c258b"
  }))),


  logo              = GetConvar('clean_liblogo', 'https://via.placeholder.com/150'),
  notify_audio      = GetConvar('notify_audio', 'true') == 'true',
  notify_position   = GetConvar('notify_position', 'top-right'),
  showText_position = GetConvar('showText_position', 'bottom-center'),
  progbar_position  = GetConvar('progbar_position', 'bottom-center'),

  contextClickSounds = GetConvar('contextClickSounds', 'true') == 'true',
  contextHoverSounds = GetConvar('contextHoverSounds', 'true') == 'true',
  dialogClickSounds  = GetConvar('dialogClickSounds', 'true') == 'true',
  dialogHoverSounds  = GetConvar('dialogHoverSounds', 'true') == 'true',
}