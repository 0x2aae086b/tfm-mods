motion = {}

motion.line = function(ac, controls, last, ttl, joint_data, x, y)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 1,
      axis = '-1,0',
      angle = 0,
      forceMotor = 255,
      speedMotor = 1
   }
   copy(joint, joint_data)
   if not last then
      local control = {
         type = 13,
         dynamic = true,
         mass = 1,
         groundCollision = false,
         miceCollision = false,
      }
      id = ac(controls, x or 0, y or 0, control, ttl or 3)
   end
   addJoint(id1, id, joint, ttl or 3)

end

motion.circle = function(ac, controls, last, ttl, joint_data, x, y)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 3,
      forceMotor = 255,
      speedMotor = 1
   }
   copy(joint, joint_data)
   if not last then
      local control = {
         type = 13,
         dynamic = true,
         mass = 1,
         groundCollision = false,
         miceCollision = false,
      }
      id = ac(controls, x or 0, y or 0, control, ttl or 3)
   end
   if x and y then
      joint.point1 = string.format('%d,%d', x, y)
   end
   addJoint(id1, id, joint, ttl or 3)
end
