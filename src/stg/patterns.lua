function testPattern(name, data, id, points)
   local p = points[1]

   local n = 6
   local r = 48
   local v = math.random(2, 8)

   local a, c, s
   local a0 = p.angle * math.pi / 180.0

   for i = 0, n - 1 do
      a = a0 + 2.0 * math.pi * i / n
      c, s = math.cos(a), math.sin(a)

      addObject(p.type,
                p.x + r * c, p.y + r * s,
                p.angle + 360 * i / n,
                v * c, v * s,
                false,
                9)
   end
end
