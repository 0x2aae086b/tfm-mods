_tmp_grounds = {}
_tmp_joints = {}

function addGround1(t, x, y, other)
   local id = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id
   do_addGround(id, x, y, other)
   t[#t + 1] = id
end

function addJoint1(t, id1, id2, other)
   local id = newId(jointId)
   _tmp_joints[#_tmp_joints + 1] = id
   do_addJoint(id, id1, id2, other)
   t[#t + 1] = id
end

function addBullet(btype, bullet_args, ttl, callback, on_remove, args)
   local id = newId(bulletId)

   local st, control, grounds, joints = pcall(btype, bullet_args)

   if st then
      _tmp_grounds = {}
      _tmp_joints = {}
      bulletData[id] = {
         controls = { control },
         grounds = grounds,
         joints = joints,
         time = ttl or 6,
         callback = to_table(callback),
         on_remove = to_table(on_remove),
         callback_args = args
      }
   else
      for _, v in ipairs(_tmp_joints) do
         removeJoint(v)
      end
      for _, v in ipairs(_tmp_grounds) do
         removeGround(v)
      end
      _tmp_grounds = {}
      _tmp_joints = {}
      freeId(bulletId, id)
      error(string.format('addBullet: %s', control))
   end

   return id
end

function removeBullet(id)
   local data = bulletData[id]

   for k, v in ipairs(data.joints) do
      do_removeJoint(v)
      freeId(jointId, v)
   end

   for k, v in ipairs(data.grounds) do
      do_removeGround(v)
      freeId(groundId, v)
   end

   bulletData[id] = nil
   freeId(bulletId, id)
end
