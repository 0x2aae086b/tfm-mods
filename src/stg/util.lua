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
