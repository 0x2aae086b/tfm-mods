function addObject(type, x, y, angle, vx, vy, ghost, ttl, func, func1, args)
   local id = do_addObject(type, x, y, angle, vx, vy, ghost)

   if ttl == nil then
      ttl = 3
   end

   objectData[id] = {
      time = ttl,
      callback = to_table(func),
      on_remove = to_table(func1),
      callback_args = args
   }

   return id
end

function removeObject(id)
   do_removeObject(id)
   objectData[id] = nil
end

function addGround(x, y, other, ttl, func, func1, args)
   local id = newId(groundId)

   do_addGround(id, x, y, other)

   if ttl == nil then
      ttl = 3
   end

   groundData[id] = {
      time = ttl,
      callback = to_table(func),
      on_remove = to_table(func1),
      callback_args = args,
   }

   return id
end

function removeGround(id)
   do_removeGround(id)
   groundData[id] = nil
   freeId(groundId, id)
end

function addJoint(ground0, ground1, other, ttl, func, func1, args)
   local id = newId(jointId)

   do_addJoint(id, ground0, ground1, other)

   if ttl == nil then
      ttl = -1
   end

   if other == nil then
      other = {}
   end

   jointData[id] = {
      time = ttl,
      callback = to_table(func),
      on_remove = to_table(func1),
      callback_args = args
   }

   return id
end

function removeJoint(id)
   do_removeJoint(id)
   jointData[id] = nil
   freeId(jointId, id)
end

function addExplosion(x, y, power, distance, miceOnly, particle1, particle2)
   if particle1 ~= nil then
      addParticle(particle1, x, y, 0, 0, 0, 0)
   end

   if particle2 ~= nil then
   end

   do_addExplosion(x, y, power, distance, miceOnly)
end
