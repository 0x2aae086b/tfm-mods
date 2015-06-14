playerKeys = { kc.w, kc.s, kc.a, kc.d, kc.space, kc.left, kc.right, kc.up, kc.down, kc.kp7, kc.kp8, kc.kp4, kc.kp5, kc.kp6, kc.kp1, kc.kp2, kc.e, kc.q }

pk_vx = {
   [kc.a] = -1,
   [kc.left] = -1,
   [kc.d] = 1,
   [kc.right] = 1
}

pk_vy = {
   [kc.space] = -1,
   [kc.w] = -1,
   [kc.up] = -1,
   [kc.s] = 1,
   [kc.down] = 1
}

pkc_vx = {
   [kc.kp4] = -1,
   [kc.kp6] = 1
}

pkc_vy = {
   [kc.kp8] = -1,
   [kc.kp2] = 1
}

function movePlayer1(name, data, vx, vy, down)
   if MTYPE == 0 then
      return false
   end
   if vx then
      if down then
         data.vx = vx * MOUSE_SPEED
         if data.vx > 0 then
            data.dir = 1
         else
            data.dir = -1
         end
         movePlayer(name, 0, 0, false, data.vx, data.vy, false)
      else --if MTYPE == 1 then
         movePlayer(name, 0, 0, false, 1, 0, false)
         movePlayer(name, 0, 0, false, -1, 0, true)
         data.vx = 0
      end
   elseif vy then
      if down then
         data.vy = vy * MOUSE_SPEED
         movePlayer(name, 0, 0, false, data.vx, data.vy, false)
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
