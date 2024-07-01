local current_notifications = {}


lib.notify = function()
  self.title = self.title or 'Notification'
end

return lib.notify