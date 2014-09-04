function defaultShot(name, data)
   local player = tfm.get.room.playerList[name]
   local x, y = player.x, player.y
   local k
   if player.isFacingRight then
      k = '-1,0'
      x = x + 32
   else
      k = '1,0'
      x = x - 32
   end
   local id = addGround(x, y + 32, {type=13, width=8, height=8, restitution=255, mass=10, dynamic=true, miceCollision=true, groundCollision=false, color='0xFFFFFF', foreground=true}, 6)
   addJoint(id, 0, {color='0x00FFFF', line=2, type=1, axis=k, forceMotor=100, speedMotor=100}, 6)
   id = addGround(x, y - 32, {type=13, width=8, height=8, restitution=255, mass=10, dynamic=true, miceCollision=true, groundCollision=false, color='0xFFFFFF', foreground=true}, 6)
   addJoint(id, 0, {color='0x00FFFF', line=2, type=1, axis=k, forceMotor=100, speedMotor=100}, 6)
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
