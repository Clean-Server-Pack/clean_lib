lib.copyToClipboard = function(text)
  SendNUIMessage({
    action         = "COPY_TO_CLIPBOARD",
    data           = text,
  })
end
