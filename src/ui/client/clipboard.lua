lib.copyToClipboard = function(text)
  SendNUIMessage({
    type         = "COPY_TO_CLIPBOARD",
    value        = val,
  })
end
