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
