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

function testPattern1(name, data, id, points)
   local p = points[1]
   local n = math.random(8, 16)
   local a, c, s
   local r
   local id

   for i = 1, n do
      r = math.random(0, 32)
      a = math.random() * 2 * math.pi;
      c, s = math.cos(a), math.sin(a)
      id = addBullet(bullet.circle, 8, nil, nil, nil,
                     p.x + r * c, p.y + r * s,
                     {{color=randomColor()}, {line=24, color=0xFFFFFF}}, nil)
      addMotion(motion.line, id, true, true, 2,
                {speedMotor=math.random(2, 8), angle=2*math.pi-a})
   end
end
