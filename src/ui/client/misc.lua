lib.copyToClipboard = function(text)
  SendNUIMessage({
    action         = "COPY_TO_CLIPBOARD",
    data           = text,
  })
end

lib.openLink = function(link)
  SendNUIMessage({
    action         = "OPEN_LINK",
    data           = link,
  })
end