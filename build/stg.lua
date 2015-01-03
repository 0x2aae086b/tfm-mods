do_addObject = tfm.exec.addShamanObject
do_removeObject = tfm.exec.removeObject
do_addGround = tfm.exec.addPhysicObject
do_removeGround = tfm.exec.removePhysicObject
do_addJoint = tfm.exec.addJoint
do_removeJoint = tfm.exec.removeJoint
do_respawn = tfm.exec.respawnPlayer
do_addExplosion = tfm.exec.explosion
addParticle = tfm.exec.displayParticle
setShaman = tfm.exec.setShaman
setShamanName = tfm.exec.setUIShamanName
setMapName = tfm.exec.setUIMapName
setNameColor = tfm.exec.setNameColor
movePlayer = tfm.exec.movePlayer
moveObject = tfm.exec.moveObject
setMap = tfm.exec.newGame
bindKey = tfm.exec.bindKeyboard
kill = tfm.exec.killPlayer
function nop()
end

function to_table(x)
   if x == nil or type(x) == 'table' then
      return x
   else
      return { x }
   end
end

function alert(str, name)
   ui.addPopup(0, 0, string.format('<font face="mono" size="15">%s</font>', str), name, 200, 150, 400, true)
end

function randomColor()
   return math.random(0x000000, 0xFFFFFF)
end

function rotate(x, y, x0, y0, cos, sin)
   x, y = x - x0, y - y0
   x, y = x * cos - y * sin, x * sin + y * cos
   return x0 + x, y0 + y
end

function length1(v)
   return math.sqrt(v.x * v.x + v.y * v.y)
end

function cache2(func)
   local _cache = {}

   return function(x, y)
      local c = _cache[x]
      local ret = nil
      if c == nil then
         c = {}
         _cache[x] = c
      else
         ret = c[y]
      end

      if ret == nil then
         ret = func(x, y)
         c[y] = ret
      end

      return ret
   end
end

function split(str)
   local ret = {}
   for s in string.gmatch(str, '[^%s]+') do
      ret[#ret + 1] = s
   end
   return ret
end

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
         for k, v in pairs(playerData) do
            players[k] = b
         end
      else
         v = string.gsub(v, '^%l', string.upper)
         if playerData[v] == nil then
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

unescape_map = {
   a = '\a', b = '\b', f='\f', n = '\n', r = '\r', t = '\t'
}

function do_unescape(c, n)
   local num = tonumber(c .. n)
   if num == nil then
      return (unescape_map[c] or c) .. n
   else
      return string.char(num)
   end
end

function unescape(str)
   return string.gsub(str, '\\(.)(%d?%d?)', do_unescape)
end

function do_unpack(t, i, n)
   if i <= n then
      return t[i], do_unpack(t, i + 1, n)
   else
      return nil
   end
end

function unpack(t, n)
   if n == nil then
      n = #t
   end
   return do_unpack(t, 1, n)
end

function length(tbl)
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

function append(dst, src)
   for _, v in ipairs(src) do
      dst[#dst + 1] = v
   end
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

function keys(t)
   local ret = {}
   for k, _ in pairs(t) do
      ret[#ret + 1] = k
   end
   return ret
end

function keys1(t)
   local ret = keys(t)
   table.sort(ret)
   return ret
end

function randomKey1(tbl, excl_key, do_exclude)
   local keys, i = {}, 1

   for k, _ in pairs(tbl) do
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
function help(name)
   ui.addTextArea(100, MODULE_HELP[MODULE_HELP_START], name, 258, 78, 421, 284, nil, nil, nil, true)
   ui.addTextArea(101, string.format('<p align="center"><font face="mono" size="15">%s</font></p>', MODULE_HELP_START), name, 258, 50, 398, 20, nil, nil, nil, true)
   ui.addTextArea(102, MODULE_HELP_CONTENTS, name, 100, 50, 150, 312, nil, nil, nil, true)
   ui.addTextArea(103, MODULE_HELP_CLOSE, name, 664, 50, 15, 20, nil, nil, nil, true)
end

function helpTextAreaCallback(id, name, callback)
   if callback == 'help' then
      help(name)
   elseif callback == 'help_close' and id == 103 then
      ui.removeTextArea(100, name)
      ui.removeTextArea(101, name)
      ui.removeTextArea(102, name)
      ui.removeTextArea(103, name)
   else
      local str = MODULE_HELP[callback]
      if str ~= nil then
         ui.updateTextArea(100, str, name)
         ui.updateTextArea(101, string.format('<font face="mono" size="15"><p align="center">%s</p></font>', callback), name)
      else
         return false
      end
   end
   return true
end
function eventChatCommand(name, message)
   local i, j
   local cmd, arg

   for k, v in ipairs({{'&lt;', '<'}, {'&amp;', '&'}}) do
      message = string.gsub(message, v[1], v[2])
   end

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

   local cmdl = string.lower(cmd)
   local func = MODULE_CHAT_COMMAND[cmdl]

   if func ~= nil then
      func(name, cmdl, arg)
   else
      MODULE_CHAT_COMMAND_1(name, cmd, arg)
   end
end
function setColor(name, color)
   setNameColor(name, color)
   playerData[name].color = color
end

function tbl_name(t)
   if t == groundId then
      return 'groundId'
   elseif t == jointId then
      return 'jointId'
   elseif t == bulletId then
      return 'bulletId'
   elseif t == patternId then
      return 'patternId'
   elseif t == objectData then
      return 'objectData'
   elseif t == groundData then
      return 'groundData'
   elseif t == jointData then
      return 'jointData'
   elseif t == bulletData then
      return 'bulletData'
   elseif t == patternData then
      return 'patternData'
   end
   return '&lt;other&gt;'
end

function make_line(v0, v1)
   local dx, dy = v1[1] - v0[1], v1[2] - v0[2]

   return {
      width = math.sqrt(dx * dx + dy * dy),
      angle = math.atan2(dy, dx) * 180.0 / math.pi,
      x = (v0[1] + v1[1]) / 2,
      y = (v0[2] + v1[2]) / 2
   }
end

make_star = cache2(
   function(n, s)
      local tmp = {}
      local ret = {}

      for i = 1, n do
         a = math.pi * 2 * i / n
         tmp[#tmp + 1] = { math.cos(a), math.sin(a) }
      end

      for i = 1, n do
         ret[#ret + 1] = make_line(tmp[i], tmp[1 + (i + s - 1) % n])
      end

      local r = length1(ret[1])

      return { lines=ret, points=tmp, r=r, l=math.sqrt(1 - r*r) }
   end
)

--[[
function line(x0, y0, x1, y1, width, other)
   local x, y = x1 - x0, y1 - y0

   local obj = {
      type = 12,
      width = math.sqrt(x * x + y * y),
      height = h,
      color = 0xFFFFFF,
      groundCollision = false,
      miceCollision = true,
      angle = math.atan2(y, x) * 180.0 / math.pi,
      restitution = 255,
      dynamic = true
   }

   if other ~= nil then
      copy(obj, other)
   end

   id = id + 1

   tfm.exec.addPhysicObject(id, (x0 + x1) / 2, (y0 + y1) / 2, obj)

   return id
end
]]--
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

   a = 81, b = 66, c = 67, d = 68, e = 69, f = 70, g = 71, h = 72, i = 73,
   j = 74, k = 75, l = 76, m = 77, n = 78, o = 79, p = 80, q = 65, r = 82,
   s = 83, t = 84, u = 85, v = 86, w = 90, x = 88, y = 89, z = 87,

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

particles = {
   white = 0,
   purple = 1,
   orange = 2,
   soft_white = 4,
   teal = 9,
   yellow = 11,
   red = 13,

   spawn = 3,

   heart = 5,
   red_heart = 30,
   pink_heart = 31,

   bubble = 6,
   bubble1 = 7,
   bubble2 = 8,
   water = 14,

   spirit = 10,
   red_spirit = 12,

   plus1 = 15,
   plus10 = 16,
   plus12 = 17,
   plus14 = 18,
   plus16 = 19,

   meep = 20,

   red_confetti = 21,
   green_confetti = 22,
   blue_confetti = 23,
   yellow_confetti = 24,

   rain = 25,
   wind = 26,
   wind1 = 27,
   lightning = 28,

   star = 29,
   flower = 32
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
   balloon1 = 2806,
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

copy(objcode, tfm.enum.shamanObject)
function addError(name, err)
   err = string.format("• %s\n", err)
   local l = #errors
   if l == MAX_ERRORS then
      for i = 3, l do
         errors[i] = errors[i - 1]
      end
      errors[2] = err
   else
      errors[l + 1] = err
   end
   ui.addTextArea(3, table.concat(errors), nil, 805, 5, 200, 590, nil, nil, 0.5, true)
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
function clear()
   for _, v in ipairs(keys(jointData)) do
      removeJoint(v)
   end
   for _, v in ipairs(keys(tfm.get.room.objectList)) do
      removeObject(v)
   end
   for _, v in ipairs(keys(groundData)) do
      removeGround(v)
   end
   for _, v in ipairs(keys(bulletData)) do
      removeBullet(v)
   end
   for _, v in ipairs(keys(patternData)) do
      removePattern(v)
   end
   --[[
   bombs = {
      top = 0,
      val = {}
   }

   setShamanName('')

   for k, v in pairs(playerData) do
      v.shooting = false
      v.bombing = false
   end
   ]]--
end

function list_default(t, k, v)
   t[#t + 1] = string.format('%d %d\n', k, v.time)
end

function list_object(t, k, v)
   local t1 = tfm.get.room.objectList[k]
   if t1 == nil then
      t[#t + 1] = string.format('%d &lt;invalid&gt; %d\n', k, v.time)
   else
      t[#t + 1] = string.format('%d (%d, %d) %d\n', k, t1.x, t1.y, v.time)
   end
end

function list_bullet(t, k, v)
   t[#t + 1] = string.format("%d %d %d\n", k, v.controls[#v.controls], v.time)
end

function step(t, remove, list, do_list)
   local ids = {}
   local tm
   local st, err

   if do_list == nil then
      do_list = list_default
   end

   for k, v in pairs(t) do
      do_list(list, k, v)

      tm = v.time

      if tm == 0 then
         if v.on_remove then
            for k1, v1 in ipairs(v.on_remove) do
               st, err = pcall(v1, k, v)
               if not st then
                  addError(nil,
                           string.format("step(%s): on_remove[%d]: %s\n",
                                         tbl_name(t), k1, err))
               end
            end
         end
         ids[#ids + 1] = k
      elseif tm > 0 then
         v.time = tm - 1
         if v.callback then
            for k1, v1 in ipairs(v.callback) do
               st, err = pcall(v1, k, v)
               if not st then
                  addError(nil,
                           string.format("step(%s): callback[%d]: %s\n",
                                         tbl_name(t), k1, err))
                  ids[#ids + 1] = k
                  break
               end
            end
         end
      elseif v.callback then
         for k1, v1 in ipairs(v.callback) do
            st, err = pcall(v1, k, v)
            if not st then
               addError(nil,
                        string.format("step(%s): callback[%d]: %s\n",
                        tbl_name(t), k1, err))
               ids[#ids + 1] = k
               break
            end
         end
      end
   end

   for _, v in ipairs(ids) do
      remove(v)
   end
end

function clearT()
   local str = { '<TI>' }

   str[#str + 1] = '<p align="center">Joints</p>'
   step(jointData, removeJoint, str)

   str[#str + 1] = '<p align="center">Objects</p>'
   step(objectData, removeObject, str, list_object)

   str[#str + 1] = '<p align="center">Grounds</p>'
   step(groundData, removeGround, str)

   str[#str + 1] = '<p align="center">Bullets</p>'
   step(bulletData, removeBullet, str, list_bullet)

   str[#str + 1] = '<p align="center">Patterns</p>'
   step(patternData, removePattern, str)

   ui.addTextArea(2, table.concat(str), nil, -155, 5, 150, 590, nil, nil, 0.5, true)
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
function newId(ids)
   local free = ids.free
   local k, v = pairs(free)(free)
   if k then
      free[k] = nil
      return k
   else
      if ids.max == MAX_ID then
         error(string.format("newId: %s.max == MAX_ID", tbl_name(ids)))
      end
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

function addObject(type, x, y, angle, vx, vy, ghost, ttl, func, func1, args)
   local id = do_addObject(type, x, y, angle, vx, vy, ghost)

   if ttl == nil then
      ttl = 3
   end

   objectData[id] = {
      time = ttl,
      callback = to_table(func),
      on_remove = to_table(func1),
      callback_args = args
   }

   return id
end

function removeObject(id)
   do_removeObject(id)
   objectData[id] = nil
end

function addGround(x, y, other, ttl, func, func1, args)
   local id = newId(groundId)

   do_addGround(id, x, y, other)

   if ttl == nil then
      ttl = 3
   end

   groundData[id] = {
      time = ttl,
      callback = to_table(func),
      on_remove = to_table(func1),
      callback_args = args,
   }

   return id
end

function removeGround(id)
   do_removeGround(id)
   groundData[id] = nil
   freeId(groundId, id)
end

function addJoint(ground0, ground1, other, ttl, func, func1, args)
   local id = newId(jointId)

   do_addJoint(id, ground0, ground1, other)

   if ttl == nil then
      ttl = -1
   end

   if other == nil then
      other = {}
   end

   jointData[id] = {
      time = ttl,
      callback = to_table(func),
      on_remove = to_table(func1),
      callback_args = args
   }

   return id
end

function removeJoint(id)
   do_removeJoint(id)
   jointData[id] = nil
   freeId(jointId, id)
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

function addExplosion(x, y, power, distance, miceOnly, particle1, particle2)
   if particle1 ~= nil then
      addParticle(particle1, x, y, 0, 0, 0, 0)
   end

   if particle2 ~= nil then
   end

   do_addExplosion(x, y, power, distance, miceOnly)
end
function addGround1(t, x, y, other)
   local id = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id
   do_addGround(id, x, y, other)
   t[#t + 1] = id
end

function addJoint1(t, id1, id2, other)
   local id = newId(jointId)
   _tmp_joints[#_tmp_joints + 1] = id
   do_addJoint(id, id1, id2, other)
   t[#t + 1] = id
end

function do_addControl(controls, control)
   controls[#controls + 1] = control
end

function do_removeControl(controls, control)
   local i = #controls
   while i > 0 and controls[i] ~= control do
      controls[i] = nil
      i = i - 1
   end
   --[[if i > 0 then
      while controls[i] do
         controls[i] = nil
         i = i + 1
      end
   end]]--
end

function addBullet(btype, ttl, callback, on_remove, args, ...)
   local id = newId(bulletId)

   _tmp_grounds = {}
   _tmp_joints = {}
   local st, control, grounds, joints = pcall(btype, ...)

   if st then
      bulletData[id] = {
         controls = { control },
         grounds = grounds,
         joints = joints,
         time = ttl or 6,
         callback = to_table(callback),
         on_remove = to_table(on_remove),
         callback_args = args
      }
   else
      for _, v in ipairs(_tmp_joints) do
         removeJoint(v)
      end
      for _, v in ipairs(_tmp_grounds) do
         removeGround(v)
      end
      freeId(bulletId, id)
      error(string.format('addBullet: %s', control))
   end

   return id
end

function removeBullet(id)
   local data = bulletData[id]

   for k, v in ipairs(data.joints) do
      do_removeJoint(v)
      freeId(jointId, v)
   end

   for k, v in ipairs(data.grounds) do
      do_removeGround(v)
      freeId(groundId, v)
   end

   bulletData[id] = nil
   freeId(bulletId, id)
end
bullet = {}

bullet.circle = function(x, y, R, jdata, hitbox_data)
   local point2 = string.format('%d,%d', x, y + 1)

   local joint = {
      type = 0,
      point2 = point2,
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
      restitution = 255,
      color = 0xFFFFFF
   }

   copy(hitbox, hitbox_data)

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, hitbox)

   local joints = {}

   if jdata then
      for _, v in ipairs(jdata) do
         copy(joint, v)
         addJoint1(joints, id0, id0, joint)
      end
   end

   return id0, {id0}, joints
end

bullet.butterfly = function(x, y, angle, R, center_jdata, wing_jdata, hitbox_data)
   local star = make_star(5, 2)

   local wing = {
      type = 0,
      color = 0xFF00FF,
      alpha = 0.25,
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
      miceCollision = true,
      groundCollision = false,
      restitution = 255,
      color = 0xFFFFFF
   }

   copy(wing, wing_jdata)
   copy(hitbox, hitbox_data)

   local joints = {}
   local pts = {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)

   local v

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, hitbox)

   for i = 2, 5 do
      v = star.points[i]
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      x1, y1 = x + R * x1, y + R * y1

      wing.point1 = string.format('%d,%d', x1, y1)
      wing.point2 = string.format('%d,%d', x1, y1 + 1)
      addJoint1(joints, id0, id0, wing)
   end

   if center_jdata then
      for _, v in ipairs(center_jdata) do
         copy(center, v)
         addJoint1(joints, id0, id0, center)
      end
   end

   return id0, {id0}, joints
end

bullet.jstar = function(x, y, angle, R, points, step, line_jdata, center_jdata, hitbox_data)
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
      miceCollision = true,
      groundCollision = false,
      restitution = 255
   }

   copy(line, line_jdata)
   copy(center, center_jdata)
   copy(hitbox, hitbox_data)

   local joints = {}
   local pts = {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)

   for k, v in ipairs(star.points) do
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      pts[#pts + 1] = string.format('%d,%d', x + R * x1, y + R * y1)
   end

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, hitbox)

   for i = 1, points do
      line.point1 = pts[i]
      line.point2 = pts[1 + (i + step - 1) % points]
      addJoint1(joints, id0, id0, line)
   end

   addJoint1(joints, id0, id0, center)

   return id0, {id0}, joints
end

bullet.star = function(x, y, angle, R, points, step, do_cap, line_data, center_data, cap_data)
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
   local a = angle * 180.0 / math.pi
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

   local id0 = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id0
   do_addGround(id0, x, y, center)

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
   lines[#lines + 1] = id0

   return id0, lines, joints
end
function bomb(name, data)
   if data.bomb_cd == 0 and not data.bombing then
      if data.bombs >= data.bomb.cost then
         data.bombs = data.bombs - data.bomb.cost
         data.bombing = true
         data.bombTime = data.bomb.time
         local st, err = pcall(data.bomb.func, name, data)
         addBomb(name, data)
         updateTextAreas(name, data)
         if not st then
            addError(name, string.format("bomb: %s: %s", name, err))
         end
      else
         alert(string.format('bombs &lt; %d', data.bomb.cost), name)
      end
   end
end

function addBomb(name, data)
   local i = bombs.top + 1
   local str = string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>', data.color, name, data.bomb.name)
   data.bomb_id = i
   bombs.top = i
   bombs.val[i] = str
   setShamanName(str)
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

      setShamanName(i)
   end
end
function motionEnd(id, data)
   do_removeControl(data.callback_args._controls, id)
end

function addControl(controls, ...)
   local id = addGround(...)
   local data = groundData[id]
   if data.callback_args == nil then
      data.callback_args = { _controls = controls }
   else
      data.callback_args._controls = controls
   end
   if data.on_remove == nil then
      data.on_remove = motionEnd
   else
      data.on_remove[#data.on_remove + 1] = motionEnd
   end
   controls[#controls + 1] = id
   return id
end

function addControl1(controls, ...)
   return addGround(...)
end

function addMotion(mtype, id, is_bullet, ...)
   local data
   local ac
   if is_bullet then
      data = bulletData[id].controls
      ac = addControl
   else
      data = { id }
      ac = addControl1
   end
   local st, err = pcall(mtype, ac, data, ...)
   if not st then
      error(string.format("addMotion: %s", err))
   end
end
motion = {}

motion.line = function(ac, controls, last, ttl, joint_data, x, y)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 1,
      axis = '-1,0',
      angle = 0,
      forceMotor = 255,
      speedMotor = 1
   }
   copy(joint, joint_data)
   if not last then
      local control = {
         type = 13,
         dynamic = true,
         mass = 1,
         groundCollision = false,
         miceCollision = false
      }
      id = ac(controls, x or 0, y or 0, control, ttl or 3)
   end
   addJoint(id1, id, joint, ttl or 3)
end

motion.circle = function(ac, controls, last, ttl, joint_data, x, y)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 3,
      forceMotor = 255,
      speedMotor = 1
   }
   copy(joint, joint_data)
   if not last then
      local control = {
         type = 13,
         dynamic = true,
         mass = 1,
         groundCollision = false,
         miceCollision = false,
      }
      id = ac(controls, x or 0, y or 0, control, ttl or 3)
   end
   if x and y then
      joint.point1 = string.format('%d,%d', x, y)
   end
   addJoint(id1, id, joint, ttl or 3)
end

motion.spiral = function(ac, controls, last, ttl, tjoint, rjoint, x, y)
   motion.line(ac, controls, false, ttl, tjoint, x, y)
   motion.circle(ac, controls, last, ttl, rjoint, x, y)
end
function addBombTimer(name, player, data, protect, scale)
   local r = data.bombTime * scale + 2

   local obj = {
      type = 13,
      angle = 0,
      color = '0xFF0000',
      foreground = false,
      friction=0.0,
      restitution=2.0,
      width = r,
      height = r,
      miceCollision = false,
      groundCollision = protect,
      dynamic = false
   }

   addGround(
      player.x,
      player.y,
      obj,
      data.bombTime,
      moveBombTimer,
      nil,
      {
         player = name,
         pdata = data,
         offset = 2,
         scale = scale,
         obj = obj
      }
   )

   r = r - 2

   obj = {
      type = 13,
      angle = 0,
      color = '0x6A7495',
      foreground = false,
      friction=0.0,
      restitution=2.0,
      width = r,
      height = r,
      miceCollision = false,
      groundCollision = protect,
      dynamic = false
   }

   addGround(
      player.x,
      player.y,
      obj,
      data.bombTime,
      moveBombTimer,
      nil,
      {
         player = name,
         pdata = data,
         offset = 0,
         scale = scale,
         obj = obj
      }
   )
end

function moveBombTimer(id, data)
   local a = data.callback_args
   local player = tfm.get.room.playerList[a.player]
   local sz = a.pdata.bombTime * a.scale + a.offset

   a.obj.width = sz
   a.obj.height = sz

   do_addGround(id, player.x, player.y, a.obj)
end

---------------------------------------------------------------------------

function defaultBombCallback(name, data)
   local player = tfm.get.room.playerList[name]

   local yc = player.y + player.vy
   local xb

   local x, y
   local k = data.bombCallbackArgs

   local ttl = 4

   local vx = 4
   local vy = 0

   local a = { ax = 64, ay = 0 }

   vx = k * vx
   a.ax = k * a.ax
   xb = player.x + k * data.bombTime * 5 + 10

   for off = 20, 120, 20 do
      y = off * k
      x = xb + y * 1.5
      addObject(objcode.anvil, x, yc - y, 0, vx, -vy * k, false, ttl, accelerate, nil, a)
      addObject(objcode.anvil, x, yc + y, 0, vx, vy * k, false, ttl, accelerate, nil, a)
      vy = vy + 1
   end
end

function defaultBomb(name, data)
   local player = tfm.get.room.playerList[name]

   if not player.isFacingRight then
      data.bombCallbackArgs = -1
   else
      data.bombCallbackArgs = 1
   end

   addBombTimer(name, player, data, true, 5)
end

function bomb2(name, data)
   local player = tfm.get.room.playerList[name]

   local x0, y0 = player.x, player.y
   local center = string.format('%d,%d', x0, y0)

   local ground = {
      type = 12,
      color=0xFFFFFF,
      foreground = true,
      width = 512,
      height = 8,
      dynamic = true,
      mass = 8,
      restitution = 255,
      linearDamping = 0,
      angularDamping = 0,
      groundCollision = false,
      miceCollision = true
   }
   local ground1 = {
      type = 13,
      color = 0xFFFFFF,
      width = 32,
      height = 32,
      dynamic = false,
      groundCollision = false,
      miceCollision = false,
      foreground = true
   }

   local joint = {
      type = 3,
      point1 = center,
      point2 = nil,
      forceMotor = 255,
      speedMotor = 2
   }
   local joint1 = {
      type = 3,
      point1 = center,
      point2 = center,
      ratio = 1,
      limit1 = 0,
      limit2 = 8
   }
   local joint2 = {
      type = 0,
      frequency = 10
   }

   local angle
   local a
   local x1, y1
   local x, y
   local off = 32.0 + ground.width / 2.0
   local ttl = 20
   local first = nil
   local prev = nil
   local id, id1

   addBombTimer(name, player, data, true, 5)

   id1 = addGround(x0, y0, ground1, ttl)

   for angle = 0, 359, 120 do
      a = angle * math.pi / 180.0

      x1, y1 = math.cos(a), math.sin(a)
      x, y = x0 + off * x1, y0 + off * y1

      ground.angle = angle

      id = addGround(x, y, ground, ttl)

      addJoint(id, id1, joint, ttl)

      if prev ~= nil then
         addJoint(id, prev, joint1, ttl)
         addJoint(id, prev, joint2, ttl)
      else
         first = id
      end

      prev = id
   end

   addJoint(first, id, joint1, ttl)
   addJoint(first, id, joint2, ttl)
end

function bomb3(name, data)
   local player = tfm.get.room.playerList[name]

   local x0, y0 = player.x, player.y
   local center = string.format('%d,%d', x0, y0)

   local ground = {
      type = 13,
      color = 0xFFFFFF,
      width = 64,
      height = 64,
      dynamic = true,
      mass = 1,
      linearDamping = 0,
      angularDamping = 0,
      groundCollision = false,
      miceCollision = false,
      foreground = true
   }

   local joint = {
      type = 1,
      axis = '-1,0',
      forceMotor = 255,
      speedMotor = 2,
      limit1 = 0,
      limit2 = 5
   }

   local angle
   local a
   local x, y
   local x1, y1
   local off = 64.0 + ground.width
   local ttl = 5
   local id
   local args

   addBombTimer(name, player, data, true, 10)

   local offset = {
      [0] = 0.15,
      [60] = 0.13,
      [120] = 0.11,
      [180] = 0.075,
      [240] = 0.05,
      [300] = 0
   }

   for angle = 0, 359, 60 do
      a = angle * math.pi / 180.0

      x1, y1 = math.cos(a), math.sin(a)
      x, y = x0 + off * x1, y0 + off * y1

      args = {
         x = x0 + math.cos(a + offset[angle]) * 280,
         y = y0 + math.sin(a + offset[angle]) * 280,
         power = 127,
         distance = 3 * ground.width,
         miceOnly = false,
         p1 = particles.red_spirit,
         p2 = nil
      }

      id = addGround(x, y, ground, ttl, nil, explode, args)

      joint.angle = 2.0 * math.pi - a
      addJoint(id, 0, joint, ttl)
   end
end
function pattern(name, data, btype, bcode, point)
   local pat = data.patterns[btype][bcode]

   if pat ~= nil then
      local l = #pat.points + 1
      if l >= pat.type.points then
         local time = os.time()
         if time - pat.lastTime >= pat.type.cd then
            pat.lastTime = time
            pat.points[l] = point
            local st, err = pcall(addPattern, name, data, pat.type, pat.points)
            pat.points = {}
            if not st then
               addError(name, string.format("pattern: %s: %s", name, err))
            end
         end
      else
         pat.points[l] = point
      end
   end
end

function bind(name, btype, bcode, pid)
   local data = playerData[name]
   local p = data.patterns[btype]

   if p[bcode] ~= nil then
      do_unbind(data, p[bcode], btype, bcode)
   end

   p[bcode] = {
      id = pid,
      type = patternTypes[pid],
      points = {},
      lastTime = 0
   }

   p = data.pattern_data[pid]

   if btype == 'key' then
      bindKey(name, bcode, true, true)
   end

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
         u[#u + 1] = { k, v }
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

function testPattern1(name, data, id, points)
   local p = points[1]
   local n = math.random(8, 16)
   local a, c, s
   local r
   local id

   for i = 1, n do
      r = math.random(64, 96)
      a = math.random() * 2.0 * math.pi;
      c, s = math.cos(a), math.sin(a)
      id = addBullet(bullet.butterfly, 8, nil, nil, nil,
                     p.x + r * c, p.y + r * s, 0.25 - math.pi / 2.0, 16,
                     {{color=randomColor()}},
                     {line=24, alpha=0.5, color=randomColor()},
                     {width=0, height=0, color=0xFFFFFF})
      addMotion(motion.line, id, true, true, 2,
                {speedMotor=math.random(2, 6), angle=2*math.pi-a})
   end
end
function shoot(name, data)
   if data.shot_cd == 0 then
      if data.bombing and data.bomb.shot ~= nil then
         data.shot_cd = data.bomb.shot.cd
         local st, err = pcall(data.bomb.shot.func, name, data)
         if not st then
            addError(name, string.format("shoot(bombing): %s: %s", name, err))
         end
      else
         data.shot_cd = data.shot.cd
         local st, err = pcall(data.shot.func, name, data)
         if not st then
            addError(name, string.format("shoot: %s: %s", name, err))
         end
      end
   end
end
function defaultShot(name, data)
   local player = tfm.get.room.playerList[name]
   local x, y = player.x, player.y
   local k
   if player.isFacingRight then
      k = -1
   else
      k = 1
   end

   local a = math.random() * math.pi
   local id = addBullet(bullet.jstar,
                        8, nil, nil, nil,
                        x + 64 * math.cos(a), y + 64 * math.sin(a),
                        0, 16, 5, 2,
                        {color=randomColor()},
                        nil, nil
   )

   a = math.random() * math.pi + math.pi
   local id1 = addBullet(bullet.jstar,
                        8, nil, nil, nil,
                        x + 64 * math.cos(a), y + 64 * math.sin(a),
                        0, 16, 5, 2,
                        {color=randomColor()},
                        nil, nil
   )

   addMotion(motion.circle, id, true, true, math.random(1, 4), {speedMotor=4*k}, x, y)
   addMotion(motion.circle, id1, true, true, math.random(1, 4), {speedMotor=-4*k}, x, y)
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

   addObject(objcode.anvil, x + vx, y + vy, 0, vx, vy, g, 10, moveHoming, nil, args)

   local args = {
      target = target,
      x = x,
      y = y - 32,
      v = 128
   }

   addObject(objcode.anvil, x + vx, y - vy, 0, vx, -vy, g, 10, moveHoming, nil, args)
end
--[[
do_respawn_1 = do_respawn

function do_respawn(name)
   do_respawn_1(name)
   local s = playerData[name].spawn
   movePlayer(name, s[0], s[1], false, 0, 0, true)
end
]]--

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

      spawn = { 200, 200 },
      vx = 0,

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

   ui.addTextArea(1, getText(data), name, 5, 25, 151, 40, nil, nil, 0.5, true)
   ui.addTextArea(104, '<TI><a href="event:help">?</a>', name, 145, 25, 11, 20, nil, nil, 0.0, true)
   ui.addTextArea(3, table.concat(errors), name, 805, 5, 200, 590, nil, nil, 0.5, true)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, playerData[name].color)
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

      vx = 0,

      bomb_id = nil
   }

   local data = playerData[name]

   copy(data, reset)

   updateTextAreas(name, data)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, data.color)
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
   do_respawn(name)
   setNameColor(name, playerData[name].color)
end
playerData = {}
objectData = {}
groundData = {}
jointData = {}
patternData = {}
bulletData = {}

errors = { '<TI><p align="center">Errors</p>' }

MAX_ID = 499
MAX_ERRORS = 7

playerKeys = { 32, 83, 40, 100, 101, 102, 104, 65, 68, 69, 81, --[[87,]] 37, 39 }
reservedKeys = invert(playerKeys, true)

eventCode = {
   key = keycode,
   obj = objcode,
   objend = objcode
}

defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'
maxLives = 8
maxBombs = 6

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
      func = defaultBomb,
      callback = defaultBombCallback,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 20,
      cd = 0
   },
   {
      name = '',
      func = bomb2,
      callback = nil,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 20,
      cd = 5
   },
   {
      name = '',
      func = bomb3,
      callback = nil,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 6,
      cd = 5
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
   },
   {
      func = testPattern1,
      time = 0,
      callback = nil,

      cd = 500,
      points = 1,

      maxBinds = 3,

      restrict = {
         key = nil,
         obj = nil,
         objend = nil
      },
   }
}

playerConfig = {
   Cafecafe = {
      bomb = bombTypes[2],
      color = 0x9852B4 -- 0xB06FFD
   }
}
MODULE_HELP_START = 'Keys'

MODULE_HELP_CONTENTS = [[<font face="mono" size="15"><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
<a href="event:Pattern types">Pattern types</a>
<a href="event:Shaman objects">Shaman objects</a>
]]
--<a href="event:Key codes">Key codes</a></font>

MODULE_HELP = {
      ['Keys'] = [[<font face="mono" size="15">Shoot - E
Bomb  - Q
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

!bind &lt;pattern&gt; key|obj|objend &lt;name|code&gt;

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

2 - 
    Cost: 1
    Duration: 10s
    Cooldown: 2.5s

3 - 
    Cost: 1
    Duration: 3s
    Cooldown: 2.5s
</font>
]],
      ['Pattern types'] = [[<font face="mono" size="15">1 - 
    Cooldown: 0.25s
    Max. binds: 3
    Points: 1

2 - 
    Cooldown: 0.5s
    Max. binds: 3
    Points: 1
</font>
]]
}

MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'

do
   local join1 = function(t, w)
      local ret = {'<font face="mono" size="15">'}
      local i

      for v, k in ipairs(keys1(t)) do
         i = w - #k
         if i > 0 then
            v = k .. string.rep(' ', i)
         else
            v = k
         end

         ret[#ret + 1] = string.format('%s = %4d\n', v, t[k])
      end

      ret[#ret + 1] = '</font>'

      return table.concat(ret)
   end

   MODULE_HELP['Shaman objects'] = join1(objcode, 15)
   --MODULE_HELP['Key codes'] = join1(keycode, 2)
end
MODULE_CHAT_COMMAND = {
   ['help'] = help,
   ['clear'] = clear,

   ['color'] = function(name, cmdl, arg)
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
            setColor(name, arg)
            playerConfig[name].color = arg
         else
            alert('Invalid color: ' .. arg, name)
         end
      end
   end,

   ['reset'] = function(name, cmdl, arg)
      arg = string.lower(arg)
      if arg == '' or arg == 'map' then
         setMap(defaultMap)
      else
         parsePlayerNames(name, arg, resetPlayer)
      end
   end,

   ['init'] = function(name, cmdl, arg)
      local f = function(name)
         deletePlayer(name)
         initPlayer(name)
      end
      parsePlayerNames(name, arg, f)
   end,

   ['respawn'] = function(name, cmdl, arg)
      parsePlayerNames(name, arg, respawn)
   end,

   ['shot'] = function(name, cmdl, arg)
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
   end,

   ['bomb'] = function(name, cmdl, arg)
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
   end,

   ['bind'] = function(name, cmdl, arg)
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
         alert('Invalid event: ' .. j, name)
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
   end,

   ['unbind'] = function(name, cmdl, arg)
      arg = split(arg)
      if #arg > 2 then
         alert('Too many arguments', name)
         return
      end

      i = arg[1]
      if i == 'all' or i == nil then
         unbind(name)
      elseif i ~= 'key' and i ~= 'obj' and i ~= 'objend' then
         alert('Invalid event: ' .. i, name)
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
   end,

   ['map'] = function(name, cmdl, arg)
      if arg == '' then
         arg = defaultMap
      end

      setMap(arg)
   end
}

MODULE_CHAT_COMMAND_1 = function(name, cmd, arg)
   alert('Invalid command: ' .. cmd, name)
end
eventNewPlayer = initPlayer
eventPlayerLeft = deletePlayer
eventTextAreaCallback = helpTextAreaCallback

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

   do_addGround(0, 0, 0, {type=13, width=10, height=10, color=0xFFFFFF, dynamic=false, miceCollision=false, groundCollision=false})
end

function eventKeyboard(name, key, down, x, y)
   if reservedKeys[key] then
      if key == 65 then
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
            if key == 32 or key == 104 or key == 83 or key == 40 or key == 53 or key == 101 --[[or key == 87]] then
               movePlayer(name, 0, 0, true, 0, 1, false)
               movePlayer(name, 0, 0, true, 0, -1, true)
            else
               movePlayer(name, 0, 0, true, 1, 0, false)
               movePlayer(name, 0, 0, true, -1, 0, true)
               playerData[name].vx = 0
            end
         else
            if key == 32 or key == 104 or key == 87 then
               vy = -50
            elseif key == 83 or key == 40 or key == 101 then
               vy = 50
            elseif key == 100 or key == 37 or key == 81 then
               vx = -50
            elseif key == 102 or key == 39 or key == 68 then
               vx = 50
            end

            if vx ~= 0 then
               playerData[name].vx = vx
            elseif key == 83 or key == 40 then
               vx = playerData[name].vx
            end

            if vx ~= 0 or vy ~= 0 then
               movePlayer(name, 0, 0, true, vx, vy, false)
            end
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
   local player, x, y, vx, vy, ax, ay, i

   clearT()

   for name, data in pairs(playerData) do
      player = tfm.get.room.playerList[name]
      if not player.isDead then
         x = player.x
         y = player.y

         if x < 0 then
            x = 10
         elseif x > 4800 then
            x = 4790
         end
         if y < 0 then
            y = 10
         elseif y > 1600 then
            y = 1590
         end

         data.spawn[0] = x
         data.spawn[1] = y

         vx = -player.vx
         vy = -player.vy
         ax = -player.vx / 10
         ay = -player.vy / 10
         for i = 1, math.random(8, 16) do
            addParticle(particles.purple,
                        x + math.random(-4, 4), y + math.random(-4, 4),
                        (vx + math.random() * 2 - 1) / i,
                        (vy + math.random() * 2 - 1) / i,
                        ax, ay
            )
         end
      end

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
               local st, err = pcall(data.bomb.callback, name, data)
               if not st then
                  addError(name, 'bomb.callback: ' .. err)
               end
            end
         end
      end
   end
end
for k, v in pairs(tfm.get.room.playerList) do
   initPlayer(k)
end

setMap(defaultMap)
