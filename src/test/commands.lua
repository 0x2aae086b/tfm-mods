MODULE_CHAT_COMMAND = {
   ['help'] = help,

   ['reset'] = function()
      setMap(curMap)
   end,
   ['map'] = function(name, cmdl, arg)
      setMap(arg)
	  curMap = arg
   end,

   ['init'] = function()
      defaultMap = '0'
      curMap = defaultMap
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
