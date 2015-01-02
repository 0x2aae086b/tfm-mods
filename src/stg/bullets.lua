bullet = {}

bullet.circle = function(x, y, R, jdata, hitbox_data)
   local point2 = string.format('%d,%d', x, y + 1)

   local joint = {
      type = 0,
      point2 = point2,
      color = 0x0000FF,
      line = 2 * R,
      foreground = false
   }

   local hitbox = {
      type = 13,
      width = R,
      height = R,
      miceCollision = true,
      groundCollision = false,
      dynamic = true,
      restitution = 255,
      color = 0xFFFFFF
   }

   copy(hitbox, hitbox_data)

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, hitbox)

   local joints = {}

   if jdata then
      for _, v in ipairs(jdata) do
         copy(joint, v)
         addJoint1(joints, id0, id0, joint)
      end
   end

   return id0, {id0}, joints
end

bullet.butterfly = function(x, y, angle, R, center_jdata, wing_jdata, hitbox_data)
   local star = make_star(5, 2)

   local wing = {
      type = 0,
      color = 0xFF00FF,
      alpha = 0.25,
      line = star.l * R * 2,
      foreground = false
   }

   local center = {
      type = 0,
      point1 = string.format('%d,%d', x, y),
      point2 = string.format('%d,%d', x, y + 1),
      color = 0x0000FF,
      line = R * 2,
      foreground = false
   }

   local hitbox = {
      type = 13,
      width = R,
      height = R,
      dynamic = true,
      miceCollision = true,
      groundCollision = false,
      restitution = 255,
      color = 0xFFFFFF
   }

   copy(wing, wing_jdata)
   copy(hitbox, hitbox_data)

   local joints = {}
   local pts = {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)

   local v

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, hitbox)

   for i = 2, 5 do
      v = star.points[i]
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      x1, y1 = x + R * x1, y + R * y1

      wing.point1 = string.format('%d,%d', x1, y1)
      wing.point2 = string.format('%d,%d', x1, y1 + 1)
      addJoint1(joints, id0, id0, wing)
   end

   if center_jdata then
      for _, v in ipairs(center_jdata) do
         copy(center, v)
         addJoint1(joints, id0, id0, center)
      end
   end

   return id0, {id0}, joints
end

bullet.jstar = function(x, y, angle, R, points, step, line_jdata, center_jdata, hitbox_data)
   local star = make_star(points, step)

   local line = {
      type = 0,
      color = 0xFFFFFF,
      line = 5,
      foreground = true
   }

   local tmp = R * star.r

   local center = {
      type = 0,
      point1 = string.format('%d,%d', x, y),
      point2 = string.format('%d,%d', x, y + 1),
      color = 0xFFFFFF,
      line = tmp * 2,
      foreground = true
   }

   local hitbox = {
      type = 13,
      width = tmp,
      height = tmp,
      dynamic = true,
      miceCollision = true,
      groundCollision = false,
      restitution = 255
   }

   copy(line, line_jdata)
   copy(center, center_jdata)
   copy(hitbox, hitbox_data)

   local joints = {}
   local pts = {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)

   for k, v in ipairs(star.points) do
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      pts[#pts + 1] = string.format('%d,%d', x + R * x1, y + R * y1)
   end

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, hitbox)

   for i = 1, points do
      line.point1 = pts[i]
      line.point2 = pts[1 + (i + step - 1) % points]
      addJoint1(joints, id0, id0, line)
   end

   addJoint1(joints, id0, id0, center)

   return id0, {id0}, joints
end

bullet.star = function(x, y, angle, R, points, step, do_cap, line_data, center_data, cap_data)
   local star = make_star(points, step)

   local line = {
      type = 12,
      height = 1,
      color = 0xFFFFFF,
      groundCollision = false,
      miceCollision = false,
      dynamic = true,
      foreground = true,
      restitution = 255
   }

   local tmp = R * star.r

   local center = {
      type = 13,
      width = tmp,
      height = tmp,
      color = 0xFFFFFF,
      groundCollision = false,
      miceCollision = true,
      dynamic = true,
      foreground = true,
      restitution = 255
   }

   local cap = {
      type = 13,
      color = 0xFFFFFF,
      groundCollision = false,
      miceCollision = false,
      dynamic = true,
      foreground = true,
      restitution = 255
   }

   tmp = string.format('%d,%d', x, y)

   local joint1 = {
      type = 3,
      point1 = tmp,
      point2 = tmp,
      ratio = 1,
      limit1 = 0,
      limit2 = 0
   }

   local joint2 = {
      type = 0,
      frequency = 10
   }

   copy(line, line_data)
   copy(center, center_data)
   copy(cap, cap_data)

   local lines, caps, joints = {}, {}, {}

   local x1, y1
   local a = angle * 180.0 / math.pi
   local c, s = math.cos(angle), math.sin(angle)

   for k, v in ipairs(star.lines) do
      line.angle = v.angle + a
      line.width = v.width * R
      x1, y1 = v.x * c - v.y * s, v.x * s + v.y * c
      addGround1(lines, x + R * x1, y + R * y1, line)
   end

   if do_cap then
      for k, v in ipairs(star.points) do
         x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
         addGround1(caps, x + R * x1, y + R * y1, cap)
      end
   end

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, center)

   if line.dynamic then
      local prev, first = nil, nil

      for k, v in ipairs(lines) do
         addJoint1(joints, v, id0, joint1)

         if prev ~= nil then
            addJoint1(joints, v, prev, joint2)
         else
            first = v
         end

         prev = v
      end

      addJoint1(joints, first, prev, joint2)
   elseif center.dynamic then
      for k, v in ipairs(lines) do
         addJoint1(joints, v, id0, joint1)
      end
   end

   if do_cap then
      if cap.dynamic then
         local prev, first = nil, nil

         for i = 1, points do
            addJoint1(joints, caps[i], lines[i], joint1)

            if prev ~= nil then
               addJoint1(joints, caps[i], prev, joint2)
            else
               first = caps[i]
            end

            prev = caps[i]
         end

         addJoint1(joints, first, prev, joint2)
      elseif line.dynamic then
         for i = 1, points do
            addJoint1(joints, caps[i], lines[i], joint1)
         end
      end
   end

   append(lines, caps)
   lines[#lines + 1] = id0

   return id0, lines, joints
end
