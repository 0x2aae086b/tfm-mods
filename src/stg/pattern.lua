function pattern(name, data, btype, bcode, point)
   local pat = data.patterns[btype][bcode]

   if pat ~= nil then
      local l = #pat.points + 1
      if l >= pat.type.points then
         local time = os.time()
         if time - pat.lastTime >= pat.type.cd then
            pat.lastTime = time
            pat.points[l] = point
            local st, err = pcall(addPattern, name, data, pat.type, pat.points)
            pat.points = {}
            if not st then
               addError(string.format("pattern: %s: %s", name, err))
            end
         end
      else
         pat.points[l] = point
      end
   end
end

function bind(name, btype, bcode, pid)
   local data = playerData[name]
   local p = data.patterns[btype]

   if p[bcode] ~= nil then
      do_unbind(data, p[bcode], btype, bcode)
   end

   p[bcode] = {
      id = pid,
      type = patternTypes[pid],
      points = {},
      lastTime = 0
   }

   p = data.pattern_data[pid]

   if btype == 'key' then
      bindKey(name, bcode, true, true)
   end

   if p == nil then
      data.pattern_data[pid] = {
         binds = 1
      }
   else
      p.binds = p.binds + 1
   end
end

function do_unbind(data, p, btype, bcode)
   local pdata = data.pattern_data[p.id]
   if pdata.binds <= 1 then
      data.pattern_data[p.id] = nil
   else
      pdata.binds = pdata.binds - 1
   end
   data.patterns[btype][bcode] = nil
end

function unbind(name, btype, bcode)
   local data = playerData[name]
   if btype == nil then
      data.patterns = {
         key = {},
         obj = {},
         objend = {}
      }
      data.pattern_data = {}
   elseif bcode == nil then
      local u = {}

      for k, v in pairs(data.patterns[btype]) do
         u[#u + 1] = { k, v }
      end

      for k, v in ipairs(u) do
         do_unbind(data, v[2], btype, v[1])
      end
   else
      local p = data.patterns[btype][bcode]
      if p ~= nil then
         do_unbind(data, p, btype, bcode)
      end
   end
end

function addPattern(name, data, ptype, points)
   local id = nil

   if ptype.time ~= nil then
      id = newId(patternId)

      patternData[id] = {
         time = ptype.time,
         callback = ptype.callback,
         on_remove = ptype.on_remove
      }
   end

   ptype.func(name, data, id, points)

   return id
end

function removePattern(id)
   patternData[id] = nil
   freeId(patternId, id)
end
