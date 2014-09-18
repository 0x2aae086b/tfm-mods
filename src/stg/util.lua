function setColor(name, color)
   setNameColor(name, color)
   playerData[name].color = color
end

function make_line(v0, v1)
   local dx, dy = v1[1] - v0[1], v1[2] - v0[2]

   return {
      width = math.sqrt(dx * dx + dy * dy),
      angle = math.atan2(dy, dx) * 180.0 / math.pi,
      x = (v0[1] + v1[1]) / 2,
      y = (v0[2] + v1[2]) / 2
   }
end

make_star = cache2(
   function(n, s)
      local tmp = {}
      local ret = {}

      for i = 1, n do
         a = math.pi * 2 * i / n
         tmp[#tmp + 1] = { math.cos(a), math.sin(a) }
      end

      for i = 1, n do
         ret[#ret + 1] = make_line(tmp[i], tmp[1 + (i + s - 1) % n])
      end

      return { lines=ret, points=tmp, r=length1(ret[1]) }
   end
)

--[[
function line(x0, y0, x1, y1, width, other)
   local x, y = x1 - x0, y1 - y0

   local obj = {
      type = 12,
      width = math.sqrt(x * x + y * y),
      height = h,
      color = 0xFFFFFF,
      groundCollision = false,
      miceCollision = true,
      angle = math.atan2(y, x) * 180.0 / math.pi,
      restitution = 255,
      dynamic = true
   }

   if other ~= nil then
      copy(obj, other)
   end

   id = id + 1

   tfm.exec.addPhysicObject(id, (x0 + x1) / 2, (y0 + y1) / 2, obj)

   return id
end
]]--
