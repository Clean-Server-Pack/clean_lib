-- types || playerLoaded, playerLogout, playerDied
local settings = lib.settings


lib.player = {
  loaded = function()
    return isLoggedIn
  end,

}

return lib.player
