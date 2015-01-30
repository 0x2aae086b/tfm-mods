function defaultShot(name, data)
   local player = tfm.get.room.playerList[name]
   local x, y = player.x, player.y
   local k
   if player.isFacingRight then
      k = -1
   else
      k = 1
   end

   local a = math.random() * math.pi

   local bdata = {
      x = x + 64 * math.cos(a),
      y = y + 64 * math.sin(a),
      angle = 0,
      R = 16,
      points = 5,
      step = 2,
      line_jdata = { color = randomColor() },
      center_jdata = {{}}
   }

   local mdata = {
      last = true,
      ttl = math.random(1, 4),
      x = x,
      y = y,
      jdata = { speedMotor = 4 * k }
   }

   local id = addBullet(bullet.jstar, bdata, 8)

   a = math.random() * math.pi + math.pi
   bdata.x = x + 64 * math.cos(a)
   bdata.y = y + 64 * math.sin(a)
   bdata.line_jdata.color = randomColor()

   local id1 = addBullet(bullet.jstar, bdata, 8)

   addMotion(motion.circle, id, true, mdata)

   mdata.ttl = math.random(1, 4)
   mdata.jdata.speedMotor = - 4 * k

   addMotion(motion.circle, id1, true, mdata)
end

function homingShot(name, data)
   local target = randomKey1(tfm.get.room.playerList, name, false)
   local player = tfm.get.room.playerList[name]
   local x = player.x
   local y = player.y
   local vx = 2
   local vy = 2
   local g = false

   if not player.isFacingRight then
      vx = -vx
   end

   x = x + 16 * vx

   local args = {
      target = target,
      x = x,
      y = y + 32,
      v = 128
   }

   addObject(objcode.anvil, x + vx, y + vy, 0, vx, vy, g, 10, moveHoming, nil, args)

   local args = {
      target = target,
      x = x,
      y = y - 32,
      v = 128
   }

   addObject(objcode.anvil, x + vx, y - vy, 0, vx, -vy, g, 10, moveHoming, nil, args)
end
