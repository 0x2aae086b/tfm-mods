function addGround1(t, x, y, other)
   local id = newId(groundId)
   do_addGround(id, x, y, other)
   t[#t + 1] = id
end

function addJoint1(t, id1, id2, other)
   local id = newId(jointId)
   do_addJoint(id, id1, id2, other)
   t[#t + 1] = id
end

function do_addControl(controls, control)
   controls[#controls + 1] = control
end

function do_removeControl(controls, control)
   local i = #controls
   while i > 0 and controls[i] ~= control do
      controls[i] = nil
      i = i - 1
   end
   --[[if i > 0 then
      while controls[i] do
         controls[i] = nil
         i = i + 1
      end
   end]]--
end

function addBullet(btype, ttl, callback, on_remove, args, ...)
   local id = newId(bulletId)

   local control, grounds, joints = btype(...)

   bulletData[id] = {
      controls = { control },
      grounds = grounds,
      joints = joints,
      time = ttl or 6,
      callback = callback,
      on_remove = on_remove,
      callback_args = args
   }

   return id
end

function removeBullet(id)
   local data = bulletData[id]

   for k, v in ipairs(data.grounds) do
      do_removeGround(v)
      freeId(groundId, v)
   end

   for k, v in ipairs(data.joints) do
      do_removeJoint(v)
      freeId(jointId, v)
   end

   bulletData[id] = nil
   freeId(bulletId, id)
end
