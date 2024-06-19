lib.await = function(func, timeout)
  local start_time = GetGameTimer()
  while not func() do
    if GetGameTimer() - start_time > timeout then
      return false
    end 
    Wait(0)
  end
  return true
end

return lib.await