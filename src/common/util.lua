function nop()
end

function randomColor()
   return math.random(0x000000, 0xFFFFFF)
end

function round(x)
   local ret = math.floor(x)
   if x - ret >= 0.5 then
      ret = ret + 1.0
   end
   return ret
end

function to_table(x)
   if x == nil or type(x) == 'table' then
      return x
   else
      return { x }
   end
end

_axis = {
   '-1,0', '-1,1', '0,1', '1,1',
   '1,0', '1,-1', '0,-1', '-1,-1'
}

_axis_step = math.pi / 4.0

function to_axis(angle)
   local idx = (round(angle / _axis_step) % #_axis)
   return _axis[idx + 1], _axis_step * idx
end

function rotate(x, y, x0, y0, cos, sin)
   x, y = x - x0, y - y0
   x, y = x * cos - y * sin, x * sin + y * cos
   return x0 + x, y0 + y
end

function length1(v)
   return math.sqrt(v.x * v.x + v.y * v.y)
end

function cache2(func)
   local _cache = {}

   return function(x, y)
      local c = _cache[x]
      local ret = nil
      if c == nil then
         c = {}
         _cache[x] = c
      else
         ret = c[y]
      end

      if ret == nil then
         ret = func(x, y)
         c[y] = ret
      end

      return ret
   end
end

function split(str)
   local ret = {}
   for s in string.gmatch(str, '[^%s]+') do
      ret[#ret + 1] = s
   end
   return ret
end

function parsePlayerNames(name, arg, func)
   local players = {}
   local b

   for k, v in ipairs(split(string.lower(arg))) do
      if string.sub(v, 1, 1) == '!' then
         v = string.sub(v, 2)
         b = nil
      else
         b = true
      end

      if v == 'me' then
         players[name] = b
      elseif v == 'all' then
         for k, v in pairs(playerData) do
            players[k] = b
         end
      else
         v = string.gsub(v, '^%l', string.upper)
         if playerData[v] == nil then
            alert('Invalid player: ' .. v, name)
            return
         else
            players[v] = b
         end
      end
   end

   for k, v in pairs(players) do
      func(k)
   end
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

function do_unpack(t, i, n)
   if i <= n then
      return t[i], do_unpack(t, i + 1, n)
   else
      return nil
   end
end

function unpack(t, n)
   if n == nil then
      n = #t
   end
   return do_unpack(t, 1, n)
end

function length(tbl)
   local count = 0
   for _ in pairs(tbl) do
      count = count + 1
   end
   return count
end

function copy(dst, src)
   if src ~= nil then
      for k, v in pairs(src) do
         dst[k] = v
      end
   end
end

function append(dst, src)
   for _, v in ipairs(src) do
      dst[#dst + 1] = v
   end
end

function invert(t, value)
   local ret = {}
   if value == nil then
      for k, v in pairs(t) do
         ret[v] = k
      end
   else
      for k, v in pairs(t) do
         ret[v] = value
      end
   end
   return ret
end

function keys(t)
   local ret = {}
   for k, _ in pairs(t) do
      ret[#ret + 1] = k
   end
   return ret
end

function keys1(t)
   local ret = keys(t)
   table.sort(ret)
   return ret
end

function randomKey1(tbl, excl_key, do_exclude)
   local keys, i = {}, 1

   for k, _ in pairs(tbl) do
      if k ~= excl_key then
         keys[i] = k
         i = i + 1
      end
   end

   if i > 1 then
      return keys[math.random(1,#keys)]
   elseif do_exclude then
      return nil
   else
      return excl_key
   end
end

function randomValue1(tbl, excl_key, do_exclude)
   local k = randomKey1(tbl, excl_key, do_exclude)

   if k ~= nil then
      return tbl[k]
   else
      return nil
   end
end
