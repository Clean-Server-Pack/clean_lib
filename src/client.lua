RegisterNuiCallback('GET_SETTINGS', function(data, cb)
  cb(lib.settings)
end)

RegisterNuiCallback('GET_LOCALES', function(data, cb)
  cb(lib.getLocales())
end)