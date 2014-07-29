--[[
   This program is free software. It comes without any warranty, to
   the extent permitted by applicable law. You can redistribute it
   and/or modify it under the terms of the Do What The Fuck You Want
   To Public License, Version 2, as published by Sam Hocevar. See
   the COPYING file for more details.
]]--

defaultMap = '0'

addObject = tfm.exec.addShamanObject
removeObject = tfm.exec.removeObject
movePlayer = tfm.exec.movePlayer
setMap = tfm.exec.newGame
bindKey = tfm.exec.bindKeyboard
respawn = tfm.exec.respawnPlayer
kill = tfm.exec.killPlayer

----------------------------------------------------------------

MODULE_HELP_START = 'Commands'

MODULE_HELP_CONTENTS = [[<font face="mono" size="15"><a href="event:Commands">Commands</a></font>
]]

MODULE_HELP = {
      ['Commands'] = [[<font face="mono" size="15">!help

!clear

!reset
    tfm.exec.newGame(defaultMap)

!map
    tfm.exec.newGame()

!dir &lt;variable&gt;

!dump &lt;value&gt;

!&lt;function&gt; [&lt;values&gt;]

!do

!end

!redo

!undo
</font>
]]
}

CLOSE='<TI><p align="center"><a href="event:close">X</a></p>'

function help(name)
   ui.addTextArea(100, MODULE_HELP[MODULE_HELP_START], name, 258, 78, 421, 284)
   ui.addTextArea(101, string.format('<p align="center"><font face="mono" size="15">%s</font></p>', MODULE_HELP_START), name, 258, 50, 398, 20)
   ui.addTextArea(102, MODULE_HELP_CONTENTS, name, 100, 50, 150, 312)
   ui.addTextArea(103, CLOSE, name, 664, 50, 15, 20)
end

----------------------------------------------------------------

function showLongString(title, str, name, alpha)
   local p = math.ceil(#str / 2000)

   if alpha == nil then
      alpha = 1
   end

   playerData[name].longString = {
      id = 110,
      str = str,
      page = 0,
      maxPage = p - 1
   }

   ui.addTextArea(110, string.sub(str, 1, 2000), name, 100, 80, 579, 284, nil, nil, alpha)
   ui.addTextArea(111, string.format('<p align="center"><font face="mono" size="15">%s</font></p>', title), name, 100, 50, 400, 22, nil, nil, alpha)
   ui.addTextArea(112, string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> 1/%d <a href="event:next">&gt;</a></font></p>', p), name, 508, 50, 148, 22, nil, nil, alpha)
   ui.addTextArea(113, CLOSE, name, 664, 50, 15, 22, nil, nil, alpha)
end

function updateLongString(name, ls)
   ui.updateTextArea(ls.id, string.sub(ls.str, ls.page * 2000 + 1, (ls.page + 1) * 2000), name)
   ui.updateTextArea(ls.id + 2, string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>', ls.page + 1, ls.maxPage + 1), name)
end

----------------------------------------------------------------

function getfield(var, err)
   local v = _G
   for w in string.gmatch(var, '[%w_]+') do
      if type(v) ~= 'table' then
         if err then
            error('Invalid field: ' .. var)
         else
            return nil
         end
      end
      v = v[w]
   end
   return v
end

dump_func = {
   ['function'] = function(...)
      return '&lt;function&gt;'
   end,
   ['userdata'] = function(...)
      return '&lt;userdata&gt;'
   end,
   ['thread'] = function(...)
      return '&lt;thread&gt;'
   end,

   ['nil'] = function(...)
      return 'nil'
   end,

   ['number'] = function(var, ...)
      return var
   end,

   ['boolean'] = function(var, ...)
      return tostring(var)
   end,

   ['string'] = function(var, ...)
      for k, v in ipairs({{'&', '&amp;'}, {'<', '&lt;'}, {'>', '&gt;'}}) do
         var = string.gsub(var, v[1], v[2])
      end
      return string.format('%q', var)
   end,

   ['table'] = function(var, off)
      if off == nil then
         off = ''
      end

      local ret = { "{\n" }
      local off1 = off .. ' '

      for k, v in pairs(var) do
         table.insert(ret, off1 .. '[')
         table.insert(ret, dump_func[type(k)](k, off1))
         table.insert(ret, '] = ')
         table.insert(ret, dump_func[type(v)](v, off1))
         table.insert(ret, ",\n")
      end

      local i = #ret
      if i > 1 then
         ret[i] = "\n"
      end

      table.insert(ret, off .. '}')

      return table.concat(ret)
   end
}

function dump(var)
   return dump_func[type(var)](var)
end

----------------------------------------------------------------

function do_unpack(t, i)
   if t[i] ~= nil then
      return t[i], do_unpack(t, i + 1)
   else
      return nil
   end
end

function unpack(t)
   return do_unpack(t, 1)
end

unescape_map = {
   a = '\a', b = '\b', f='\f', n = '\n', r = '\r', t = '\t'
}

function do_unescape(c, n)
   local num = tonumber(c .. n)
   if num == nil then
      return (unescape_map[c] or c) .. n
   else
      return string.char(num)
   end
end

function unescape(str)
   return string.gsub(str, '\\(.)(%d?%d?)', do_unescape)
end

function do_parse_arg(str, iter)
   if str == 'true' then
      return true
   elseif str == 'false' then
      return false
   elseif str == 'nil' then
      return nil
   elseif str == '{' then
      return parse_arg(iter, str)
   else
      local tmp = string.sub(str, 1, 1)
      if tmp == '"' or tmp == "'" then
         return unescape(string.sub(str, 2, -2))
      else
         tmp = tonumber(str)
         if tmp ~= nil then
            return tmp
         else
            return getfield(str, true)
         end
      end
   end
end

function do_parse_key(str)
   local tmp

   while true do
      if str == 'true' then
         return true
      elseif str == 'false' then
         return false
      else
         local tmp = string.sub(str, 1, 1)
         if tmp == '"' or tmp == "'" then
            return unescape(string.sub(str, 2, -2))
         elseif tmp == '[' then
            str = string.sub(str, 2, -2)
         else
            tmp = tonumber(str)
            if tmp ~= nil then
               return tmp
            else
               return unescape(str)
            end
         end
      end
   end
end

function parse_arg(iter, str)
   local ret
   local s1, s2

   if str == nil then
      str = iter()
   end

   if str == nil then
      return nil, true
   elseif str == '{' then
      ret = {}
      str = iter()
      while str ~= nil and str ~= '}' do
         s1, s2 = string.gmatch(str, '(.+)=(.+)')()
         if s1 == nil then
            ret[#ret + 1] = do_parse_arg(str, iter)
         else
            ret[do_parse_key(s1)] = do_parse_arg(s2, iter)
         end
         str = iter()
      end
      return ret, str == nil
   else
      return do_parse_arg(str), false
   end
end

function call(func, args_s, get)
   local args = {}
   local iter = string.gmatch(args_s, '[^%s]+')

   local arg, exit = parse_arg(iter)

   while not exit do
      table.insert(args, arg)
      arg, exit = parse_arg(iter)
   end

   if get then
      return { func, args }
   else
      return func(unpack(args))
   end
end

----------------------------------------------------------------

function alert(str, name)
   ui.addPopup(0, 0, string.format('<font face="mono" size="15">%s</font>', str), name, 200, 150, 400)
end

function clear()
   local ids={}

   for i, object in pairs(tfm.get.room.objectList) do
      table.insert(ids, i)
   end

   for k, v in ipairs(ids) do
      removeObject(v)
   end
end

----------------------------------------------------------------

playerData = {}

function eventNewPlayer(name)
   playerData[name] = {
      lastFunction = {},
      newFunction = {},
      append = false
   }
   ui.addTextArea(104, '<TI><a href="event:help">?</a>', name, 5, 25, 10, 20)
   --tfm.exec.setShaman(name)
   respawn(name)
end

function eventPlayerLeft(name)
   playerData[name] = nil
end

function eventChatCommand(name, message)
   local i
   local j
   local cmd
   local arg
   local status, err
   local data = playerData[name]

   while true do
      i, j = string.find(message, "%s+")

      if i == nil then
         cmd = message
         arg = ""
         break
      elseif i == 1 then
         message = string.sub(message, j + 1)
         if message == "" then
            cmd = ""
            arg = ""
            break
         end
      else
         cmd = string.sub(message, 1, i - 1)
         arg = string.sub(message, j + 1)
         break
      end
   end

   local cmdl = string.lower(cmd)

   if cmdl == 'help' then
      help(name)
   elseif cmdl == 'clear' then
      clear()
   elseif cmdl == 'reset' then
      setMap(defaultMap)
   elseif cmdl == 'map' then
      setMap(arg)
   elseif cmdl == 'dir' then
      local str = string.format('<font face="mono" size="15">', arg)
      local var = getfield(arg)
      if var ~= nil then
         for k, v in pairs(var) do
            str = str .. k .. "\n"
         end
         showLongString(arg, str .. '</font>', name, 0.6)
      end
   elseif cmdl == 'dump' then
      local status, ret = pcall(call, dump, arg)
      if not status then
         alert(ret, name)
      else
         showLongString(arg, string.format('<font face="mono" size="15">%s</font>', ret), name, 0.6)
      end
   elseif cmdl == 'do' then
      data.append = true
      data.newFunction = {}
   elseif cmdl == 'end' or cmdl == 'redo' then
      if cmdl == 'end' then
         data.append = false
         data.lastFunction = data.newFunction
      end
      for _, f in pairs(data.lastFunction) do
         status, err = pcall(call, f[1], f[2])
         if not status then
            alert(err, name)
            break
         end
      end
   elseif cmdl == 'undo' then
      data.append = false
      data.newFunction = {}
   else
      local func = getfield(cmd)
      if type(func) == 'function' then
         if data.append then
            table.insert(data.newFunction, {func, arg})
         else
            data.lastFunction = {{func, arg}}
            status, err = pcall(call, func, arg)
            if not status then
               alert(err, name)
            end
         end
      else
         alert('Invalid command: ' .. cmd, name)
      end
   end
end

function eventNewGame()
   tfm.exec.disableAfkDeath(true)
   tfm.exec.disableAutoNewGame(true)
   tfm.exec.disableAutoScore(true)
   tfm.exec.setGameTime(0)
end

function eventPlayerDied(name)
   respawn(name)
end

function eventPlayerWon(name)
   respawn(name)
end

function eventTextAreaCallback(id, name, callback)
   if callback == 'help' then
      help(name)
   elseif callback == 'next' then
      local ls = playerData[name].longString
      local p = ls.page
      if p < ls.maxPage then
         ls.page = p + 1
      end
      updateLongString(name, ls)
   elseif callback == 'prev' then
      local ls = playerData[name].longString
      local p = ls.page
      if p > 0 then
         ls.page = p - 1
      end
      updateLongString(name, ls)
   elseif callback == 'close' then
      ui.removeTextArea(id - 3, name)
      ui.removeTextArea(id - 2, name)
      ui.removeTextArea(id - 1, name)
      ui.removeTextArea(id, name)
      if id ~= 103 then
         playerData[name].longString = nil
      end
   else
      local str = MODULE_HELP[callback]
      if str ~= nil then
         ui.updateTextArea(100, str, name)
         ui.updateTextArea(101, string.format('<TI><p align="center">%s</p>', callback), name)
      end
   end
end

----------------------------------------------------------------

for k, v in pairs(tfm.get.room.playerList) do
   eventNewPlayer(k)
end

setMap(defaultMap)
