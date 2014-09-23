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
   local id = addBullet(bullet.jstar,
                        8, nil, nil, nil,
                        x + 64 * math.cos(a), y + 64 * math.sin(a),
                        0, 16, 5, 2,
                        {color=randomColor()},
                        nil, nil
   )

   a = math.random() * math.pi + math.pi
   local id1 = addBullet(bullet.jstar,
                        8, nil, nil, nil,
                        x + 64 * math.cos(a), y + 64 * math.sin(a),
                        0, 16, 5, 2,
                        {color=randomColor()},
                        nil, nil
   )

   addMotion(motion.circle, id, true, true, math.random(1, 4), {speedMotor=4*k}, x, y)
   addMotion(motion.circle, id1, true, true, math.random(1, 4), {speedMotor=-4*k}, x, y)
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
