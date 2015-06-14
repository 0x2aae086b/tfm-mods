function changeUI(name)
   local data = playerData[name]
   data.ui = not data.ui
   if data.ui then
      ui.addTextArea(104, '<TI><a href="event:help"><p align="center">Help</p></a>', name, 5, 25, 40, 22, nil, nil, nil, true)
      ui.addTextArea(ERROR_TA, table.concat(_errors), name, 805, 5, 200, 590, nil, nil, 0.5, true)
   else
      ui.removeTextArea(104, name)
      ui.removeTextArea(ERROR_TA, name)
   end
end

MODULE_CHAT_COMMAND = {
   ['help'] = help,

   ['s'] = function(name, cmdl, arg)
      eventChatCommand(name, arg)
   end,

   ['ui'] = function(name, cmdl, arg)
      parsePlayerNames(name, arg, changeUI)
   end,

   ['set'] = function(name, cmdl, arg)
      local iter = string.gmatch(arg, '[^%s]+')
      local vals, exit = parse_arg(iter)
      if type(vals) ~= 'table' then
         alert('Invalid value table: ' .. arg, name)
      else
         copy(_G, vals)
      end
   end,
   ['control'] = function(name, cmdl, arg)
      arg = string.lower(arg)
      arg = string.gsub(arg, '^%l', string.upper)
      playerData[name].cntl = {
         name = arg,
         obj = objcode.anvil,
         off = 48,
         da = 0
      }
   end,

   ['reset'] = function()
      setMap(curMap)
   end,
   ['map'] = function(name, cmdl, arg)
      if arg == '' then
         arg = defaultMap
      end
      setMapXML = true
      setMap(arg)
      curMap = arg
   end,
   ['map2'] = function(name, cmdl, arg)
      if curMapXML == nil then
         alert('curMapXML == nil', name)
         return
      end
      curMap = string.gsub(curMapXML, "/>", arg .. " />", 1)
      setMap(curMap)
   end,

   ['play'] = function(name, cmdl, arg)
      MAPS = split(arg)
      CUR_MAP = 1
      setMap(MAPS[CUR_MAP])
   end,

   ['init'] = function()
      defaultMap = '0'
      curMap = defaultMap
      curMapXML = defaultMapXML
      playerData = {}
      for k, v in pairs(tfm.get.room.playerList) do
         eventNewPlayer(k)
      end
      setMap(curMap)
   end,

   ['dir'] = function(name, cmdl, arg)
      local str = ''
      local status, var = pcall(getfield, arg)
      if status then
         if type(var) == 'table' then
            for k, v in pairs(var) do
               str = str .. k .. '\n'
            end
            showLongString(arg, str, name, 0.8)
         else
            alert(arg .. ' is not a table', name)
         end
      else
         alert(var, name)
      end
   end,
   ['dump'] = function(name, cmdl, arg)
      local status, ret = pcall(call, dump, arg)
      if status then
         showLongString(arg, ret, name, 0.8)
      else
         alert(ret, name)
      end
   end,

   ['do'] = function(name)
      local data = playerData[name]
      data.append = true
      data.newFunction = {}
   end,

   ['end'] = function(name, cmdl)
      local data = playerData[name]
      if cmdl == 'end' then
         data.append = false
         data.lastFunction = data.newFunction
      end
      local status, err
      for _, f in pairs(data.lastFunction) do
         status, err = pcall(call, f[1], f[2])
         if not status then
            alert(err, name)
            break
         end
      end
   end,

   ['undo'] = function(name)
      local data = playerData[name]
      data.append = false
      data.newFunction = {}
   end
}

MODULE_CHAT_COMMAND['redo'] = MODULE_CHAT_COMMAND['end']
MODULE_CHAT_COMMAND['r'] = MODULE_CHAT_COMMAND['reset']
MODULE_CHAT_COMMAND['m'] = MODULE_CHAT_COMMAND['map']

MODULE_CHAT_COMMAND_1 = function(name, cmd, arg)
   local func = getfield(cmd)
   local data = playerData[name]
   if type(func) == 'function' then
      if data.append then
         data.newFunction[#data.newFunction + 1] = {func, arg}
      else
         data.lastFunction = {{func, arg}}
         local status, err = pcall(call, func, arg)
         if not status then
            alert(err, name)
         end
      end
   else
      alert('Invalid command: ' .. cmd, name)
   end
end

system.disableChatCommandDisplay('s', true)
