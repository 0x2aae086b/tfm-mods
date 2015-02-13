function testPattern(name, data, id, points)
   local p = points[1]

   local n = 6
   local r = 48
   local v = math.random(2, 8)

   local a, c, s
   local a0 = math.rad(p.angle)

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

   local bdata = {
      angle = 0.25 - math.pi / 2.0,
      R = 16,
      center_jdata = {},
      wing_jdata = { line = 24, alpha = 0.5 },
      hitbox_data = { width = 0, height = 0, color = 0xFFFFFF, mass = 1 }
   }

   local mdata = {
      ttl = 2,
      last = true,
      jdata = {}
   }

   for i = 1, n do
      r = math.random(64, 96)
      a = math.random() * 2.0 * math.pi;
      c, s = math.cos(a), math.sin(a)

      bdata.x = p.x + r * c
      bdata.y = p.y + r * s
      bdata.center_jdata.color = randomColor()
      bdata.wing_jdata.color = randomColor()

      mdata.jdata.speedMotor = math.random(2, 6)
      mdata.jdata.angle = 2 * math.pi - a

      id = addBullet(bullet.butterfly, bdata, 8)
      addMotion(motion.line, id, true, mdata)
   end
end

function testPattern2(name, data, id, points)
   local p = points[1]
   local bdata = {
      x = p.x,
      y = p.y,
      R = 16,
      jdata = {{ color = randomColor(), line = 32 }},
      hitbox_data = { width = 0, height = 0, color = 0xFFFFFF, mass = 1 }
   }
   local mdata = {
      ttl = 16,
      last = true,
      x = p.x,
      y = p.y,
      frequency = 0.25,
      delay = 2,
      delay1 = 0,
      max_step = 1000,
      --no_target = name
   }
   local id = addBullet(bullet.circle, bdata, 16)
   addMotion(motion.follow, id, true, mdata)
end

function testPattern3(name, data, id, points)
   local p = points[1]
   local c = randomColor()
   local ax, a = to_axis(math.rad(-p.angle))
   local bdata = {
      x = p.x,
      y = p.y,
      angle = a,
      R = 36,
      points = math.random(5, 8),
      step = 2,
      line_jdata = { color = c },
      center_jdata = {
         { foreground = false, color = c, line = 76 },
         { color = 0x6A7495, line = 70 }
      },
      hitbox_data = { dynamic = true, miceCollision = false }
   }
   local cb_args = {
      cd = 0,
      btype = bullet.rectangle,
      bttl = 10,
      bdata = {
         x = p.x,
         y = p.y,
         angle = -a,
         width = 128,
         height = 13,
         jdata = {
            { color = randomColor(), foreground = false },
            { color = 0xFFFFFF, line = 16, foreground = true }
         },
         hitbox_data = {
            dynamic = true,
            fixedRotation = true,
            mass = 1
         }
      },
      mtype = motion.line,
      mdata = {
         x = p.x,
         y = p.y,
         ttl = 1,
         last = true,
         free_angle = true,
         jdata = { speedMotor = 8, axis = ax }
      }
   }
   local id = addBullet(bullet.jstar, bdata, 32, shoot_bullet, nil, cb_args)
   addMotion(motion.circle, id, true, { last = true, ttl = 2, jdata = { speedMotor = 4 } })
end
