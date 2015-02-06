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

motion.follow = function(ac, controls, args)
   args.x = args.x or 0
   args.y = args.y or 0
   args.ttl = args.ttl or 3
   args.delay = args.delay or 0
   args.delay1 = args.delay1 or 0
   args.max_step = args.max_step or 3000
   args.min_step = args.min_step or 30

   if args.target == nil then
      args.target = randomKey1(tfm.get.room.playerList, args.no_target, true)
   end

   local id1 = controls[#controls]
   local id = ac(controls, args.x, args.y, CONTROL, args.ttl, moveHoming1, nil, args)

   local joint = {
      type = 0,
      frequency = args.frequency or (1.0 / (1.0 + args.delay1))
   }
   local jdata = {
      type = 1,
      forceMotor = 255,
      speedMotor = 127
   }
   copy(jdata, args.jdata)

   addJoint(id1, id, joint, args.ttl)

   args.jdata = jdata
   args.gid = id
   args.jid = addJoint(id, 0, joint, args.ttl)
   --do_removeJoint(args.jid)
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
