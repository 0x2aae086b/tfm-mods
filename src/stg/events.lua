eventNewPlayer = initPlayer
eventPlayerLeft = deletePlayer
eventTextAreaCallback = helpTextAreaCallback

function eventNewGame()
   initTimers()

   tfm.exec.disableAfkDeath(true)
   tfm.exec.disableAutoNewGame(true)
   tfm.exec.disableAutoScore(true)
   tfm.exec.disableAutoShaman(true)
   tfm.exec.setGameTime(0)

   objectData = {}
   groundData = {}
   jointData = {}
   patternData = {}
   bulletData = {}

   bombs = {
      top = 0,
      val = {}
   }

   groundId = {
      max = 0,
      free = {}
   }

   jointId = {
      max = 0,
      free = {}
   }

   patternId = {
      max = 0,
      free = {}
   }

   bulletId = {
      max = 0,
      free = {}
   }

   for name, player in pairs(tfm.get.room.playerList) do
      resetPlayer(name)
   end

   setMapName('<TI>')
   setShamanName('')

   do_addGround(0, 0, 0, GROUND0)
end

function eventKeyboard(name, key, down, x, y)
   if reservedKeys[key] then
      local data = playerData[name]
      if movePlayer1(name, data, pk_vx[key], pk_vy[key], down) then
         return
      end
      if key == kc.q then
         local data = playerData[name]
         if down then
            bomb(name, data)
         end
      elseif key == kc.e then
         local data = playerData[name]
         data.shooting = down
         if down then
            shoot(name, data)
         end
      elseif key == kc.shift then
         local data = playerData[name]
         data.focused = down
         if down then
            data.curSpeed = data.focusedSpeed
         else
            data.curSpeed = data.speed
         end
         if data.vx ~= 0 or data.vy ~= 0 then
            movePlayer(name,
                       0, 0, false,
                       data.vx * data.curSpeed, data.vy * data.curSpeed, false
            )
         end
      end
   elseif down then
      local data = playerData[name]
      pattern(name, data, 'key', key, { x = x, y = y })
   end
end

function eventSummoningStart(name, type, x, y, angle)
   local point = {
      x = x,
      y = y,
      angle = angle,
      type = type
   }

   pattern(name, playerData[name], 'obj', type, point)
end

function eventSummoningEnd(name, type, x, y, angle, vx, vy, data, other)
   objectData[data.id] = {
      time = 3
   }

   local point = {
      x = x,
      y = y,
      angle = angle,
      type = type,
      vx = vx,
      vy = vy,
      data = data,
      other = other
   }

   pattern(name, playerData[name], 'objend', type, point)
end

function eventMouse(name, x, y)
   --local player = tfm.get.room.playerList[name]
   addError(string.format('(%d; %d)', x, y))
end

function eventPlayerDied(name)
   local data = playerData[name]

   if data ~= nil then
      if data.bombing then
         respawn(name)
      else
         data.shot_cd = 0
         data.bomb_cd = 0
         data.shooting = false
         data.lives = data.lives - 1
         if data.lives > 0 then
            data.bombs = data.resetBombs
            updateTextAreas(name, data)
            respawn(name)
         else
            alert(string.format('playerData["%s"].lives &lt;= 0', name), name)
         end
      end
   end
end

function eventLoop(ctime, rtime)
   local player, x, y, i
   local R = 25.0
   local v = 1.5
   local a = -v * v / R
   local star = make_star(5, 2)

   clearT(1)

   for name, data in pairs(playerData) do
      if data.shot_cd > 0 then
         data.shot_cd = data.shot_cd - 1
      end
      if data.bomb_cd > 0 then
         data.bomb_cd = data.bomb_cd - 1
      end

      player = tfm.get.room.playerList[name]
      if not player.isDead then
         x = player.x
         y = player.y

         if x == 0 and y == 0 then
            kill(name)
         else
            if x < X_MIN then
               x = X_MIN
            elseif x > X_MAX then
               x = X_MAX
            end

            if y < Y_MIN then
               y = Y_MIN
            elseif y > Y_MAX then
               y = Y_MAX
            end

            data.spawn[0] = x
            data.spawn[1] = y

            if data.focused then
               local p
               for i, p in ipairs(star.points) do
                  addParticle(particles.purple,
                              x + R * p[1], y + R * p[2],
                              v * p[2], -v * p[1],
                              a * p[1], a * p[2]
                  )
               end
            end

            if data.shooting then
               shoot(name, data)
            end

            if data.bombing then
               data.bombTime = data.bombTime - 1
               if data.bombTime <= 0 then
                  data.bombing = false
                  data.bomb_cd = data.bomb.cd
                  removeBomb(name, data)
               else
                  if data.bomb.callback then
                     local st, err = pcall(data.bomb.callback, name, data)
                     if not st then
                        addError('bomb.callback: ' .. err)
                     end
                  end
               end
            end
         end
      end
   end
end
