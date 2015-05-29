function eventNewPlayer(name)
   playerData[name] = {
      lastFunction = {},
      newFunction = {},
      append = false,
      ui = UI_DEFAULT,
      vx = 0,
      vy = 0,
      cntl = {
         name = nil,
         obj = nil,
         off = nil
      }
   }

   if UI_DEFAULT then
      ui.addTextArea(104, '<TI><a href="event:help"><p align="center">Help</p></a>', name, 5, 25, 40, 22, nil, nil, nil, true)
      ui.addTextArea(ERROR_TA, table.concat(_errors), name, 805, 5, 200, 590, nil, nil, 0.5, true)
   end

   for k, v in ipairs(playerKeys) do
      bindKey(name, v, true, true)
      bindKey(name, v, false, true)
   end

   system.bindMouse(name, true)
   --tfm.exec.setShaman(name)
   if MAPS == nil then
      do_respawn(name)
   end
end

function eventPlayerLeft(name)
   playerData[name] = nil
   if MAPS then
      playerDied()
   end
end

function eventNewGame()
   initTimers()

   tfm.exec.disableAfkDeath(true)
   tfm.exec.disableAutoNewGame(true)

   objectData = {}
   groundData = {}
   jointData = {}

   if MAPS == nil then
      tfm.exec.disableAutoScore(true)
      tfm.exec.setGameTime(0)
      do_addGround(0, 0, 0, { type=13 })
   else
      PLAYERS = length(tfm.get.room.playerList)
   end
end

function newMap()

end

function playerDied()
   PLAYERS = PLAYERS - 1
   if PLAYERS <= 0 then
      tfm.exec.setGameTime(0)
   end
end

function eventPlayerDied(name)
   if MAPS == nil then
      do_respawn(name)
   else
      playerDied()
   end
end

function eventPlayerWon(name)
   if MAPS == nil then
      do_respawn(name)
   else
      playerDied()
   end
end

function eventPlayerRespawn(name)
   if PLAYERS then
      PLAYERS = PLAYERS + 1
   end
end

function eventTextAreaCallback(id, name, callback)
   if not lsTextAreaCallback(id, name, callback) then
      helpTextAreaCallback(id, name, callback)
   end
end

function eventKeyboard(name, key, down)
   local data = playerData[name]
   if movePlayer1(name, data, pk_vx[key], pk_vy[key], down) then
      return
   end
   local cntl = data.cntl
   local name1 = cntl.name
   if name1 then
      local data1 = playerData[name1]
      if movePlayer1(name1, data1, pkc_vx[key], pkc_vy[key], down) then
         return
      end
      if down then
         if key == kc.kp7 then
            t = tfm.get.room.playerList[name1]
            if t then
               local a
               local v = math.random(16, 32)
               local c, s
               cntl.da = (cntl.da + 10) % 60
               for a = cntl.da, 359 + cntl.da, 60 do
                  c = math.rad(a)
                  s = math.sin(c)
                  c = math.cos(c)
                  addObject(cntl.obj, t.x + c * cntl.off, t.y + s * cntl.off, a, v * c, v * s, false, 10)
               end
            end
         elseif key == kc.kp5 then
            t = tfm.get.room.playerList[name1]
            if t then
               local x, vx
               x = t.x + cntl.off * data1.dir
               vx = math.random(16, 32) * data1.dir
               addObject(cntl.obj, x, t.y, 0, vx, 0, false, 10)
            end
         end
      end
   end
end

function eventLoop(ctime, rtime)
   step(1, objectData, removeObject, nil, nop)

   if MTYPE == 1 then
      for k, v in pairs(playerData) do
         if v.vx ~= 0 or v.vy ~= 0 then
            movePlayer(k, 0, 0, false, v.vx, v.vy, false)
         end
      end
   end

   if CUR_MAP and rtime <= 0 then
      CUR_MAP = CUR_MAP + 1
      if MAPS[CUR_MAP] then
         setMap(MAPS[CUR_MAP])
      else
         MAPS = nil
         CUR_MAP = nil
         setMap(curMap)
      end
   end
end
