playerKeys = { kc.w, kc.s, kc.a, kc.d, kc.space, kc.left, kc.right, kc.up, kc.down, kc.kp7, kc.kp8, kc.kp4, kc.kp5, kc.kp6, kc.kp1 }

pk_vx = {
   [kc.a] = -30,
   [kc.left] = -30,
   [kc.d] = 30,
   [kc.right] = 30
}

pk_vy = {
   [kc.space] = -30,
   [kc.w] = -30,
   [kc.up] = -30,
   [kc.s] = 30,
   [kc.down] = 30
}

pkc_vx = {
   [kc.kp4] = -30,
   [kc.kp6] = 30
}

pkc_vy = {
   [kc.kp8] = -30,
   [kc.kp2] = 30
}

function movePlayer1(name, data, vx, vy, down)
   if MTYPE == 0 then
      return false
   end
   if vx then
      if down then
         data.vx = vx
         if data.vx > 0 then
            data.dir = 1
         else
            data.dir = -1
         end
         movePlayer(name, 0, 0, false, vx, data.vy, false)
      else --if MTYPE == 1 then
         movePlayer(name, 0, 0, false, 1, 0, false)
         movePlayer(name, 0, 0, false, -1, 0, true)
         data.vx = 0
      end
   elseif vy then
      if down then
         data.vy = vy
         movePlayer(name, 0, 0, false, data.vx, vy, false)
      elseif MTYPE == 2 then
         movePlayer(name, 0, 0, false, 0, -1, false)
         movePlayer(name, 0, 0, false, 0, 1, true)
         data.vy = 0
      else
         data.vy = 0
      end
   else
      return false
   end
   return true
end
