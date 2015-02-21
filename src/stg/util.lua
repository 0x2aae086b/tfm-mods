function setColor(name, color)
   setNameColor(name, color)
   playerData[name].color = color
end

function tbl_name(t)
   if t == groundId then
      return 'groundId'
   elseif t == jointId then
      return 'jointId'
   elseif t == bulletId then
      return 'bulletId'
   elseif t == patternId then
      return 'patternId'
   elseif t == _timerId then
      return '_timerId'
   elseif t == objectData then
      return 'objectData'
   elseif t == groundData then
      return 'groundData'
   elseif t == jointData then
      return 'jointData'
   elseif t == bulletData then
      return 'bulletData'
   elseif t == patternData then
      return 'patternData'
   elseif t == _timerData then
      return '_timerData'
   end
   return '&lt;other&gt;'
end

function make_line(v0, v1)
   local dx, dy = v1[1] - v0[1], v1[2] - v0[2]

   return {
      width = math.sqrt(dx * dx + dy * dy),
      angle = math.deg(math.atan2(dy, dx)),
      x = (v0[1] + v1[1]) / 2,
      y = (v0[2] + v1[2]) / 2
   }
end

make_star = cache2(
   function(n, s)
      local tmp = {}
      local ret = {}
      local i

      for i = 1, n do
         a = math.pi * 2.0 * i / n
         tmp[#tmp + 1] = { math.cos(a), math.sin(a) }
      end

      for i = 1, n do
         ret[#ret + 1] = make_line(tmp[i], tmp[1 + (i + s - 1) % n])
      end

      local r = length1(ret[1])

      return { lines=ret, points=tmp, r=r, l=math.sqrt(1 - r*r) }
   end
)

function make_laser(ltype, x, y, x1, y1, step, k, n_step, line, colors)
   local ret = {{}}

   local angle = math.atan2(y1 - y, x1 - x)
   local c, s = math.cos(angle), math.sin(angle)

   local dx, dy = 0, 0
   local dx1, dy1
   local dx2, dy2
   local j = 2
   local i

   if ltype == 0 then
      ltype = 2
      for i = 1, n_step do
         dy = dy + step
         dx = dy * dy * k
         dx2, dy2 = -dy * s, dy * c
         dx1, dy1 = dx * c + dx2, dx * s + dy2
         ret[j] = {
            point1 = string.format("%d,%d", x + dx1, y + dy1),
            point2 = string.format("%d,%d", x1 + dx2, y1 + dy2)
         }
         j = j + 1
         dx1, dy1 = dx * c - dx2, dx * s - dy2
         ret[j] = {
            point1 = string.format("%d,%d", x + dx1, y + dy1),
            point2 = string.format("%d,%d", x1 - dx2, y1 - dy2)
         }
         j = j + 1
      end
   elseif ltype == 1 then
      ltype = 2
      for i = 1, n_step do
         dy = dy + step
         dx2, dy2 = -dy * s, dy * c
         ret[j] = { point2 = string.format("%d,%d", x1 + dx2, y1 + dy2) }
         j = j + 1
         ret[j] = { point2 = string.format("%d,%d", x1 - dx2, y1 - dy2) }
         j = j + 1
      end
   else
      ltype = 1
      line = line or 50
      dx = step * k
      for i = 1, n_step do
         line = line + step
         dx2, dy2 = dx * c, dx * s
         ret[j] = {
            point1 = string.format("%d,%d", x + dx2, y + dy2),
            line = line
         }
         j = j + 1
         dx = dx * 2
      end
   end

   if colors then
      j = 0
      for i = 2, #ret do
         if i % ltype == 0 then
            j = j + 1
         end
         ret[i].color = colors[j]
      end
   end

   return ret
end
