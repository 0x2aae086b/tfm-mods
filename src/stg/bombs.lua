function addBombTimer(name, player, data, scale)
   local r = data.bombTime * scale + 2

   local obj = {
      type = 13,
      color = 0xFF0000,
      foreground = false,
      width = r,
      height = r,
      miceCollision = false
   }

   addGround(
      player.x,
      player.y,
      obj,
      data.bombTime,
      moveBombTimer,
      nil,
      {
         player = name,
         pdata = data,
         offset = 2,
         scale = scale,
         obj = obj
      }
   )

   r = r - 2

   obj = {
      type = 13,
      color = 0x6A7495,
      foreground = false,
      width = r,
      height = r,
      miceCollision = false
   }

   addGround(
      player.x,
      player.y,
      obj,
      data.bombTime,
      moveBombTimer,
      nil,
      {
         player = name,
         pdata = data,
         offset = 0,
         scale = scale,
         obj = obj
      }
   )
end

function moveBombTimer(id, data)
   local a = data.callback_args
   local player = tfm.get.room.playerList[a.player]
   local sz = a.pdata.bombTime * a.scale + a.offset

   a.obj.width = sz
   a.obj.height = sz

   do_addGround(id, player.x, player.y, a.obj)
end

---------------------------------------------------------------------------

function bomb1(name, data)
   local ttl = 20
   local width = 512
   local off = 32.0

   local player = tfm.get.room.playerList[name]
   local x0, y0 = player.x, player.y
   local center = string.format("%d,%d", x0, y0)

   local colors = { 0x00FF00, 0x00FFFF, 0x0000FF }
   local cdata = {
      x = x0,
      y = y0,
      R = 32,
      hitbox_data = { miceCollision = false, mass = 2, angularDamping = 1 }
   }
   local bdata = {
      width = width,
      height = 16,
      hitbox_data = { mass = 2, linearDamping = 0.5 }
   }
   local mdata = {
      last = true,
      ttl = ttl,
      jdata = { speedMotor = 255 }
   }

   addBombTimer(name, player, data, 5)

   local id0 = addBullet(bullet.circle, cdata, ttl)
   local id00 = id0
   id0 = bulletData[id0].controls
   id0 = id0[#id0]

   local joint = {
      type = 3,
      point1 = center,
      point2 = center,
      ratio = 1,
      limit1 = 0,
      limit2 = 0
   }
   local joint1 = {
      type = 0,
      frequency = 32
   }

   local a
   local x, y
   local x1, y1
   local first, prev
   local jdata
   local i

   for i = 1, 3 do
      a = math.pi * i * 2.0 / 3.0

      x, y = math.cos(a), math.sin(a)
      x1, y1 = x0 + (off + width) * x, y0 + (off + width) * y
      x, y = x0 + off * x, y0 + off * y

      jdata = make_laser(0, x, y, x1, y1, 5, 0.1, 2, 20)
      jdata[1] = {
         point1 = string.format("%d,%d", x, y),
         point2 = string.format("%d,%d", x1, y1),
         color = colors[i],
         alpha = 0.25,
         line = 20,
         foreground = true
      }

      bdata.angle = a
      bdata.x = x
      bdata.y = y
      bdata.jdata = jdata

      id = addBullet(bullet.rectangle, bdata, ttl)
      id = bulletData[id].controls
      id = id[#id]

      addJoint(id, id0, joint, ttl)

      if prev then
         addJoint(id, prev, joint1, ttl)
      else
         first = id
      end

      prev = id
   end

   addJoint(prev, first, joint1, ttl)

   addMotion(motion.circle, id00, true, mdata)
end

function bomb2Callback(id, data)
   local a = data.callback_args

   if a.delay == 1 then
      local mdata = {
         last = true,
         ttl = a.ttl,
         x = a.x,
         y = a.y,
         no_target = a.no_target,
         delay = 0,
         delay1 = 0,
         frequency = 0.5,
         max_step = 500
      }
      addMotion(motion.follow, id, true, mdata)
      a.delay = 0
   else
      a.delay = a.delay - 1
   end
end

function bomb2(name, data)
   local ttl = 20
   local off = 96.0

   local player = tfm.get.room.playerList[name]
   local x0, y0 = player.x, player.y

   local bdata = {
      R = 48,
      jdata = {{ foreground = false, line = 128 }},
      hitbox_data = { color = 0xFFFFFF }
   }

   local mdata = {
      ttl = 2,
      last = true,
      jdata = { speedMotor = 3, color = 0xFFFFFF }
   }

   local a
   local x, y
   local id
   local args
   local i

   addBombTimer(name, player, data, 5)

   for i = 1, #_axis do
      a = (1 - i) * _axis_step

      x, y = math.cos(a), math.sin(a)

      bdata.x = x0 + off * x
      bdata.y = y0 + off * y
      bdata.jdata[1].color = randomColor()

      mdata.jdata.axis = _axis[i]
      mdata.jdata.speedMotor = 5 - mdata.jdata.speedMotor

      args = {
         delay = 2,
         ttl = ttl - 2,
         x = x0 + 150 * x,
         y = y0 + 150 * y,
         -- no_target = name
      }

      id = addBullet(bullet.circle, bdata, ttl, bomb2Callback, nil, args)
      addMotion(motion.line, id, true, mdata)
   end
end
