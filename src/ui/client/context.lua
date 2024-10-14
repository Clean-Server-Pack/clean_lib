local settings = lib.settings
local contextMenus   = {}
local saved_functions = {}
local currentContext = nil

local get_item_by_id = function(id)
  if not currentContext then return end
  for i, item in ipairs(contextMenus[currentContext].options) do
    if item.id == id then
      return item
    end
  end
  return false
end


RegisterNuiCallback('contextClicked', function(id,cb)
  cb('ok')
  if not currentContext then return end
  local item = get_item_by_id(id)
  
  if item then
    if item.onSelect then 
      local saved_function = saved_functions[item.id]
      saved_function()
    end 

    if item.clientEvent then 
      TriggerEvent(item.clientEvent, item.args)
    end

    if item.serverEvent then 
      TriggerServerEvent(item.serverEvent, item.args)
    end
  end

end)

lib.registerContext = function(id, data)
  
  -- OX COMPAT
  if type(id) == 'table' then 
    data = id
    data.id = data.id
    id = data.id
  end 

  
  contextMenus[id] = {
    title = data.title or 'My Context Menu',
    icon = data.icon or 'cog',
    canClose = data.canClose or true,
    searchBar = data.searchBar or false,
    dialog = data.dialog or false,
    menu = data.menu or false,
    description = data.description or false,
    watermark = data.watermark or nil,
    serverEvent = data.serverEvent or false,
    clientEvent = data.clientEvent or false,
    args = data.args or {},
    onExit = data.onExit or false,
    onBack = data.onBack or false,
    clickSounds = data.clickSounds or settings.contextClickSounds,
    hoverSounds = data.hoverSounds or settings.contextHoverSounds,
    options = data.options or {},
  }

  for i, item in ipairs(contextMenus[id].options) do
    contextMenus[id].options[i].id = string.format('%s_%s', id, i)
    local has_select = contextMenus[id].options[i].onSelect 
    if has_select then 
      saved_functions[contextMenus[id].options[i].id] = contextMenus[id].options[i].onSelect
    end
    

    contextMenus[id].options[i].onSelect = has_select and true or false
  end

  return true 
end

lib.openContext = function(id)
  if currentContext then lib.closeContext() end
  Wait(0)
  if not contextMenus[id] then error('No such context menu found') end
  local data = contextMenus[id]
  currentContext = id
  SetNuiFocus(true, true)
  SendNuiMessage(json.encode({
    action = 'CONTEXT_MENU_STATE',
    data   = {
      action = 'OPEN',
      menu = data
    }
  }))
end

lib.getOpenContextMenu = function()
  return currentContext
end

-- OX COMPATIBILITY
lib.showContext = lib.openContext

RegisterNuiCallback('openContext', function(data,cb)
  if data.back and contextMenus[currentContext].onBack then contextMenus[currentContext].onBack(); end 
  lib.openContext(data.id)
end)


lib.closeContext = function()
  if not currentContext then return end
  SetNuiFocus(false, false)

  if contextMenus[currentContext].onExit then 
    contextMenus[currentContext].onExit(); 
  end
  currentContext = nil

  SendNuiMessage(json.encode({
    action = 'CONTEXT_MENU_STATE',
    data   = {
      action = 'CLOSE',
    }
  }))
end

lib.hideContext = lib.closeContext

RegisterNuiCallback('closeContext', lib.closeContext)


RegisterNuiCallback('openDialog', function(data,cb)
  if data.back and contextMenus[currentContext].onBack then contextMenus[currentContext].onBack(); end 
  lib.closeContext()
  exports['clean_dialog']:openDialog(data.id)
end)