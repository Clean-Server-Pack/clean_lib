local bridge = {
  get = function(src)
    if not src then return end
    src = tonumber(src)
    return lib.FW.Functions.GetPlayer(src)
  end,

}

return bridge