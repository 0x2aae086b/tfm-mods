function addBombTimer(name, player, data, protect, scale)
   local r = data.bombTime * scale + 2

   local obj = {
      type = 13,
      angle = 0,
      color = 0xFF0000,
      foreground = false,
      friction=0.0,
      restitution=2.0,
      width = r,
      height = r,
      miceCollision = false,
      groundCollision = protect,
      dynamic = false
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
      angle = 0,
      color = 0x6A7495,
      foreground = false,
      friction=0.0,
      restitution=2.0,
      width = r,
      height = r,
      miceCollision = false,
      groundCollision = protect,
      dynamic = false
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

function defaultBombCallback(name, data)
   local player = tfm.get.room.playerList[name]

   local yc = player.y + player.vy
   local xb

   local x, y
   local k = data.bombCallbackArgs

   local ttl = 4

   local vx = 4
   local vy = 0

   local a = { ax = 64, ay = 0 }

   vx = k * vx
   a.ax = k * a.ax
   xb = player.x + k * data.bombTime * 5 + 10

   for off = 20, 120, 20 do
      y = off * k
      x = xb + y * 1.5
      addObject(objcode.anvil, x, yc - y, 0, vx, -vy * k, false, ttl, accelerate, nil, a)
      addObject(objcode.anvil, x, yc + y, 0, vx, vy * k, false, ttl, accelerate, nil, a)
      vy = vy + 1
   end
end

function defaultBomb(name, data)
   local player = tfm.get.room.playerList[name]

   if not player.isFacingRight then
      data.bombCallbackArgs = -1
   else
      data.bombCallbackArgs = 1
   end

   addBombTimer(name, player, data, true, 5)
end

function bomb2(name, data)
   local player = tfm.get.room.playerList[name]

   local x0, y0 = player.x, player.y
   local center = string.format('%d,%d', x0, y0)

   local ground = {
      type = 12,
      color=0xFFFFFF,
      foreground = true,
      width = 512,
      height = 8,
      dynamic = true,
      mass = 8,
      restitution = 255,
      linearDamping = 0,
      angularDamping = 0,
      groundCollision = false,
      miceCollision = true
   }
   local ground1 = {
      type = 13,
      color = 0xFFFFFF,
      width = 32,
      height = 32,
      dynamic = false,
      groundCollision = false,
      miceCollision = false,
      foreground = true
   }

   local joint = {
      type = 3,
      point1 = center,
      point2 = nil,
      forceMotor = 255,
      speedMotor = 2
   }
   local joint1 = {
      type = 3,
      point1 = center,
      point2 = center,
      ratio = 1,
      limit1 = 0,
      limit2 = 8
   }
   local joint2 = {
      type = 0,
      frequency = 10
   }

   local angle
   local a
   local x1, y1
   local x, y
   local off = 32.0 + ground.width / 2.0
   local ttl = 20
   local first = nil
   local prev = nil
   local id, id1

   addBombTimer(name, player, data, true, 5)

   id1 = addGround(x0, y0, ground1, ttl)

   for angle = 0, 359, 120 do
      a = math.rad(angle)

      x1, y1 = math.cos(a), math.sin(a)
      x, y = x0 + off * x1, y0 + off * y1

      ground.angle = angle

      id = addGround(x, y, ground, ttl)

      addJoint(id, id1, joint, ttl)

      if prev ~= nil then
         addJoint(id, prev, joint1, ttl)
         addJoint(id, prev, joint2, ttl)
      else
         first = id
      end

      prev = id
   end

   addJoint(first, id, joint1, ttl)
   addJoint(first, id, joint2, ttl)
end

function bomb3(name, data)
   local player = tfm.get.room.playerList[name]

   local x0, y0 = player.x, player.y
   local center = string.format('%d,%d', x0, y0)

   local ground = {
      type = 13,
      color = 0xFFFFFF,
      width = 64,
      height = 64,
      dynamic = true,
      mass = 1,
      linearDamping = 0,
      angularDamping = 0,
      groundCollision = false,
      miceCollision = false,
      foreground = true
   }

   local joint = {
      type = 1,
      axis = '-1,0',
      forceMotor = 255,
      speedMotor = 2,
      limit1 = 0,
      limit2 = 5
   }

   local angle
   local a
   local x, y
   local x1, y1
   local off = 64.0 + ground.width
   local ttl = 5
   local id
   local args

   addBombTimer(name, player, data, true, 10)

   local offset = {
      [0] = 0.15,
      [60] = 0.13,
      [120] = 0.11,
      [180] = 0.075,
      [240] = 0.05,
      [300] = 0
   }

   for angle = 0, 359, 60 do
      a = math.rad(angle)

      x1, y1 = math.cos(a), math.sin(a)
      x, y = x0 + off * x1, y0 + off * y1

      args = {
         x = x0 + math.cos(a + offset[angle]) * 280,
         y = y0 + math.sin(a + offset[angle]) * 280,
         power = 127,
         distance = 3 * ground.width,
         miceOnly = false,
         p1 = particles.red_spirit,
         p2 = nil
      }

      id = addGround(x, y, ground, ttl, nil, explode, args)

      joint.angle = 2.0 * math.pi - a
      addJoint(id, 0, joint, ttl)
   end
end
