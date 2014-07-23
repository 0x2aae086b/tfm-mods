MODULE_HELP_CONTENTS = [[<TI><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
]]

MODULE_HELP = {
	  ['Keys'] = [[<TI>Shoot - E
Bomb - R
Up - Space
Down - S, ↓
Left - A, ←
Right - D, →
]],
	  ['Commands'] = [[<TI>!help

!clear

!color [&lt;color&gt;]

!reset [map]
    tfm.exec.newGame(defaultMap)

!reset me|all|&lt;name&gt;
    initPlayer()

!respawn [me|all|&lt;name&gt;]
    tfm.exec.respawnPlayer()

!map [&lt;map&gt;]
    tfm.exec.newGame()

!shot [type]

!bomb [type]
]],
      ['Shot types'] = [[<TI>1
2
]],
      ['Bomb types'] = [[<TI>1
]]
}

CLOSE='<TI><a href="event:close">X</a>'

function help(name)
   ui.addTextArea(100, '', name, 308, 128, 300, 230)
   ui.addTextArea(101, '<TI>Help', name, 308, 100, 277, 20)
   ui.addTextArea(102, MODULE_HELP_CONTENTS, name, 200, 100, 100, 258)
   ui.addTextArea(103, CLOSE, name, 593, 100, 15, 20)
end

---------------------------------------------------------------------------

function randomColor()
   return string.format('0x%X', math.random(0x000000, 0xFFFFFF))
end

function tableLength(tbl)
   local count = 0
   for _ in pairs(tbl) do
      count = count + 1
   end
   return count
end

function randomKey1(tbl, excl_key)
   local keys, i = {}, 1

   for k,_ in pairs(tbl) do
      if not (k == excl_key) then
         keys[i] = k
         i = i+1
      end
   end

   if i > 1 then
      return keys[math.random(1,#keys)]
   else
      return excl_key
   end
end

function randomValue1(tbl, excl_key)
   return tbl[randomKey1(tbl, excl_key)]
end

---------------------------------------------------------------------------

function alert(str, name)
   ui.addPopup(0, 0, str, name, 300, 150, 200)
end

function getText(data)
   local lives = data.lives - 1
   local bombs = data.bombs

   if lives >= maxLives then
      lives = maxLives - 1
   end
   if lives < 0 then
      lives = 0
   end

   if bombs > maxBombs then
      bombs = maxBombs
   elseif bombs < 0 then
      bombs = 0
   end

   if data.lives < 1 then
      l = 0
   else
      l = data.lives
   end

   return '<TI><N>Player  <R>' .. string.rep('★', lives) ..
      '\n<N>Bomb  <VP>' .. string.rep('★', bombs)
end

function updateTextAreas(name, data)
   ui.updateTextArea(1, getText(data), name)
   ui.updateTextArea(104, '<TI><a href="event:help">?</a>', name)
end

function newId(ids)
   local free = ids.free
   local k, v = pairs(free)(free)
   if k then
      free[k] = nil
      return k
   else
      ids.max = ids.max + 1
      return ids.max
   end
end

function freeId(ids, id)
   local free = ids.free
   if id == ids.max then
      local t = ids.max - 1
      while free[t] do
         free[t] = nil
         t = t - 1
      end
      ids.max = t
   else
      free[id] = true
   end
end

function setColor(name, color)
   tfm.exec.setNameColor(name, color)
   playerColor[name] = color
   playerData[name].color = color
end

function addBomb(name, data)
   local i = bombs.top + 1
   local str = string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>', data.color, name, data.bomb.name)
   data.bomb_id = i
   bombs.top = i
   bombs.val[i] = str
   tfm.exec.setUIShamanName(str)
end

function removeBomb(name, data)
   local i = data.bomb_id
   data.bomb_id = nil
   bombs.val[i] = nil
   if i == bombs.top then
      i = i - 1
      while bombs.val[i] == nil and i > 0 do
         i = i - 1
      end

      bombs.top = i

      if i > 0 then
         i = bombs.val[i]
      else
         i = ''
      end

      tfm.exec.setUIShamanName(i)
   end
end

---------------------------------------------------------------------------

function shoot(name, data)
   if data.shot_cd == 0 then
      if data.bombing and data.bomb.shot ~= nil then
         data.shot_cd = data.bomb.shot.cd
         data.bomb.shot.func(name, data)
      else
         data.shot_cd = data.shot.cd
         data.shot.func(name, data)
      end
   end
end

function bomb(name, data)
   if data.bomb_cd == 0 and not data.bombing then
      if data.bombs >= data.bomb.cost then
         data.bombs = data.bombs - data.bomb.cost
         data.bombing = true
         data.bombTime = data.bomb.time
         data.bomb.func(name, data)
         addBomb(name, data)
         updateTextAreas(name, data)
      else
         alert(string.format('bombs &lt; %d', data.bomb.cost), name)
      end
   end
end

---------------------------------------------------------------------------

function defaultShot(name, data)
   local player = tfm.get.room.playerList[name]
   local x = player.x + player.vx
   local y = player.y + player.vy
   local vx = 20
   local g = true

   if not player.isFacingRight then
      vx = -vx
   end

   addObject(tfm.enum.shamanObject.anvil, x, y + 10, 0, vx, 0, g)
   addObject(tfm.enum.shamanObject.anvil, x, y - 10, 0, vx, 0, g)
   addObject(tfm.enum.shamanObject.anvil, x + 2 * vx, y + 10, 0, vx, 0, g)
   addObject(tfm.enum.shamanObject.anvil, x + 2 * vx, y - 10, 0, vx, 0, g)
end

function homingShot(name, data)
   local target = randomValue1(tfm.get.room.playerList, name)
   local player = tfm.get.room.playerList[name]
   local x = player.x
   local y = player.y
   local vx = 2
   local vy = 4
   local g = false

   if not player.isFacingRight then
      vx = -vx
   end

   addObject(tfm.enum.shamanObject.anvil, x + vx, y + vy, 0, vx, vy, g, 10, moveHoming, target)
   addObject(tfm.enum.shamanObject.anvil, x + vx, y - vy, 0, vx, -vy, g, 10, moveHoming, target)
end

function homingShot1(name, data)
   local target = randomKey1(tfm.get.room.playerList, name)
   local player = tfm.get.room.playerList[name]
   local x = player.x
   local y = player.y
   local vx = 2
   local vy = 2
   local g = false

   if not player.isFacingRight then
      vx = -vx
   end

   local args = {
      target = target,
      x = x + vx,
      y = y + 20,
      v = 128
   }

   addObject(tfm.enum.shamanObject.anvil, x + vx, y + vy, 0, vx, vy, g, 10, moveHoming1, args)

   local args = {
      target = target,
      x = x + vx,
      y = y - 20,
      v = 128
   }

   addObject(tfm.enum.shamanObject.anvil, x + vx, y - vy, 0, vx, -vy, g, 10, moveHoming1, args)
end

function testShot(name, data)
   local player = tfm.get.room.playerList[name]
   local x, y = player.x, player.y
   local k
   if player.isFacingRight then
      k = '-1,0'
   else
      k = '1,0'
   end
   local id = addGround(x, y + 24, {type=12, width=64, height=8, restitution=255, mass=10, dynamic=true, miceCollision=true, groundCollision=false, color='0xFFFFFF'}, 3)
   addJoint(id, 0, {color='0x00FFFF', line=2, type=1, axis=k, forceMotor=100, speedMotor=100}, 3)
   id = addGround(x, y - 24, {type=12, width=64, height=8, restitution=255, mass=10, dynamic=true, miceCollision=true, groundCollision=false, color='0xFFFFFF'}, 3)
   addJoint(id, 0, {color='0x00FFFF', line=2, type=1, axis=k, forceMotor=100, speedMotor=100}, 3)
end

---------------------------------------------------------------------------

function nop(...)
end

function defaultBomb(name, data)
   addBombTimer(name, tfm.get.room.playerList[name], data, true)
end

function testBombCallback(name, data)
   local player = tfm.get.room.playerList[name]

   local yc = player.y + player.vy
   local xb

   local x, y
   local k = data.bombCallbackArgs

   local ttl = 2.0

   local vx = 0
   local vy = 0

   local a = { ax = 64, ay = 0 }

   vx = k * vx
   a.ax = k * a.ax
   xb = player.x + k * data.bombTime * 10 + 10

   for off = 20, 120, 20 do
      y = off * k
      x = xb + y * 1.5
      addObject(tfm.enum.shamanObject.anvil, x, yc - y, 0, vx, -vy * k, false, ttl, accelerate, a)
      addObject(tfm.enum.shamanObject.anvil, x, yc + y, 0, vx, vy * k, false, ttl, accelerate, a)
      vy = vy + 1
   end
end

function testBomb(name, data)
   local player = tfm.get.room.playerList[name]

   if not player.isFacingRight then
      data.bombCallbackArgs = -1
   else
      data.bombCallbackArgs = 1
   end

   addBombTimer(name, player, data, true)
end

---------------------------------------------------------------------------

function accelerate(id, data)
   local a = data.callback_args
   moveObject(id, 0, 0, true, a.ax, a.ay, true)
end

function moveHoming(id, data)
   if data.time < 9.0 then
      local p = data.callback_args
      local px = p.x
      local py = p.y
      p = tfm.get.room.objectList[id]
      local x = p.x
      local y = p.y
      x = px - x
      y = py - y
      local l = x * x + y * y
      if l > 0 then
         l = 10.0 * (12.0 - data.time) / math.sqrt(l)
         x = x * l
         y = y * l
      end
      moveObject(id, 0, 0, true, x, y, true)
   end
end

function moveHoming1(id, data)
   if data.time < 9.0 and data.time > 8.0 then
      local a = data.callback_args
      local p = tfm.get.room.playerList[a.target]
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

---------------------------------------------------------------------------

function addBombTimer(name, player, data, protect)
   addGround(
      player.x,
      player.y,
      {
         type = 13,
         angle = 0,
         color = "0xFF0000",
         foreground = false,
         friction=0.0,
         restitution=2.0,
         width = data.bombTime * 10 + 5,
         height = data.bombTime * 10 + 5,
         miceCollision = false,
         groundCollision = protect,
         dynamic = false
      },
      data.bombTime,
      moveBombTimer,
      {
         player = name,
         pdata = data,
         offset = 5
      }
   )

   addGround(
      player.x,
      player.y,
      {
         type = 13,
         angle = 0,
         color = "0x6A7495",
         foreground = false,
         friction=0.0,
         restitution=2.0,
         width = data.bombTime * 10,
         height = data.bombTime * 10,
         miceCollision = false,
         groundCollision = protect,
         dynamic = false
      },
      data.bombTime,
      moveBombTimer,
      {
         player = name,
         pdata = data,
         offset = 0
      }
   )
end

function moveBombTimer(id, data)
   local a = data.callback_args
   local player = tfm.get.room.playerList[a.player]
   local sz = a.pdata.bombTime * 10 + a.offset
   moveGround(id, player.x, player.y, { width = sz, height = sz })
end

---------------------------------------------------------------------------

playerData = {}
objectData = {}
groundData = {}
jointData = {}

groundId = {
   max = 0,
   free = {}
}

jointId = {
   max = 0,
   free = {}
}

bombs = {
   top = 0,
   val = {}
}

shotTypes = {
   {
      func = testShot,
      --func = defaultShot,
      cd = 1
   },
   {
      func = homingShot1,
      cd = 2
   }
}

bombTypes = {
   {
      name = 'default bomb',
      func = testBomb,
      callback = testBombCallback,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 10,
      cd = 0
   }
}

playerColor = {
   Cafecafe = '0xB06FFD'
}

playerShot = {}
playerBomb = {}

defaultMap='<C><P G="0,0" /><Z><S /><D><DS Y="216" X="89" /></D><O /></Z></C>'
maxLives = 8
maxBombs = 6

movePlayer = tfm.exec.movePlayer
moveObject = tfm.exec.moveObject
setMap = tfm.exec.newGame
bindKey = tfm.exec.bindKeyboard
kill = tfm.exec.killPlayer

---------------------------------------------------------------------------

function addObject(type, x, y, angle, vx, vy, ghost, ttl, func, args)
   local id = tfm.exec.addShamanObject(type, x, y, angle, vx, vy, ghost)

   if ttl == nil then
      ttl = 1.5
   end

   objectData[id] = {
      time = ttl,
      callback = func,
      callback_args = args
   }

   return id
end

function removeObject(id)
   tfm.exec.removeObject(id)
   objectData[id] = nil
end

function addJoint(ground0, ground1, other, ttl)
   local id = newId(jointId)

   --[[local d = groundData[ground0]
   if d ~= nil then
      table.insert(d.joints, id)
   else
      d = groundData[ground1]
      if d ~= nil then
         table.insert(d.joints, id)
      end
   end]]--

   tfm.exec.addJoint(id, ground0, ground1, other)

   if ttl == nil then
      ttl = -1
   end

   if other == nil then
      other = {}
   end

   jointData[id] = {
      time = ttl
   }

   return id
end

function removeJoint(id)
   tfm.exec.removeJoint(id)
   jointData[id] = nil
   freeId(jointId, id)
end

function addGround(x, y, other, ttl, func, args)
   local id = newId(groundId)

   tfm.exec.addPhysicObject(id, x, y, other)

   if ttl == nil then
      ttl = 3
   end

   if other == nil then
      other = {}
   end

   groundData[id] = {
      time = ttl,
      callback = func,
      callback_args = args,
      move_args = other,
      joints={}
   }

   return id
end

function moveGround(id, x, y, other, ttl)
   local data = groundData[id]

   if data == nil then
      addGround(id, x, y, other, ttl)
   else
      if not (other == nil) then
         local a = data.move_args
         for k, v in pairs(other) do
            a[k] = v
         end
      end

      tfm.exec.addPhysicObject(id, x, y, data.move_args)
   end
end

function removeGround(id)
   for k, v in pairs(groundData[id].joints) do
      removeJoint(v)
   end
   tfm.exec.removePhysicObject(id)
   groundData[id] = nil
   freeId(groundId, id)
end

---------------------------------------------------------------------------

function initPlayer(name)
   local data = {
      color = playerColor[name] or randomColor(),
      shooting = false,
      bombing = false,
      shot = playerShot[name] or shotTypes[1],
      bomb = playerBomb[name] or bombTypes[1],
      bombTime = nil,
      lives = 5,
      bombs = 3,
      resetBombs = 3,
      shot_cd = 0,
      bomb_cd = 0,
      bomb_id = nil
   }
   playerData[name] = data

   local keys = { 32, 83, 40, 16, 100, 101, 102, 104, 81, 68, 69, 82, 87, 37, 39 }
   for k, v in pairs(keys) do
      bindKey(name, v, true, true)
      bindKey(name, v, false, true)
   end

   --system.bindMouse(name, true)

   ui.addTextArea(1, getText(data), name, 5, 25, 150, 38)
   ui.addTextArea(104, '<TI><a href="event:help">?</a>', name, 145, 25, 10, 20)

   tfm.exec.respawnPlayer(name)
   tfm.exec.setShaman(name)
   tfm.exec.setNameColor(name, playerData[name].color)
end

function deletePlayer(name)
   --ui.removeTextArea(1, name)
   local data = playerData[name]
   if data.bombing then
      removeBomb(name, data)
   end
   playerData[name] = nil
end

function respawn(name)
   tfm.exec.respawnPlayer(name)
   tfm.exec.setNameColor(name, playerData[name].color)
end

---------------------------------------------------------------------------

function clear()
   local ids={}

   for i, object in pairs(tfm.get.room.objectList) do
      table.insert(ids, i)
   end

   for k, v in pairs(ids) do
      removeObject(v)
   end

   ids = {}

   for i, object in pairs(groundData) do
      table.insert(ids, i)
   end

   for k, v in pairs(ids) do
      removeGround(v)
   end
end

function clearT()
   local ids={}
   local t

   local str = "<TI>--[Objects]--\n"

   for k, v in pairs(objectData) do
      t = tfm.get.room.objectList[k]
      if t == nil then
         table.insert(ids, t)
      else
         str = str .. string.format("%d (%d, %d) %.2f\n", k, t.x, t.y, v.time)

         t = v.time
         if t > -0.1 then
            if t < 0.5 then
               table.insert(ids, k)
            else
               v.time = t - 0.5
               if v.callback then
                  v.callback(k, v)
                  --if not pcall(v.callback, k, v) then
                  --   table.insert(ids, k)
                  --end
               end
            end
         elseif v.callback then
            v.callback(k, v)
            --if not pcall(v.callback, k, v) then
            --   table.insert(ids, k)
            --end
         end
      end
   end

   for k, v in pairs(ids) do
      removeObject(v)
   end

   ids = {}

   str = str .. "--[Grounds]--\n"

   for k, v in pairs(groundData) do
      str = str .. string.format("%d %.2f\n", k, v.time)

      t = v.time
      if t > -0.1 then
         if t < 0.5 then
            table.insert(ids, k)
         else
            v.time = t - 0.5
            if v.callback then
               v.callback(k, v)
               --if not pcall(v.callback, k, v) then
               --   table.insert(ids, k)
               --end
            end
         end
      elseif v.callback then
         v.callback(k, v)
         --if not pcall(v.callback, k, v) then
         --   table.insert(ids, k)
         --end
      end
   end

   for k, v in pairs(ids) do
      removeGround(v)
   end

   ids = {}

   str = str .. "--[Joints]--\n"

   for k, v in pairs(jointData) do
      str = str .. string.format("%d %.2f\n", k, v.time)

      t = v.time
      if t > -0.1 then
         if t < 0.5 then
            table.insert(ids, k)
         else
            v.time = t - 0.5
            --if v.callback then
            --   v.callback(k, v)
               --if not pcall(v.callback, k, v) then
               --   table.insert(ids, k)
               --end
            --end
         end
      --elseif v.callback then
      --   v.callback(k, v)
         --if not pcall(v.callback, k, v) then
         --   table.insert(ids, k)
         --end
      end
   end

   for k, v in pairs(ids) do
      removeJoint(v)
   end

   ui.addTextArea(2, str, nil, -150, 0, 150, 600)
end

---------------------------------------------------------------------------

eventNewPlayer = initPlayer
eventPlayerLeft = deletePlayer

function eventChatCommand(name, message)
   local i
   local j
   local cmd
   local arg

   while true do
      i, j = string.find(message, '%s+')

      if i == nil then
         cmd = message
         arg = ''
         break
      elseif i == 1 then
         message = string.sub(message, j + 1)
         if message == '' then
            cmd = ''
            arg = ''
            break
         end
      else
         cmd = string.sub(message, 1, i - 1)
         arg = string.sub(message, j + 1)
         break
      end
   end

   cmd = string.lower(cmd)

   if cmd == 'help' then
      help(name)
   elseif cmd == 'clear' then
      clear()
   elseif cmd == 'color' then
      arg = string.upper(arg)
      if arg == '' or arg == 'RANDOM' or arg == 'RND' then
         setColor(name, randomColor())
         playerColor[name] = nil
      else
         local argv = tonumber(arg)
         if argv ~= nil then
            if argv > 0xFFFFFF then
               argv = 0xFFFFFF
            end
            setColor(name, string.format('0x%X', argv))
         else
            alert('Invalid color: "' .. arg .. '"', name)
         end
      end
   elseif cmd == 'reset' then
      arg = string.lower(arg)
      if arg == '' or arg == 'map' then
         setMap(defaultMap)
      elseif arg == 'me' then
         deletePlayer(name)
         initPlayer(name)
      elseif arg == 'all' then
         for k, v in pairs(tfm.get.room.playerList) do
            deletePlayer(k)
            initPlayer(k)
         end
      else
         arg = string.gsub(arg, '^%l', string.upper)
         if not (tfm.get.room.playerList[arg] == nil) then
            deletePlayer(arg)
            initPlayer(arg)
         end
      end
   elseif cmd == 'respawn' or cmd == 'spawn' then
      arg = string.lower(arg)
      if arg == '' or arg == 'me' then
         respawn(name)
      elseif arg == 'all' then
         for k, v in pairs(tfm.get.room.playerList) do
            respawn(k)
         end
      else
         arg = string.gsub(arg, '^%l', string.upper)
         respawn(arg)
      end
   elseif cmd == 'shot' then
      arg = tonumber(arg)

      if arg == nil then
         arg = 1
      end

      arg = shotTypes[arg]

      if arg ~= nil then
         playerShot[name] = arg
         playerData[name].shot = arg
      end
   elseif cmd == 'bomb' then
      arg = tonumber(arg)

      if arg == nil then
         arg = 1
      end

      arg = bombTypes[arg]

      if arg ~= nil then
         playerBomb[name] = arg
         playerData[name].bomb = arg
      end
   elseif cmd == 'map' then
      if arg == '' then
         arg = defaultMap
      end

      setMap(arg)
   end
end

function eventNewGame()
   tfm.exec.disableAfkDeath(true)
   tfm.exec.disableAutoNewGame(true)
   tfm.exec.disableAutoScore(true)
   tfm.exec.disableAutoShaman(true)
   tfm.exec.setGameTime(0)

   playerData = {}
   objectData = {}
   groundData = {}
   jointData = {}

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

   for name,player in pairs(tfm.get.room.playerList) do
      initPlayer(name)
   end

   tfm.exec.setUIMapName('<TI>')
   tfm.exec.setUIShamanName('')

   tfm.exec.addPhysicObject(0, 0, 0, {type=13, width=10, height=10, color='0xFFFFFF', dynamic=false, miceCollision=false, groundCollision=false})
end

function eventKeyboard(name, key, down, x, y)
   if key == 82 then
      local data = playerData[name]
      if down then
         bomb(name, data)
      end
   elseif key == 16 then
      if down then
         addObject(tfm.enum.shamanObject.anvil, 800, math.random(0, 400), 0, 0, 0, false, 10, moveHoming, tfm.get.room.playerList[name])
      end
   elseif key == 69 then
      local data = playerData[name]
      data.shooting = down
      if down then
         shoot(name, data)
      end
   else
      local vy = 0
      local vx = 0

      if not down then
         if key == 32 or key == 104 or key == 83 or key == 40 or key == 53 or key == 101 or key == 87 then
            movePlayer(name, 0, 0, true, 0, 1, false)
            movePlayer(name, 0, 0, true, 0, -1, true)
         else
            movePlayer(name, 0, 0, true, 1, 0, false)
            movePlayer(name, 0, 0, true, -1, 0, true)
         end
      else
         if key == 32 or key == 104 or key == 87 then
            vy = -50
         elseif key == 83 or key == 40 or key == 101 then
            vy = 50
         elseif key == 100 then
            vx = -50
         elseif key == 102 then
            vx = 50
         end

         if vx ~= 0 or vy ~= 0 then
            movePlayer(name, 0, 0, true, vx, vy, false)
         end
      end
   end
end

function eventSummoningStart(name, type, x, y, angle)
   if type == tfm.enum.shamanObject.anvil or type == 18 or type == 20 or type == tfm.enum.shamanObject.cannon then
      local n = math.random(8, 16)
      for i = 1, n do
         addObject(type, x, y, math.random(-180,180), math.random(-20,20), math.random(-20,20), false, 3)
      end
   end
end

function eventSummoningEnd(name, type, x, y, angle, vx, vy, data, other)
   objectData[data.id] = {
      time = 3
   }
end

function eventMouse(name, x, y)
   local player = tfm.get.room.playerList[name]

   local speed = 50

   local dx = x - player.x
   local dy = y - player.y
   local angle
   local len = math.sqrt(dx * dx + dy * dy)

   if dx or dy then
      dx = dx * speed / len
      dy = dy * speed / len

      addObject(tfm.enum.shamanObject.anvil, player.x, player.y, 0, dx, dy, true)
   end
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
   local player
   local x, y

   local vx = 50
   local vy = 10

   for name, data in pairs(playerData) do
      if data.shot_cd > 0 then
         data.shot_cd = data.shot_cd - 1
      end
      if data.bomb_cd > 0 then
         data.bomb_cd = data.bomb_cd - 1
      end

      if data.shooting then
         shoot(name, data)
      end

      if data.bombing then
         data.bombTime = data.bombTime - 0.5
         if data.bombTime < 0.1 then
            data.bombing = false
            data.bomb_cd = data.bomb.cd
            removeBomb(name, data)
         else
            if data.bomb.callback then
               data.bomb.callback(name, data)
            end
         end
      end
   end

   clearT()

   --for i = 0, 3 do
   --   tfm.exec.addShamanObject(tfm.enum.shamanObject.anvil, 800 + math.random(-10, 10), 200 + math.random(-100, 100), math.random(-180,180), math.random(-50, 0), math.random(-15,15), false)
   --end
end

function eventTextAreaCallback(id, name, callback)
   if callback == 'help' then
      help(name)
   elseif callback == 'close' and id == 103 then
      ui.removeTextArea(100, name)
      ui.removeTextArea(101, name)
      ui.removeTextArea(102, name)
      ui.removeTextArea(103, name)
   else
      local str = MODULE_HELP[callback]
      if str ~= nil then
         ui.updateTextArea(100, str, name)
         ui.updateTextArea(101, '<TI>' .. callback, name)
      end
   end
end

system.disableChatCommandDisplay('help', true)

setMap(defaultMap)
