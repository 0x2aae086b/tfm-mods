motion = {}

motion.fix = function(ac, controls, args)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 0,
      frequency = 10
   }
   copy(joint, args.jdata)
   if not args.last then
      id = ac(controls, args.x or 0, args.y or 0, CONTROL, args.ttl or 3)
   end
   addJoint(id1, id, joint, args.ttl or 3)
end

motion.line = function(ac, controls, args) -- limit = px / 30
   local x = args.x or 0
   local y = args.y or 0
   local ttl = args.ttl or 3
   local id = 0
   local id1
   local joint = {
      type = 1,
      axis = '-1,0',
      angle = 0,
      forceMotor = 255,
      speedMotor = 1
   }

   copy(joint, args.jdata)

   if args.free_angle then
      motion.fix(ac, controls, { ttl = ttl, x = x, y = y })
   end

   id1 = controls[#controls]

   if not args.last then
      id = ac(controls, x, y, CONTROL, ttl)
   end

   addJoint(id1, id, joint, ttl)
end

motion.circle = function(ac, controls, args)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 3,
      forceMotor = 255,
      speedMotor = 1
   }
   copy(joint, args.jdata)
   if not args.last then
      id = ac(controls, args.x or 0, args.y or 0, CONTROL, args.ttl or 3)
   end
   if args.x and args.y then
      joint.point1 = string.format('%d,%d', args.x, args.y)
   end
   addJoint(id1, id, joint, args.ttl or 3)
end

motion.spiral = function(ac, controls, args)
   local last = args.last

   args.last = false
   args.jdata = args.tjoint
   motion.line(ac, controls, args)

   args.last = last
   args.jdata = rjoint
   motion.circle(ac, controls, args)
end
