-- export type PositionProps = 'top-right' | 'right-center' | 'bottom-right' | 'top-left' | 'left-center' | 'bottom-left' | 'bottom-center' | 'top-center' | 
-- {  
--   top?: string | number
--   right?: string | number
--   bottom?: string | number
--   left?: string | number
--   transition?: 'slide-right' | 'slide-left' | 'slide-up' | 'slide-down' | 'fade'
--   transform?: string
-- }

-- type TextUIOptions = {
--   position?: PositionProps
--   icon?: string
--   iconColor?: string
--   iconAnimation?: string
--   style?: React.CSSProperties
--   alignIcon?: 'top' | 'center' | 'bottom'
-- }

local invoking_resource = nil
AddEventHandler('onResourceStop', function(resource)
  if resource == invoking_resource then
    lib.hideTextUI()
  end
end)

local isOpen = false
lib.showTextUI = function(text, options)
  assert(text and type(text) == 'string', 'text must be a string')
  assert(options == nil or type(options) == 'table', 'options must be a table or nil')
  invoking_resource = GetInvokingResource()
  if not options then options = {
    position = lib.settings.showTextPosition, 
  } end 
  if not options.position then options.position = lib.settings.showTextPosition end
  isOpen = true
  SendNuiMessage(json.encode({
    action = 'SHOW_TEXT_UI',
    data = {
      text = text,
      options = options
    }
  }))
end

lib.updateTextUI = function(text)
  assert(text and type(text) == 'string', 'text must be a string')
  if not isOpen then return end
  SendNuiMessage(json.encode({
    action = 'UPDATE_TEXT_UI',
    data = text,
  }))
end

lib.hideTextUI = function()
  isOpen = false
  SendNuiMessage(json.encode({
    action = 'HIDE_TEXT_UI'
  }))
end

lib.isTextUIOpen = function()
  return isOpen
end