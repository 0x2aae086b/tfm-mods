function eventNewPlayer(name)
   playerData[name] = {
      lastFunction = {},
      newFunction = {},
      append = false,
      ui = UI_DEFAULT,
      vx = 0,
      vy = 0,
      dir = 1,
      cntl = {
         name = nil,
         obj = nil,
         off = nil,
         da = nil
      },
      self_cntl = {
         obj = objcode.anvil1,
         off = 48,
         da = 0
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

   if setMapXML then
      setMapXML = false
      if tfm.get.room.xmlMapInfo then
         curMapXML = tfm.get.room.xmlMapInfo.xml
      else
         curMapXML = nil
      end
   end

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
   local i, t, cntl, name1, data1
   if movePlayer1(name, data, pk_vx[key], pk_vy[key], down) then
      return
   end
   if down then
      if key == kc.e then
         i = 1
      elseif key == kc.q then
         i = 2
      end
      if i then
         t = tfm.get.room.playerList[name]
         if t then
            shoot[i](t, data, math.random(SHOT_SPEED[1], SHOT_SPEED[2]), data.self_cntl)
            return
         end
      end
   end
   cntl = data.cntl
   name1 = cntl.name
   if name1 then
      data1 = playerData[name1]
      if movePlayer1(name1, data1, pkc_vx[key], pkc_vy[key], down) then
         return
      end
      if down then
         if key == kc.kp7 then
            i = 2
         elseif key == kc.kp5 then
            i = 1
         end
         if i then
            t = tfm.get.room.playerList[name1]
            if t then
               shoot[i](t, data1, math.random(SHOT_SPEED[1], SHOT_SPEED[2]), cntl)
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
