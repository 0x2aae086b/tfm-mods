function newId(ids)
   local free = ids.free
   local k, v = pairs(free)(free)
   if k then
      free[k] = nil
      return k
   else
      if ids.max == MAX_ID then
         error(string.format("newId: %s.max == MAX_ID", tbl_name(ids)))
      end
      ids.max = ids.max + 1
      return ids.max
   end
end

function freeId(ids, id)
   local free = ids.free
   if id == ids.max then
      local t = ids.max - 1
      while free[t] do
         free[t] = nil
         t = t - 1
      end
      ids.max = t
   else
      free[id] = true
   end
end

function addObject(type, x, y, angle, vx, vy, ghost, ttl, func, func1, args)
   local id = do_addObject(type, x, y, angle, vx, vy, ghost)

   if ttl == nil then
      ttl = 3
   end

   objectData[id] = {
      time = ttl,
      callback = func,
      on_remove = func1,
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
      callback = func,
      on_remove = func1,
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
      callback = func,
      on_remove = func1,
      callback_args = args
   }

   return id
end

function removeJoint(id)
   do_removeJoint(id)
   jointData[id] = nil
   freeId(jointId, id)
end

function addPattern(name, data, ptype, points)
   local id = nil

   if ptype.time ~= nil then
      id = newId(patternId)

      patternData[id] = {
         time = ptype.time,
         callback = ptype.callback,
         on_remove = ptype.on_remove
      }
   end

   ptype.func(name, data, id, points)

   return id
end

function removePattern(id)
   patternData[id] = nil
   freeId(patternId, id)
end

function addExplosion(x, y, power, distance, miceOnly, particle1, particle2)
   if particle1 ~= nil then
      addParticle(particle1, x, y, 0, 0, 0, 0)
   end

   if particle2 ~= nil then
   end

   do_addExplosion(x, y, power, distance, miceOnly)
end
