function shoot_bullet(id, data)
   local a = data.callback_args
   if a._cd == nil then
      a._cd = 0
   end
   if a._cd > 0 then
      a._cd = a._cd - 1
   else
      a._cd = a.cd
      local id = addBullet(a.btype, a.bdata, a.bttl, a.callback, a.on_remove, a.cbargs)
      if a.mtype ~= nil then
         addMotion(a.mtype, id, true, a.mdata)
      end
   end
end

function explode(id, data)
   local a = data.callback_args
   addExplosion(a.x, a.y, a.power, a.distance, a.miceOnly, a.p1, a.p2)
end

function explode1(id, data)
   local a = data.callback_args
   if a.t <= 0 then
      local k = randomKey1(tfm.get.room.playerList, data.user, true)
      local x, y = 0, 0
      if k ~= nil then
         local target = tfm.get.room.playerList[k]
         x, y = target.x, target.y
      end
      addExplosion(x, y, a.power, a.distance, a.miceOnly, a.p1, a.p2)
      a.t = a.cd
   else
      a.t = a.t - 1
   end
end

function accelerate(id, data)
   local a = data.callback_args
   moveObject(id, 0, 0, true, a.ax, a.ay, true)
end

function moveHoming(id, data)
   if data.time <= 7 and data.time >= 5 then
      local a = data.callback_args
      local p = tfm.get.room.playerList[a.target]
      if p ~= nil then
         local px = p.x
         local py = p.y
         local x = a.x
         local y = a.y
         px = px - x
         py = py - y
         local l = px * px + py * py
         if l > 0 then
            l = a.v / math.sqrt(l)
            px = px * l
            py = py * l
         end
         moveObject(id, 0, 0, true, px, py, false)
      end
   end
end

function moveHoming1(id, data)
   local a = data.callback_args
   if a.delay > 0 then
      a.delay = a.delay - 1
   else
      local dx, dy
      local p = nil

      if a.target then
         p = tfm.get.room.playerList[a.target]
      end

      if p then
         dx, dy = p.x - a.x, p.y - a.y
      elseif a.target_x then
         dx, dy = a.target_x - a.x, a.target_y - a.y
      else
         return
      end

      local l = math.min(math.sqrt(dx * dx + dy * dy), a.max_step)
      if l > a.min_step then
         local ax, a1 = to_axis(-math.atan2(dy, dx))
         a.jdata.limit2 = l / 30.0
         a.jdata.axis = ax
         a.x = a.x + l * math.cos(-a1)
         a.y = a.y + l * math.sin(-a1)
         do_addJoint(a.jid, a.gid, 0, a.jdata)
         a.delay = a.delay1
      end
   end
end
