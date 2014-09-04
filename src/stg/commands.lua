MODULE_CHAT_COMMAND = {
   ['help'] = help,
   ['clear'] = clear,

   ['color'] = function(name, cmdl, arg)
      arg = string.upper(arg)
      if arg == '' or arg == 'RANDOM' or arg == 'RND' then
         setColor(name, randomColor())
         playerConfig[name].color = nil
      else
         local argv = tonumber(arg)
         if argv ~= nil then
            if argv > 0xFFFFFF then
               argv = 0xFFFFFF
            end
            setColor(name, arg)
            playerConfig[name].color = arg
         else
            alert('Invalid color: ' .. arg, name)
         end
      end
   end,

   ['reset'] = function(name, cmdl, arg)
      arg = string.lower(arg)
      if arg == '' or arg == 'map' then
         setMap(defaultMap)
      else
         parsePlayerNames(name, arg, resetPlayer)
      end
   end,

   ['init'] = function(name, cmdl, arg)
      local f = function(name)
         deletePlayer(name)
         initPlayer(name)
      end
      parsePlayerNames(name, arg, f)
   end,

   ['respawn'] = function(name, cmdl, arg)
      parsePlayerNames(name, arg, respawn)
   end,

   ['shot'] = function(name, cmdl, arg)
      local n = tonumber(arg)

      if n == nil then
         alert('Invalid shot type: ' .. arg, name)
         return
      end

      n = shotTypes[n]

      if n ~= nil then
         playerData[name].shot = n
      else
         alert('Invalid shot type: ' .. arg, name)
      end
   end,

   ['bomb'] = function(name, cmdl, arg)
      local n = tonumber(arg)

      if n == nil then
         alert('Invalid bomb type: ' .. arg, name)
         return
      end

      n = bombTypes[n]

      if n ~= nil then
         playerData[name].bomb = n
      else
         alert('Invalid bomb type: ' .. arg, name)
      end
   end,

   ['bind'] = function(name, cmdl, arg)
      arg = split(arg)

      if #arg < 3 then
         alert('Too few arguments', name)
         return
      elseif #arg > 3 then
         alert('Too many arguments', name)
         return
      end

      i = tonumber(arg[1])
      local p = patternTypes[i]
      if i == nil or p == nil then
         alert('Invalid pattern: ' .. arg[1], name)
         return
      end

      j = arg[2]
      if j ~= 'key' and j ~= 'obj' and j ~= 'objend' then
         alert('Invalid event: ' .. j, name)
         return
      end

      local k = tonumber(arg[3])
      if k == nil then
         k = eventCode[j][arg[3]]
         if k == nil then
            alert(string.format('Invalid %s name/code: %s', j, arg[3]), name)
            return
         end
      end

      if p.restrict[j] ~= nil and p.restrict[j][k] == nil then
         alert(string.format('Can\'t bind pattern %d to %s %d: restricted',
                             i, j, k),
               name
         )
         return
      end

      if j == 'key' and reservedKeys[k] then
         alert(string.format('Can\'t bind pattern %d to %s %d: reserved',
                             i, j, k),
               name
         )
         return
      end

      local data = playerData[name]
      local pd = data.pattern_data[i]

      if pd ~= nil and p.maxBinds <= pd.binds then
         alert(string.format('Can\'t bind pattern %d to more than %d events',
                             i, p.maxBinds),
               name
         )
         return
      end

      bind(name, j, k, i)
   end,

   ['unbind'] = function(name, cmdl, arg)
      arg = split(arg)
      if #arg > 2 then
         alert('Too many arguments', name)
         return
      end

      i = arg[1]
      if i == 'all' or i == nil then
         unbind(name)
      elseif i ~= 'key' and i ~= 'obj' and i ~= 'objend' then
         alert('Invalid event: ' .. i, name)
         return
      else
         if arg[2] == nil then
            unbind(name, i)
         else
            j = tonumber(arg[2])
            if j == nil then
               j = eventCode[i][arg[2]]
               if j == nil then
                  alert(string.format('Invalid %s name/code: %s', i, arg[2]), name)
                  return
               end
            end
            unbind(name, i, j)
         end
      end
   end,

   ['map'] = function(name, cmdl, arg)
      if arg == '' then
         arg = defaultMap
      end

      setMap(arg)
   end
}

MODULE_CHAT_COMMAND_1 = function(name, cmd, arg)
   alert('Invalid command: ' .. cmd, name)
end
