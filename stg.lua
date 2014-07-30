--[[
   This program is free software. It comes without any warranty, to
   the extent permitted by applicable law. You can redistribute it
   and/or modify it under the terms of the Do What The Fuck You Want
   To Public License, Version 2, as published by Sam Hocevar. See
   the COPYING file for more details.
]]--

MODULE_HELP_START = 'Keys'

MODULE_HELP_CONTENTS = [[<font face="mono" size="15"><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
<a href="event:Pattern types">Pattern types</a>
<a href="event:Shaman objects">Shaman objects</a></font>
]]

MODULE_HELP = {
      ['Keys'] = [[<font face="mono" size="15">Shoot - E
Bomb  - R
Up    - Space
Down  - S, ↓
Left  - A, ←
Right - D, →</font>
]],
      ['Commands'] = [[<font face="mono" size="15">!help

!clear

!color [&lt;color&gt;]

!reset [map]
    tfm.exec.newGame(defaultMap)

!reset [!]me|all|&lt;name&gt;...
    resetPlayer()

!init [!]me|all|&lt;name&gt;...
    deletePlayer()
    initPlayer()

!respawn [!]me|all|&lt;name&gt;...
    tfm.exec.respawnPlayer()

!map [&lt;map&gt;]
    tfm.exec.newGame()

!shot [type]

!bomb [type]

!bind &lt;pattern&gt; key|obj|objend &lt;name|id&gt;

!unbind [all]
!unbind key|obj|objend [&lt;name|code&gt;]
</font>
]],
      ['Shot types'] = [[<font face="mono" size="15">1 - default shot
    Cooldown: 0.5s

2 - homing anvils
    Cooldown: 1s
</font>
]],
      ['Bomb types'] = [[<font face="mono" size="15">1 - default bomb
    Cost: 1
    Duration: 10s
    Cooldown: 0s
</font>
]],
      ['Pattern types'] = [[<font face="mono" size="15">1
    Cooldown: 0.5s
    Max. binds: 3
    Points: 1
</font>
]],
      ['Shaman objects'] = ''
}

CLOSE='<TI><a href="event:close"><p align="center">X</p></a>'

function help(name)
   ui.addTextArea(100, MODULE_HELP[MODULE_HELP_START], name, 258, 78, 421, 284)
   ui.addTextArea(101, string.format('<p align="center"><font face="mono" size="15">%s</font></p>', MODULE_HELP_START), name, 258, 50, 398, 20)
   ui.addTextArea(102, MODULE_HELP_CONTENTS, name, 100, 50, 150, 312)
   ui.addTextArea(103, CLOSE, name, 664, 50, 15, 20)
end

---------------------------------------------------------------------------

keycode = {
   backspace = 8,
   enter = 13,
   shift = 16,
   ctrl = 17,
   alt = 18,
   capslock = 20,
   esc = 27,
   space = 32,

   ['0'] = 48, ['1'] = 49, ['2'] = 50, ['3'] = 51, ['4'] = 52,
   ['5'] = 53, ['6'] = 54, ['7'] = 55, ['8'] = 56, ['9'] = 57,

   a = 65, b = 66, c = 67, d = 68, e = 69, f = 70, g = 71, h = 72, i = 73,
   j = 74, k = 75, l = 76, m = 77, n = 78, o = 79, p = 80, q = 81, r = 82,
   s = 83, t = 84, u = 85, v = 86, w = 87, x = 88, y = 89, z = 90,

   [';'] = 186, ['='] = 187, [','] = 188, ['-'] = 189, ['.'] = 190,
   ['/'] = 191, ['`'] = 192,

   [':'] = 186, ['+'] = 187, ['<'] = 188, ['_'] = 189, ['>'] = 190,
   ['?'] = 191, ['~'] = 192,

   ['['] = 219, ['\\'] = 220, [']'] = 221, ["'"] = 222,
   ['{'] = 219, ['|'] = 220,  ['}'] = 221, ['"'] = 222,

   [')'] = 48, ['!'] = 49, ['@'] = 50, ['#'] = 51, ['$'] = 52,
   ['%'] = 53, ['^'] = 54, ['&'] = 55, ['*'] = 56, ['('] = 57,

   kp0 = 96,  kp1 = 97,  kp2 = 98,  kp3 = 99,  kp4 = 100,
   kp5 = 101, kp6 = 102, kp7 = 103, kp8 = 104, kp9 = 105,

   ['kp*'] = 106, ['kp+'] = 107, ['kp-'] = 109, ['kp.'] = 110, ['kp/'] = 111,

   left = 37,
   up = 38,
   right = 39,
   down = 40,

   f1 = 112, f2 = 113, f3 = 114, f4 = 115,  f5 = 116,  f6 = 117,
   f7 = 118, f8 = 119, f9 = 120, f10 = 121, f11 = 122, f12 = 123
}

objcode = {
   arrow = 0,
   small_box = 1,
   box = 2,
   small_plank = 3,
   plank = 4,
   ball = 6,
   trampoline = 7,
   anvil = 10,
   anvil1 = 1002,
   B = 11,
   Bc = 12,
   Bcc = 13,
   V = 14,
   Vc = 15,
   Vcc = 16,
   cannon_up = 17,
   cannon_down = 18,
   cannon_right = 19,
   cannon_left = 20,
   C = 22,
   bomb = 23,
   spirit = 24,
   cheese = 25,
   blue_portal = 26,
   orange_portal = 27,
   balloon = 28,
   red_balloon = 29,
   green_balloon = 30,
   yellow_balloon = 31,
   rune = 32,
   snow = 34,
   arrow1 = 35,
   apple = 39,
   sheep = 40,
   demolition = 41,
   totem = 44,
   ice_plank = 45,
   choco_plank = 46,
   cloud = 57,
   architect = 58,
   bubble = 59,
   tiny_plank = 60,
   companion_crate = 61,
   stable_rune = 62,
   ballon_anchor = 66,
   windmill_anchor = 88
}

for k, v in pairs(tfm.enum.shamanObject) do
   objcode[k] = v
end

do
   local t = {'<font face="mono" size="15">'}
   local i

   for k, v in pairs(objcode) do
      i = 15 - #k
      if i > 0 then
         k = k .. string.rep(' ', i)
      end

      table.insert(t, string.format('%s = %02d\n', k, v))
   end

   table.insert(t, '</font>')
   MODULE_HELP['Shaman objects'] = table.concat(t)
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

function copy(dst, src)
   if src ~= nil then
      for k, v in pairs(src) do
         dst[k] = v
      end
   end
end

function split(str)
   local ret = {}
   for s in string.gmatch(str, '[^%s]+') do
      table.insert(ret, s)
   end
   return ret
end

function invert(t, value)
   local ret = {}
   if value == nil then
      for k, v in pairs(t) do
         ret[v] = k
      end
   else
      for k, v in pairs(t) do
         ret[v] = value
      end
   end
   return ret
end

function randomKey1(tbl, excl_key, do_exclude)
   local keys, i = {}, 1

   for k,_ in pairs(tbl) do
      if not (k == excl_key) then
         keys[i] = k
         i = i + 1
      end
   end

   if i > 1 then
      return keys[math.random(1,#keys)]
   elseif do_exclude then
      return nil
   else
      return excl_key
   end
end

function randomValue1(tbl, excl_key, do_exclude)
   local k = randomKey1(tbl, excl_key, do_exclude)

   if k ~= nil then
      return tbl[k]
   else
      return nil
   end
end

---------------------------------------------------------------------------

function alert(str, name)
   ui.addPopup(0, 0, string.format('<font face="mono" size="15">%s</font>', str), name, 200, 150, 400)
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

   return string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',
                        string.rep('★', lives),
                        string.rep('★', bombs)
   )
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

function pattern(name, data, btype, bcode, point)
   local pat = data.patterns[btype][bcode]
   if pat ~= nil then
      if #pat.points >= pat.type.points - 1 then
         local time = os.time()
         if time - pat.lastTime >= pat.type.cd then
            pat.lastTime = time
            table.insert(pat.points, point)
            addPattern(name, data, pat.type, pat.points)
            pat.points = {}
         end
      else
         table.insert(pat.points, point)
      end
   end
end

function bind(name, btype, bcode, pid)
   local data = playerData[name]
   local p = data.patterns[btype]

   if p[bcode] ~= nil then
      do_unbind(data, p, btype, bcode)
   end

   p[bcode] = {
      id = pid,
      type = patternTypes[pid],
      points = {},
      lastTime = 0
   }

   p = data.pattern_data[pid]

   if p == nil then
      data.pattern_data[pid] = {
         binds = 1
      }
   else
      p.binds = p.binds + 1
   end
end

function do_unbind(data, p, btype, bcode)
   local pdata = data.pattern_data[p.id]
   if pdata.binds <= 1 then
      data.pattern_data[p.id] = nil
   else
      pdata.binds = pdata.binds - 1
   end
   data.patterns[btype][bcode] = nil
end

function unbind(name, btype, bcode)
   local data = playerData[name]
   if btype == nil then
      data.patterns = {
         key = {},
         obj = {},
         objend = {}
      }
      data.pattern_data = {}
   elseif bcode == nil then
      local u = {}

      for k, v in pairs(data.patterns[btype]) do
         table.insert(u, { k, v })
      end

      for k, v in ipairs(u) do
         do_unbind(data, v[2], btype, v[1])
      end
   else
      local p = data.patterns[btype][bcode]
      if p ~= nil then
         do_unbind(data, p, btype, bcode)
      end
   end
end

---------------------------------------------------------------------------

function defaultShot(name, data)
   local player = tfm.get.room.playerList[name]
   local x, y = player.x, player.y
   local k
   if player.isFacingRight then
      k = '-1,0'
      x = x + 32
   else
      k = '1,0'
      x = x - 32
   end
   local id = addGround(x, y + 32, {type=13, width=8, height=8, restitution=255, mass=10, dynamic=true, miceCollision=true, groundCollision=false, color='0xFFFFFF'}, 6)
   addJoint(id, 0, {color='0x00FFFF', line=2, type=1, axis=k, forceMotor=100, speedMotor=100}, 6)
   id = addGround(x, y - 32, {type=13, width=8, height=8, restitution=255, mass=10, dynamic=true, miceCollision=true, groundCollision=false, color='0xFFFFFF'}, 6)
   addJoint(id, 0, {color='0x00FFFF', line=2, type=1, axis=k, forceMotor=100, speedMotor=100}, 6)
end

function homingShot(name, data)
   local target = randomKey1(tfm.get.room.playerList, name, false)
   local player = tfm.get.room.playerList[name]
   local x = player.x
   local y = player.y
   local vx = 2
   local vy = 2
   local g = false

   if not player.isFacingRight then
      vx = -vx
   end

   x = x + 16 * vx

   local args = {
      target = target,
      x = x,
      y = y + 32,
      v = 128
   }

   addObject(tfm.enum.shamanObject.anvil, x + vx, y + vy, 0, vx, vy, g, 10, moveHoming, args)

   local args = {
      target = target,
      x = x,
      y = y - 32,
      v = 128
   }

   addObject(tfm.enum.shamanObject.anvil, x + vx, y - vy, 0, vx, -vy, g, 10, moveHoming, args)
end

---------------------------------------------------------------------------

function nop(...)
end

function defaultBomb(name, data)
   addBombTimer(name, tfm.get.room.playerList[name], data, true, 5)
end

function testBombCallback(name, data)
   local player = tfm.get.room.playerList[name]

   local yc = player.y + player.vy
   local xb

   local x, y
   local k = data.bombCallbackArgs

   local ttl = 4

   local vx = 0
   local vy = 0

   local a = { ax = 64, ay = 0 }

   vx = k * vx
   a.ax = k * a.ax
   xb = player.x + k * data.bombTime * 5 + 10

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

   addBombTimer(name, player, data, true, 5)
end

---------------------------------------------------------------------------

function testPattern(name, data, id, points)
   local p = points[1]

   local n = 6
   local r = 48
   local v = math.random(2, 8)

   local a, c, s
   local a0 = p.angle * math.pi / 180.0

   for i = 0, n - 1 do
      a = a0 + 2.0 * math.pi * i / n
      c, s = math.cos(a), math.sin(a)

      addObject(p.type,
                p.x + r * c, p.y + r * s,
                p.angle + 360 * i / n,
                v * c, v * s,
                false,
                9)
   end
end

---------------------------------------------------------------------------

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

---------------------------------------------------------------------------

function addBombTimer(name, player, data, protect, scale)
   addGround(
      player.x,
      player.y,
      {
         type = 13,
         angle = 0,
         color = '0xFF0000',
         foreground = false,
         friction=0.0,
         restitution=2.0,
         width = data.bombTime * scale + 2,
         height = data.bombTime * scale + 2,
         miceCollision = false,
         groundCollision = protect,
         dynamic = false
      },
      data.bombTime,
      moveBombTimer,
      {
         player = name,
         pdata = data,
         offset = 2,
         scale = scale
      }
   )

   addGround(
      player.x,
      player.y,
      {
         type = 13,
         angle = 0,
         color = '0x6A7495',
         foreground = false,
         friction=0.0,
         restitution=2.0,
         width = data.bombTime * scale,
         height = data.bombTime * scale,
         miceCollision = false,
         groundCollision = protect,
         dynamic = false
      },
      data.bombTime,
      moveBombTimer,
      {
         player = name,
         pdata = data,
         offset = 0,
         scale = scale
      }
   )
end

function moveBombTimer(id, data)
   local a = data.callback_args
   local player = tfm.get.room.playerList[a.player]
   local sz = a.pdata.bombTime * a.scale + a.offset
   moveGround(id, player.x, player.y, { width = sz, height = sz })
end

---------------------------------------------------------------------------

playerData = {}
objectData = {}
groundData = {}
jointData = {}
patternData = {}

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

bombs = {
   top = 0,
   val = {}
}

playerKeys = { 32, 83, 40, 100, 101, 102, 104, 81, 68, 69, 82, 87, 37, 39 }
reservedKeys = invert(playerKeys, true)

shotTypes = {
   {
      func = defaultShot,
      cd = 1
   },
   {
      func = homingShot,
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
      time = 20,
      cd = 0
   }
}

patternTypes = {
   {
      func = testPattern,

      time = 0,
      callback = nil,

      cd = 250,
      points = 1,

      maxBinds = 3,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   }
}

eventCode = {
   key = keycode,
   obj = objcode,
   objend = objcode
}

playerConfig = {
   Cafecafe = {
      color='0xB06FFD'
   }
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
      ttl = 3
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

function addPattern(name, data, ptype, points)
   local id = nil

   if ptype.time ~= nil then
      id = newId(patternId)

      patternData[id] = {
         time = ptype.time,
         callback = ptype.callback,
         on_remove = ptype.on_remove
      }
   end

   ptype.func(name, data, id, points)

   return id
end

function removePattern(id)
   patternData[id] = nil
   freeId(patternId, id)
end

---------------------------------------------------------------------------

function initPlayer(name)
   local data = {
      color = randomColor(),

      shooting = false,
      bombing = false,

      shot = shotTypes[1],

      bomb = bombTypes[1],
      bombTime = nil,

      patterns = {
         key = {},
         obj = {},
         objend = {}
      },
      pattern_data = {},

      lives = 5,
      bombs = 3,
      resetBombs = 3,

      shot_cd = 0,
      bomb_cd = 0,

      bomb_id = nil
   }

   if playerConfig[name] == nil then
      playerConfig[name] = {}
   end

   copy(data, playerConfig[name])

   playerData[name] = data

   for k, v in pairs(playerKeys) do
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

function resetPlayer(name)
   local reset = {
      shooting = false,
      bombing = false,
      bombTime = nil,

      lives = 5,
      bombs = 3,

      shot_cd = 0,
      bomb_cd = 0,

      bomb_id = nil
   }

   local data = playerData[name]

   copy(data, reset)

   updateTextAreas(name, data)

   tfm.exec.respawnPlayer(name)
   tfm.exec.setShaman(name)
   tfm.exec.setNameColor(name, data.color)
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

function step(t, remove, list, do_list)
   local ids = {}
   local tm

   if do_list == nil then
      do_list = function(list, k, v)
         table.insert(list, string.format("%d %d\n", k, v.time))
      end
   end

   for k, v in pairs(t) do
      do_list(list, k, v)

      tm = v.time

      if tm == 0 then
         if v.on_remove then
            v.on_remove(k, v)
         end
         table.insert(ids, k)
      elseif tm > 0 then
         v.time = tm - 1
         if v.callback then
            v.callback(k, v)
            --if not pcall(v.callback, k, v) then
            --   table.insert(ids, k)
            --end
         end
      elseif v.callback then
         v.callback(k, v)
         --if not pcall(v.callback, k, v) then
         --   table.insert(ids, k)
         --end
      end
   end

   for k, v in ipairs(ids) do
      remove(v)
   end
end

function list_object(list, k, v)
   local t = tfm.get.room.objectList[k]
   if t == nil then
      table.insert(list, string.format("%d &lt;invalid&gt; %d\n", k, v.time))
   else
      table.insert(list, string.format("%d (%d, %d) %d\n", k, t.x, t.y, v.time))
   end
end

function clearT()
   local str = { "<TI>--[Objects]--\n" }
   step(objectData, removeObject, str, list_object)

   table.insert(str, "--[Grounds]--\n")
   step(groundData, removeGround, str)

   table.insert(str, "--[Joints]--\n")
   step(jointData, removeJoint, str)

   table.insert(str, "--[Patterns]--\n")
   step(patternData, removePattern, str)

   ui.addTextArea(2, table.concat(str), nil, -150, 0, 150, 600)
end

---------------------------------------------------------------------------

eventNewPlayer = initPlayer
eventPlayerLeft = deletePlayer

function parsePlayerNames(name, arg, func)
   local players = {}
   local b

   for k, v in pairs(split(string.lower(arg))) do
      if string.sub(v, 1, 1) == '!' then
         v = string.sub(v, 2)
         b = nil
      else
         b = true
      end

      if v == 'me' then
         players[name] = b
      elseif v == 'all' then
         for k, v in pairs(tfm.get.room.playerList) do
            players[k] = b
         end
      else
         v = string.gsub(v, '^%l', string.upper)
         if tfm.get.room.playerList[v] == nil then
            alert('Invalid player: ' .. v, name)
            return
         else
            players[v] = b
         end
      end
   end

   for k, v in pairs(players) do
      func(k)
   end
end

function eventChatCommand(name, message)
   local i, j
   local cmd, arg

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
         playerConfig[name].color = nil
      else
         local argv = tonumber(arg)
         if argv ~= nil then
            if argv > 0xFFFFFF then
               argv = 0xFFFFFF
            end
            arg = string.format('0x%X', argv)
            setColor(name, arg)
            playerConfig[name].color = arg
         else
            alert('Invalid color: ' .. arg, name)
         end
      end
   elseif cmd == 'reset' then
      arg = string.lower(arg)
      if arg == '' or arg == 'map' then
         setMap(defaultMap)
      else
         parsePlayerNames(name, arg, resetPlayer)
      end
   elseif cmd == 'init' then
      local f = function(name)
         deletePlayer(name)
         initPlayer(name)
      end
      parsePlayerNames(name, arg, f)
   elseif cmd == 'respawn' or cmd == 'spawn' then
      parsePlayerNames(name, arg, respawn)
   elseif cmd == 'shot' then
      local n = tonumber(arg)

      if n == nil then
         alert('Invalid shot type: ' .. arg, name)
         return
      end

      n = shotTypes[n]

      if n ~= nil then
         playerData[name].shot = n
      else
         alert('Invalid shot type: ' .. arg, name)
      end
   elseif cmd == 'bomb' then
      local n = tonumber(arg)

      if n == nil then
         alert('Invalid bomb type: ' .. arg, name)
         return
      end

      n = bombTypes[n]

      if n ~= nil then
         playerData[name].bomb = n
      else
         alert('Invalid bomb type: ' .. arg, name)
      end
   elseif cmd == 'bind' then
      arg = split(arg)
      if #arg < 3 then
         alert('Too few arguments', name)
         return
      elseif #arg > 3 then
         alert('Too many arguments', name)
         return
      end

      i = tonumber(arg[1])
      local p = patternTypes[i]
      if i == nil or p == nil then
         alert('Invalid pattern: ' .. arg[1], name)
         return
      end

      j = arg[2]
      if j ~= 'key' and j ~= 'obj' and j ~= 'objend' then
         alert('Invalid type: ' .. j, name)
         return
      end

      local k = tonumber(arg[3])
      if k == nil then
         k = eventCode[j][arg[3]]
         if k == nil then
            alert(string.format('Invalid %s name/code: %s', j, arg[3]), name)
            return
         end
      end

      if p.restrict[j] ~= nil and p.restrict[j][k] == nil then
         alert(string.format('Can\'t bind pattern %d to %s %d: restricted',
                             i, j, k),
               name
         )
         return
      end

      if j == 'key' and reservedKeys[k] then
         alert(string.format('Can\'t bind pattern %d to %s %d: reserved',
                             i, j, k),
               name
         )
         return
      end

      local data = playerData[name]
      local pd = data.pattern_data[i]

      if pd ~= nil and p.maxBinds <= pd.binds then
         alert(string.format('Can\'t bind pattern %d to more than %d events',
                             i, p.maxBinds),
               name
         )
         return
      end

      bind(name, j, k, i)
   elseif cmd == 'unbind' then
      arg = split(arg)
      if #arg > 2 then
         alert('Too many arguments', name)
         return
      end

      i = arg[1]
      if i == 'all' or i == nil then
         unbind(name)
      elseif i ~= 'key' and i ~= 'obj' and i ~= 'objend' then
         alert('Invalid type: ' .. i, name)
         return
      else
         if arg[2] == nil then
            unbind(name, i)
         else
            j = tonumber(arg[2])
            if j == nil then
               j = eventCode[i][arg[2]]
               if j == nil then
                  alert(string.format('Invalid %s name/code: %s', i, arg[2]), name)
                  return
               end
            end
            unbind(name, i, j)
         end
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

   objectData = {}
   groundData = {}
   jointData = {}
   patternData = {}

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

   for name, player in pairs(tfm.get.room.playerList) do
      resetPlayer(name)
   end

   tfm.exec.setUIMapName('<TI>')
   tfm.exec.setUIShamanName('')

   tfm.exec.addPhysicObject(0, 0, 0, {type=13, width=10, height=10, color='0xFFFFFF', dynamic=false, miceCollision=false, groundCollision=false})
end

function eventKeyboard(name, key, down, x, y)
   if reservedKeys[key] then
      if key == 82 then
         local data = playerData[name]
         if down then
            bomb(name, data)
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
   elseif down then
      pattern(name, playerData[name], 'key', key, { ['x'] = x, ['y'] = y })
   end
end

function eventSummoningStart(name, type, x, y, angle)
   local point = {
      ['x'] = x,
      ['y'] = y,
      ['angle'] = angle,
      ['type'] = type
   }

   pattern(name, playerData[name], 'obj', type, point)
end

function eventSummoningEnd(name, type, x, y, angle, vx, vy, data, other)
   objectData[data.id] = {
      time = 3
   }

   local point = {
      ['x'] = x,
      ['y'] = y,
      ['angle'] = angle,
      ['type'] = type,
      ['vx'] = vx,
      ['vy'] = vy,
      ['data'] = data,
      ['other'] = other
   }

   pattern(name, playerData[name], 'objend', type, point)
end

function eventMouse(name, x, y)
   local player = tfm.get.room.playerList[name]
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
         data.bombTime = data.bombTime - 1
         if data.bombTime <= 0 then
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
         ui.updateTextArea(101, string.format('<TI><p align="center">%s</p>', callback), name)
      end
   end
end

system.disableChatCommandDisplay('help', true)

for k, v in pairs(tfm.get.room.playerList) do
   initPlayer(k)
end

setMap(defaultMap)
