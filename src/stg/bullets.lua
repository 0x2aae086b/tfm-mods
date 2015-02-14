bullet = {}

bullet.rectangle = function(a)
   local x, y, angle = a.x, a.y, a.angle
   local width, height = a.width, a.height
   local jdata, hitbox_data = a.jdata, a.hitbox_data

   local dx, dy = math.cos(angle), math.sin(angle)
   local w = width / 2.0

   local joint = {
      type = 0,
      point1 = string.format("%d,%d", x, y),
      point2 = string.format("%d,%d", x + dx * width, y + dy * width),
      color = 0xFF0000,
      line = 2.0 * height + 4,
      foreground = false
   }

   local hitbox = {
      type = 12,
      width = width,
      height = height,
      angle = math.deg(angle),
      miceCollision = true,
      groundCollision = false,
      foreground = true,
      dynamic = true,
      mass = 1,
      restitution = 255
   }

   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}
   local id0 = addGround1(grounds, x + dx * w, y + dy * w, hitbox)

   if jdata then
      for _, v in ipairs(jdata) do
         copy(joint, v)
         addJoint1(joints, id0, id0, joint)
      end
   end

   return id0, grounds, joints
end

bullet.circle = function(a)
   local x, y, R = a.x, a.y, a.R
   local jdata, hitbox_data = a.jdata, a.hitbox_data

   local joint = {
      type = 0,
      point2 = string.format('%d,%d', x, y + 1),
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
      mass = 1,
      restitution = 255
   }

   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}
   local id0 = addGround1(grounds, x, y, hitbox)

   if jdata then
      for _, v in ipairs(jdata) do
         copy(joint, v)
         addJoint1(joints, id0, id0, joint)
      end
   end

   return id0, grounds, joints
end

bullet.butterfly = function(a)
   local x, y, angle, R = a.x, a.y, a.angle, a.R
   local center_jdata, wing_jdata = a.center_jdata, a.wing_jdata
   local hitbox_data = a.hitbox_data
   local i

   local star = make_star(5, 2)

   local wing = {
      type = 0,
      color = 0xFF00FF,
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
      mass = 1,
      miceCollision = true,
      groundCollision = false,
      restitution = 255
   }

   copy(wing, wing_jdata)
   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)
   local v

   local id0 = addGround1(grounds, x, y, hitbox)

   for i = 2, 5 do
      v = star.points[i]
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      x1, y1 = x + R * x1, y + R * y1

      wing.point1 = string.format('%d,%d', x1, y1)
      wing.point2 = string.format('%d,%d', x1, y1 + 1)
      addJoint1(joints, id0, id0, wing)
   end

   copy(center, center_jdata)
   addJoint1(joints, id0, id0, center)

   return id0, grounds, joints
end

bullet.jstar = function(a)
   local x, y, angle, R = a.x, a.y, a.angle, a.R
   local points, step = a.points, a.step
   local line_jdata, center_jdata = a.line_jdata, a.center_jdata
   local hitbox_data = a.hitbox_data
   local i

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
      mass = 1,
      miceCollision = true,
      groundCollision = false,
      restitution = 255
   }

   copy(line, line_jdata)
   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}
   local pts = {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)

   for k, v in ipairs(star.points) do
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      pts[#pts + 1] = string.format('%d,%d', x + R * x1, y + R * y1)
   end

   local id0 = addGround1(grounds, x, y, hitbox)
   
   for i = 1, points do
      line.point1 = pts[i]
      line.point2 = pts[1 + (i + step - 1) % points]
      addJoint1(joints, id0, id0, line)
   end

   if center_jdata then
      for k, v in ipairs(center_jdata) do
         copy(center, v)
         addJoint1(joints, id0, id0, center)
      end
   end

   return id0, grounds, joints
end

bullet.star = function(a)
   local x, y, angle, R = a.x, a.y, a.angle, a.R
   local points, step, do_cap = a.points, a.step, a.do_cap
   local line_data, center_data = a.line_data, a.center_data
   local cap_data = a.cap_data

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
   local a = math.deg(angle)
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

   local id0 = addGround1(caps, x, y, center)

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

   return id0, lines, joints
end
