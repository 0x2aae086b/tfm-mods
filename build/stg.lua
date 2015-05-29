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

function randomColor()
   return math.random(0x000000, 0xFFFFFF)
end

function round(x)
   local ret = math.floor(x)
   if x - ret >= 0.5 then
      ret = ret + 1
   end
   return ret
end

function to_table(x)
   if x == nil or type(x) == 'table' then
      return x
   else
      return { x }
   end
end

_axis = {
   '-1,0', '-1,1', '0,1', '1,1',
   '1,0', '1,-1', '0,-1', '-1,-1'
}

_axis_step = math.pi / 4.0

function to_axis(angle)
   local idx = (round(angle / _axis_step) % #_axis)
   return _axis[idx + 1], _axis_step * idx
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
   if arg == '' then
      func(name)
      return
   end

   local players = {}
   local b

   for k, v in ipairs(split(string.lower(arg))) do
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
      if k ~= excl_key then
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

kc = keycode

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

MODULE_CHAT_COMMAND_1 = function(name, cmd, arg)
   alert('Invalid command: ' .. cmd, name)
end
MAX_ID = 1000

function tbl_name(t)
   return '&lt;table&gt;'
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
_errors = { '<TI><p align="center">Errors</p>' }

ERROR_TA = 3
MAX_ERRORS = 7

function alert(str, name)
   ui.addPopup(0, 0, string.format('<font face="mono" size="15">%s</font>', str), name, 200, 150, 400, true)
end

function addError(err)
   err = string.format("• %s\n", err)
   for i = #_errors + 1, 3, -1 do
      _errors[i] = _errors[i - 1]
   end
   _errors[2] = err
   _errors[MAX_ERRORS + 1] = nil
   ui.updateTextArea(ERROR_TA, table.concat(_errors), nil)
end
TIME = os.time()
TIMER_RES = 250

_timerId = {
   max = 0,
   free = {}
}

_timerData = {
}

function initTimers()
   TIME = os.time()
   _timerId = {
      max = 0,
      free = {}
   }
   _timerData = {}
end

function timer()
   local cur = os.time()
   while TIME + TIMER_RES <= cur do
      eventTimer()
      TIME = TIME + TIMER_RES
   end
end

function timers()
   local cur = os.time()
   local t, st, ret
   for k, v in ipairs(_timerData) do
      t = v.time
      ret = true
      while t + v.res <= cur do
         t = t + v.res
         st, ret = pcall(v.func, k, v)
         if not st then
            addError(string.format('timer %d: %s', k, ret))
            ret = false
         end
         if not ret then
            break
         end
      end
      if ret then
         v.time = t
      else
         removeTimer(k)
      end
   end
end

function addTimer(func, args, res)
   local id = newId(_timerId)
   _timerData[id] = {
      func = func,
      args = args,
      res = res,
      time = os.time()
   }
end

function removeTimer(id)
   freeId(_timerId, id)
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

function addExplosion(x, y, power, distance, miceOnly, particle1, particle2)
   if particle1 ~= nil then
      addParticle(particle1, x, y, 0, 0, 0, 0)
   end

   if particle2 ~= nil then
   end

   do_addExplosion(x, y, power, distance, miceOnly)
end
function list_default(t, k, v)
   t[#t + 1] = string.format('%d %d\n', k, v.time)
end

function step(dt, t, remove, list, do_list)
   local ids = {}
   local tm
   local st, err
   local k, v

   if do_list == nil then
      do_list = list_default
   end

   for k, v in pairs(t) do
      do_list(list, k, v)

      if v.time <= 0 then
         if v.on_remove then
            for k1, v1 in ipairs(v.on_remove) do
               st, err = pcall(v1, k, v)
               if not st then
                  addError(string.format("step(%s): on_remove[%d]: %s\n",
                                         tbl_name(t), k1, err))
               end
            end
         end
         ids[#ids + 1] = k
      else
         v.time = v.time - dt
         if v.callback then
            for k1, v1 in ipairs(v.callback) do
               st, err = pcall(v1, k, v)
               if not st then
                  addError(string.format("step(%s): callback[%d]: %s\n",
                                         tbl_name(t), k1, err))
                  ids[#ids + 1] = k
                  break
               end
            end
         end
      end
   end

   for k, v in ipairs(ids) do
      remove(v)
   end
end
function emptyMap(w, h, s, s1)
   local w2, h2 = w / 2.0, h / 2.0
   local x, y
   local t = { string.format('<C><P G="0,0" L="%d" H="%d" /><Z><S>', w, h) }
   s = s or 256
   s1 = s1 or s
   for x = 16, w, s do
      for y = 16, h, s1 do
         t[#t + 1] = string.format('<S o="%02x00%02x" L="16" Y="%d" c="4" P="0,0,0,0,0,0,0,0" T="13" X="%d" H="10" />', math.abs(w2 - x) / w2 * 255, math.abs(h2 - y) / h2 * 255, y, x)
      end
   end
   t[#t + 1] = '</S><D><DS X="200" Y="200" /></D><O /></Z></C>'
   return table.concat(t)
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
   elseif t == _timerId then
      return '_timerId'
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
   elseif t == _timerData then
      return '_timerData'
   end
   return '&lt;other&gt;'
end

function make_line(v0, v1)
   local dx, dy = v1[1] - v0[1], v1[2] - v0[2]

   return {
      width = math.sqrt(dx * dx + dy * dy),
      angle = math.deg(math.atan2(dy, dx)),
      x = (v0[1] + v1[1]) / 2,
      y = (v0[2] + v1[2]) / 2
   }
end

make_star = cache2(
   function(n, s)
      local tmp = {}
      local ret = {}
      local i, a

      for i = 1, n do
         a = math.pi * 2.0 * i / n
         tmp[#tmp + 1] = { math.cos(a), math.sin(a) }
      end

      for i = 1, n do
         ret[#ret + 1] = make_line(tmp[i], tmp[1 + (i + s - 1) % n])
      end

      local r = length1(ret[1])

      return { lines=ret, points=tmp, r=r, l=math.sqrt(1 - r*r) }
   end
)

-- 0 50 200 900 200 6.5 0.1 4 100 nil 0.5
function make_laser(ltype, x, y, x1, y1, step, k, n_step, line, colors)
   local ret = {{}}

   local angle = math.atan2(y1 - y, x1 - x)
   local c, s = math.cos(angle), math.sin(angle)

   local dx, dy = 0, 0
   local dx1, dy1
   local dx2, dy2
   local j = 2
   local i

   if ltype == 0 then
      ltype = 2
      for i = 1, n_step do
         dy = dy + step
         dx = dy * dy * k
         dx2, dy2 = -dy * s, dy * c
         dx1, dy1 = dx * c + dx2, dx * s + dy2
         ret[j] = {
            point1 = string.format("%d,%d", x + dx1, y + dy1),
            point2 = string.format("%d,%d", x1 + dx2, y1 + dy2)
         }
         j = j + 1
         dx1, dy1 = dx * c - dx2, dx * s - dy2
         ret[j] = {
            point1 = string.format("%d,%d", x + dx1, y + dy1),
            point2 = string.format("%d,%d", x1 - dx2, y1 - dy2)
         }
         j = j + 1
      end
   elseif ltype == 1 then
      ltype = 2
      for i = 1, n_step do
         dy = dy + step
         dx2, dy2 = -dy * s, dy * c
         ret[j] = { point2 = string.format("%d,%d", x1 + dx2, y1 + dy2) }
         j = j + 1
         ret[j] = { point2 = string.format("%d,%d", x1 - dx2, y1 - dy2) }
         j = j + 1
      end
   else
      ltype = 1
      line = line or 50
      dx = step * k
      for i = 1, n_step do
         line = line + step
         dx2, dy2 = dx * c, dx * s
         ret[j] = {
            point1 = string.format("%d,%d", x + dx2, y + dy2),
            line = line
         }
         j = j + 1
         dx = dx * 2
      end
   end

   if colors then
      j = 0
      for i = 2, #ret do
         if i % ltype == 0 then
            j = j + 1
         end
         ret[i].color = colors[j]
      end
   end

   return ret
end
function getText(data)
   local lives = data.lives - 1
   local bombs = data.bombs

   if lives >= maxLives then
      lives = maxLives - 1
   elseif lives < 0 then
      lives = 0
   end

   if bombs > maxBombs then
      bombs = maxBombs
   elseif bombs < 0 then
      bombs = 0
   end

   return string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',
                        string.rep('★', lives), string.rep('★', bombs)
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

function clearT(dt)
   local str = { '<TI>' }

   str[#str + 1] = '<p align="center">Joints</p>'
   step(dt, jointData, removeJoint, str)

   str[#str + 1] = '<p align="center">Objects</p>'
   step(dt, objectData, removeObject, str, list_object)

   str[#str + 1] = '<p align="center">Grounds</p>'
   step(dt, groundData, removeGround, str)

   str[#str + 1] = '<p align="center">Bullets</p>'
   step(dt, bulletData, removeBullet, str, list_bullet)

   str[#str + 1] = '<p align="center">Patterns</p>'
   step(dt, patternData, removePattern, str)

   ui.addTextArea(2, table.concat(str), nil, -155, 5, 150, 590, nil, nil, 0.5, true)
end
--[[function replace(id, data)
   local a = data.callback_args
   local id = do_addGround(a.gid, a.gx, a.gy, a.gdata)
   if a.jid then
      do_addJoint(a.jid, a.jg1, a.jg2, a.jdata)
   end
end]]

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
_tmp_grounds = {}
_tmp_joints = {}

function addGround1(t, x, y, other)
   local id = newId(groundId)
   _tmp_grounds[#_tmp_grounds + 1] = id
   do_addGround(id, x, y, other)
   t[#t + 1] = id
   return id
end

addJoint2 = {
   function(t, id1, id2, other)
      local id = newId(jointId)
      _tmp_joints[#_tmp_joints + 1] = id
      do_addJoint(id, 0, 0, other)
      t[#t + 1] = id
   end,

   function(t, id1, id2, other)
      local id = newId(jointId)
      _tmp_joints[#_tmp_joints + 1] = id
      do_addJoint(id, id1, id2, other)
      t[#t + 1] = id
   end
}

function addBullet(btype, bullet_args, ttl, callback, on_remove, args)
   local id = newId(bulletId)
   local _, v
   local st, control, grounds, joints = pcall(btype, addJoint2[bullet_args.static or 2], bullet_args)

   if st then
      _tmp_grounds = {}
      _tmp_joints = {}
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
      _tmp_grounds = {}
      _tmp_joints = {}
      freeId(bulletId, id)
      error(string.format('addBullet: %s', control))
   end

   return id
end

function removeBullet(id)
   local data = bulletData[id]
   local k, v
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

bullet.rectangle = function(addJoint1, a)
   local x, y, angle = a.x, a.y, a.angle
   local width, height = a.width, a.height
   local jdata, hitbox_data = a.jdata, a.hitbox_data

   local dx, dy = math.cos(angle), math.sin(angle)
   local w = width / 2.0
   local _, v

   local joint = {
      type = 0,
      point1 = string.format("%d,%d", x, y),
      point2 = string.format("%d,%d", x + dx * width, y + dy * width),
      color = 0xFF0000,
      line = 2 * height + 4,
      foreground = false
   }

   local hitbox = {
      type = 12,
      width = width,
      height = height,
      angle = math.deg(angle),
      miceCollision = true,
      groundCollision = false,
      foreground = true,
      dynamic = true,
      mass = 1,
      restitution = 255
   }

   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}
   local id0 = addGround1(grounds, x + dx * w, y + dy * w, hitbox)

   if jdata then
      for _, v in ipairs(jdata) do
         copy(joint, v)
         addJoint1(joints, id0, id0, joint)
      end
   end

   return id0, grounds, joints
end

bullet.circle = function(addJoint1, a)
   local x, y, R = a.x, a.y, a.R
   local jdata, hitbox_data = a.jdata, a.hitbox_data

   local joint = {
      type = 0,
      point2 = string.format('%d,%d', x, y + 1),
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
      mass = 1,
      restitution = 255
   }

   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}
   local id0 = addGround1(grounds, x, y, hitbox)

   if jdata then
      for _, v in ipairs(jdata) do
         copy(joint, v)
         addJoint1(joints, id0, id0, joint)
      end
   end

   return id0, grounds, joints
end

bullet.butterfly = function(addJoint1, a)
   local x, y, angle, R = a.x, a.y, a.angle, a.R
   local center_jdata, wing_jdata = a.center_jdata, a.wing_jdata
   local hitbox_data = a.hitbox_data
   local i

   local star = make_star(5, 2)

   local wing = {
      type = 0,
      color = 0xFF00FF,
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
      mass = 1,
      miceCollision = true,
      groundCollision = false,
      restitution = 255
   }

   copy(wing, wing_jdata)
   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)
   local v

   local id0 = addGround1(grounds, x, y, hitbox)

   for i = 2, 5 do
      v = star.points[i]
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      x1, y1 = x + R * x1, y + R * y1

      wing.point1 = string.format('%d,%d', x1, y1)
      wing.point2 = string.format('%d,%d', x1, y1 + 1)
      addJoint1(joints, id0, id0, wing)
   end

   copy(center, center_jdata)
   addJoint1(joints, id0, id0, center)

   return id0, grounds, joints
end

bullet.jstar = function(addJoint1, a)
   local x, y, angle, R = a.x, a.y, a.angle, a.R
   local points, step = a.points, a.step
   local line_jdata, center_jdata = a.line_jdata, a.center_jdata
   local hitbox_data = a.hitbox_data
   local i

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
      mass = 1,
      miceCollision = true,
      groundCollision = false,
      restitution = 255
   }

   copy(line, line_jdata)
   copy(hitbox, hitbox_data)

   local grounds, joints = {}, {}
   local pts = {}

   local x1, y1
   local c, s = math.cos(angle), math.sin(angle)
   local k, v

   for k, v in ipairs(star.points) do
      x1, y1 = v[1] * c - v[2] * s, v[1] * s + v[2] * c
      pts[#pts + 1] = string.format('%d,%d', x + R * x1, y + R * y1)
   end

   local id0 = addGround1(grounds, x, y, hitbox)
   
   for i = 1, points do
      line.point1 = pts[i]
      line.point2 = pts[1 + (i + step - 1) % points]
      addJoint1(joints, id0, id0, line)
   end

   if center_jdata then
      for k, v in ipairs(center_jdata) do
         copy(center, v)
         addJoint1(joints, id0, id0, center)
      end
   end

   return id0, grounds, joints
end

bullet.star = function(addJoint1, a)
   local x, y, angle, R = a.x, a.y, a.angle, a.R
   local points, step, do_cap = a.points, a.step, a.do_cap
   local line_data, center_data = a.line_data, a.center_data
   local cap_data = a.cap_data

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
   local a = math.deg(angle)
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

   local id0 = addGround1(caps, x, y, center)

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
            addError(string.format("bomb: %s: %s", name, err))
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
function addBombTimer(name, player, data, scale)
   local r = data.bombTime * scale + 2

   local obj = {
      type = 13,
      color = 0xFF0000,
      foreground = false,
      width = r,
      height = r,
      miceCollision = false
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
      color = 0x6A7495,
      foreground = false,
      width = r,
      height = r,
      miceCollision = false
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

function bomb1(name, data)
   local ttl = 20
   local width = 512
   local off = 32.0

   local player = tfm.get.room.playerList[name]
   local x0, y0 = player.x, player.y
   local center = string.format("%d,%d", x0, y0)

   local colors = { 0x00FF00, 0x00FFFF, 0x0000FF }
   local cdata = {
      x = x0,
      y = y0,
      R = 32,
      hitbox_data = { miceCollision = false, mass = 2, angularDamping = 1 }
   }
   local bdata = {
      width = width,
      height = 16,
      hitbox_data = { mass = 2, linearDamping = 0.5 }
   }
   local mdata = {
      last = true,
      ttl = ttl,
      jdata = { speedMotor = 255 }
   }

   addBombTimer(name, player, data, 5)

   local id0 = addBullet(bullet.circle, cdata, ttl)
   local id00 = id0
   id0 = bulletData[id0].controls
   id0 = id0[#id0]

   local joint = {
      type = 3,
      point1 = center,
      point2 = center,
      ratio = 1,
      limit1 = 0,
      limit2 = 0
   }
   local joint1 = {
      type = 0,
      frequency = 32
   }

   local a
   local x, y
   local x1, y1
   local first, prev
   local jdata
   local i

   for i = 1, 3 do
      a = math.pi * i * 2.0 / 3.0

      x, y = math.cos(a), math.sin(a)
      x1, y1 = x0 + (off + width) * x, y0 + (off + width) * y
      x, y = x0 + off * x, y0 + off * y

      jdata = make_laser(0, x, y, x1, y1, 5, 0.1, 2, 20)
      jdata[1] = {
         point1 = string.format("%d,%d", x, y),
         point2 = string.format("%d,%d", x1, y1),
         color = colors[i],
         alpha = 0.25,
         line = 20,
         foreground = true
      }

      bdata.angle = a
      bdata.x = x
      bdata.y = y
      bdata.jdata = jdata

      id = addBullet(bullet.rectangle, bdata, ttl)
      id = bulletData[id].controls
      id = id[#id]

      addJoint(id, id0, joint, ttl)

      if prev then
         addJoint(id, prev, joint1, ttl)
      else
         first = id
      end

      prev = id
   end

   addJoint(prev, first, joint1, ttl)

   addMotion(motion.circle, id00, true, mdata)
end

function bomb2Callback(id, data)
   local a = data.callback_args

   if a.delay == 1 then
      local mdata = {
         last = true,
         ttl = a.ttl,
         x = a.x,
         y = a.y,
         no_target = a.no_target,
         delay = 0,
         delay1 = 0,
         frequency = 0.5,
         max_step = 500
      }
      addMotion(motion.follow, id, true, mdata)
      a.delay = 0
   else
      a.delay = a.delay - 1
   end
end

function bomb2(name, data)
   local ttl = 20
   local off = 96.0

   local player = tfm.get.room.playerList[name]
   local x0, y0 = player.x, player.y

   local bdata = {
      R = 48,
      jdata = {{ foreground = false, line = 128 }},
      hitbox_data = { color = 0xFFFFFF }
   }

   local mdata = {
      ttl = 2,
      last = true,
      jdata = { speedMotor = 3, color = 0xFFFFFF }
   }

   local a
   local x, y
   local id
   local args
   local i

   addBombTimer(name, player, data, 5)

   for i = 1, #_axis do
      a = (1 - i) * _axis_step

      x, y = math.cos(a), math.sin(a)

      bdata.x = x0 + off * x
      bdata.y = y0 + off * y
      bdata.jdata[1].color = randomColor()

      mdata.jdata.axis = _axis[i]
      mdata.jdata.speedMotor = 5 - mdata.jdata.speedMotor

      args = {
         delay = 2,
         ttl = ttl - 2,
         x = x0 + 150 * x,
         y = y0 + 150 * y,
         no_target = name
      }

      id = addBullet(bullet.circle, bdata, ttl, bomb2Callback, nil, args)
      addMotion(motion.line, id, true, mdata)
   end
end
function do_addControl(controls, control)
   controls[#controls + 1] = control
end

function do_removeControl(controls, idx)
   while controls[idx] do
      controls[idx] = nil
      idx = idx + 1
   end
end

function motionEnd(id, data)
   do_removeControl(data.callback_args._controls, data.callback_args._idx)
end

function addControl(controls, ...)
   local idx = #controls + 1
   local id = addGround(...)
   local data = groundData[id]
   if data.callback_args == nil then
      data.callback_args = { _controls = controls, _idx = idx }
   else
      data.callback_args._controls = controls
      data.callback_args._idx = idx
   end
   if data.on_remove == nil then
      data.on_remove = { motionEnd }
   else
      data.on_remove[#data.on_remove + 1] = motionEnd
   end
   controls[#controls + 1] = id
   return id
end

function addControl1(controls, ...)
   return addGround(...)
end

function addMotion(mtype, id, is_bullet, args)
   local data
   local ac
   if is_bullet then
      data = bulletData[id].controls
      ac = addControl
   else
      data = { id }
      ac = addControl1
   end
   local st, err = pcall(mtype, ac, data, args)
   if not st then
      error(string.format("addMotion: %s", err))
   end
end
motion = {}

motion.i_f = function(ac, controls, args)
   local id = addGround(100, 100, CONTROL, 1)
   addJoint(controls[#controls], id, IFJOINT, 1)
end

motion.i_f_1 = function(ac, controls, args)
   local cbargs = {
      gid = controls[#controls],
      gx = args.x,
      gy = args.y,
      jg1 = controls[#controls],
      jg2 = 0,
      gdata = args.gdata,
      jdata = IF1JOINT
   }
   local id = addJoint(controls[#controls], 0, IF1JOINT, args.ttl, replace, nil, cbargs)
   cbargs.jid = id
end

motion.fix = function(ac, controls, args)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 0,
      frequency = 10
   }
   copy(joint, args.jdata)
   if not args.last then
      id = ac(controls, args.x or 0, args.y or 0, CONTROL, args.ttl or 3)
   end
   addJoint(id1, id, joint, args.ttl or 3)
end

motion.follow = function(ac, controls, args)
   args.x = args.x or 0
   args.y = args.y or 0
   args.ttl = args.ttl or 3
   args.delay = args.delay or 0
   args.delay1 = args.delay1 or 0
   args.max_step = args.max_step or 3000
   args.min_step = args.min_step or 30

   if args.target == nil then
      args.target = randomKey1(tfm.get.room.playerList, args.no_target, true)
   end

   local id1 = controls[#controls]
   local id = ac(controls, args.x, args.y, CONTROL, args.ttl, moveHoming1, nil, args)

   local joint = {
      type = 0,
      frequency = args.frequency or (1.0 / (1.0 + args.delay1))
   }
   local jdata = {
      type = 1,
      forceMotor = 255,
      speedMotor = 127
   }
   copy(jdata, args.jdata)

   addJoint(id1, id, joint, args.ttl)

   args.jdata = jdata
   args.gid = id
   args.jid = addJoint(id, 0, joint, args.ttl)
   --do_removeJoint(args.jid)
end

motion.line = function(ac, controls, args) -- limit = px / 30
   local x = args.x or 0
   local y = args.y or 0
   local ttl = args.ttl or 3
   local id = 0
   local id1
   local joint = {
      type = 1,
      axis = '-1,0',
      angle = 0,
      forceMotor = 255,
      speedMotor = 1
   }

   copy(joint, args.jdata)

   if args.free_angle then
      motion.fix(ac, controls, { ttl = ttl, x = x, y = y })
   end

   id1 = controls[#controls]

   if not args.last then
      id = ac(controls, x, y, CONTROL, ttl)
   end

   addJoint(id1, id, joint, ttl)
end

motion.circle = function(ac, controls, args)
   local id = 0
   local id1 = controls[#controls]
   local joint = {
      type = 3,
      forceMotor = 255,
      speedMotor = 1
   }
   copy(joint, args.jdata)
   if not args.last then
      id = ac(controls, args.x or 0, args.y or 0, CONTROL, args.ttl or 3)
   end
   if args.x and args.y then
      joint.point1 = string.format('%d,%d', args.x, args.y)
   end
   addJoint(id1, id, joint, args.ttl or 3)
end

motion.spiral = function(ac, controls, args)
   local last = args.last

   args.last = false
   args.jdata = args.tjoint
   motion.line(ac, controls, args)

   args.last = last
   args.jdata = args.rjoint
   motion.circle(ac, controls, args)
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
               addError(string.format("pattern: %s: %s", name, err))
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
function testPattern(name, data, id, points)
   local p = points[1]

   local n = 6
   local r = 48
   local v = math.random(2, 8)

   local a, c, s, i
   local a0 = math.rad(p.angle)

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
   local a, c, s, i
   local r
   local id

   local bdata = {
      angle = 0.25 - math.pi / 2.0,
      R = 16,
      center_jdata = {},
      wing_jdata = { line = 24, alpha = 0.5 },
      hitbox_data = { width = 0, height = 0, color = 0xFFFFFF, mass = 1 }
   }

   local mdata = {
      ttl = 2,
      last = true,
      jdata = {}
   }

   for i = 1, n do
      r = math.random(64, 96)
      a = math.random() * 2.0 * math.pi;
      c, s = math.cos(a), math.sin(a)

      bdata.x = p.x + r * c
      bdata.y = p.y + r * s
      bdata.center_jdata.color = randomColor()
      bdata.wing_jdata.color = randomColor()

      mdata.jdata.speedMotor = math.random(2, 6)
      mdata.jdata.angle = 2 * math.pi - a

      id = addBullet(bullet.butterfly, bdata, 8)
      addMotion(motion.line, id, true, mdata)
   end
end

function testPattern2(name, data, id, points)
   local p = points[1]
   local bdata = {
      x = p.x,
      y = p.y,
      R = 16,
      jdata = {{ color = randomColor(), line = 32 }},
      hitbox_data = { width = 0, height = 0, color = 0xFFFFFF, mass = 1 }
   }
   local mdata = {
      ttl = 16,
      last = true,
      x = p.x,
      y = p.y,
      frequency = 0.25,
      delay = 2,
      delay1 = 0,
      max_step = 1000,
      --no_target = name
   }
   local id = addBullet(bullet.circle, bdata, 16)
   addMotion(motion.follow, id, true, mdata)
end

function testPattern3(name, data, id, points)
   local p = points[1]
   local c = randomColor()
   local ax, a = to_axis(math.rad(-p.angle))
   local bdata = {
      x = p.x,
      y = p.y,
      angle = a,
      R = 36,
      points = math.random(5, 8),
      step = 2,
      line_jdata = { color = c },
      center_jdata = {
         { foreground = false, color = c, line = 76 },
         { color = 0x6A7495, line = 70 }
      },
      hitbox_data = { dynamic = true, miceCollision = false }
   }
   local cb_args = {
      cd = 0,
      btype = bullet.rectangle,
      bttl = 10,
      bdata = {
         x = p.x,
         y = p.y,
         angle = -a,
         width = 128,
         height = 13,
         jdata = {
            { color = randomColor(), foreground = false },
            { color = 0xFFFFFF, line = 16, foreground = true }
         },
         hitbox_data = {
            dynamic = true,
            fixedRotation = true,
            mass = 1
         }
      },
      mtype = motion.line,
      mdata = {
         x = p.x,
         y = p.y,
         ttl = 1,
         last = true,
         free_angle = true,
         jdata = { speedMotor = 8, axis = ax }
      }
   }
   local id = addBullet(bullet.jstar, bdata, 32, shoot_bullet, nil, cb_args)
   addMotion(motion.circle, id, true, { last = true, ttl = 2, jdata = { speedMotor = 4 } })
end

function testPattern4(name, data, id, points)
   local p = points[1]

   local bdata = {
      x = p.x,
      y = p.y,
      angle = math.rad(p.angle),
      width = 512,
      height = 13,
      static = 1,
      jdata = {
         { color = randomColor(), foreground = true },
         { color = 0xFFFFFF, line = 16 }
      },
      hitbox_data = {
         dynamic = true,
         restitution = 0,
         mass = -1
      }
   }

   local id = addBullet(bullet.rectangle, bdata, 10)
   addMotion(motion.i_f, id, true)
end
function shoot(name, data)
   if data.shot_cd == 0 then
      if data.bombing and data.bomb.shot ~= nil then
         data.shot_cd = data.bomb.shot.cd
         local st, err = pcall(data.bomb.shot.func, name, data)
         if not st then
            addError(string.format("shoot(bombing): %s: %s", name, err))
         end
      else
         data.shot_cd = data.shot.cd
         local st, err = pcall(data.shot.func, name, data)
         if not st then
            addError(string.format("shoot: %s: %s", name, err))
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

   local bdata = {
      x = x + 64 * math.cos(a),
      y = y + 64 * math.sin(a),
      angle = 0,
      R = 16,
      points = 5,
      step = 2,
      line_jdata = { color = randomColor() },
      center_jdata = {{}}
   }

   local mdata = {
      last = true,
      ttl = math.random(1, 4),
      x = x,
      y = y,
      jdata = { speedMotor = 4 * k }
   }

   local id = addBullet(bullet.jstar, bdata, 8)

   a = math.random() * math.pi + math.pi
   bdata.x = x + 64 * math.cos(a)
   bdata.y = y + 64 * math.sin(a)
   bdata.line_jdata.color = randomColor()

   local id1 = addBullet(bullet.jstar, bdata, 8)

   addMotion(motion.circle, id, true, mdata)

   mdata.ttl = math.random(1, 4)
   mdata.jdata.speedMotor = - 4 * k

   addMotion(motion.circle, id1, true, mdata)
end

function homingShot(name, data)
   local player = tfm.get.room.playerList[name]
   local x = player.x
   local y = player.y

   if data.focused then
      local target = randomValue1(tfm.get.room.playerList, name, false)
      local x1, y1 = target.x, target.y
      x1, y1 = x1 - x, y1 - y
      local a = math.atan2(y1, x1)
      local c, s, a1, i
      local v = 16
      for i = 1, 2 do
         a1 = a + math.random() * 0.2
         c, s = math.cos(a1), math.sin(a1)
         addObject(objcode.anvil, x + 20 * c, y + 20 * s, math.deg(a1), v * c, v * s, false, 10)
      end
   else
      local target = randomKey1(tfm.get.room.playerList, name, false)
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
end
do_respawn_1 = do_respawn

function do_respawn(name)
   do_respawn_1(name)
   local s = playerData[name].spawn
   movePlayer(name, s[0], s[1], false, 0, 0, true)
end

function initPlayer(name)
   local data = {
      color = randomColor(),

      shooting = false,
      bombing = false,
      focused = false,

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

      speed = 60,
      focusedSpeed = 30,
      curSpeed = 50,
      vx = 0,
      vy = 0,

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

   for k, v in ipairs(playerKeys) do
      bindKey(name, v, true, true)
      bindKey(name, v, false, true)
   end

   system.bindMouse(name, true)

   ui.addTextArea(1, getText(data), name, 5, 25, 151, 40, nil, nil, 0.5, true)
   ui.addTextArea(104, '<TI><a href="event:help">?</a>', name, 145, 25, 11, 20, nil, nil, 0.0, true)
   ui.addTextArea(ERROR_TA, table.concat(_errors), name, 805, 5, 200, 590, nil, nil, 0.5, true)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, playerData[name].color)
end

function resetPlayer(name)
   local data = playerData[name]

   copy(data, RESET)

   updateTextAreas(name, data)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, data.color)
end

function deletePlayer(name)
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

function movePlayer1(name, data, vx, vy, down)
   if vx then
      if down then
         data.vx = vx
         vx = vx * data.curSpeed
         if data.vx > 0 then
            data.dir = 1
         else
            data.dir = -1
         end
         movePlayer(name, 0, 0, false, vx, 0, false)
      else
         data.vx = 0
         movePlayer(name, 0, 0, false, 1, 0, false)
         movePlayer(name, 0, 0, false, -1, 0, true)
      end
   elseif vy then
      if down then
         data.vy = vy
         vy = vy * data.curSpeed
         movePlayer(name, 0, 0, false, data.vx * data.curSpeed, vy, false)
      else
         data.vy = 0
         movePlayer(name, 0, 0, false, 0, -1, false)
         movePlayer(name, 0, 0, false, 0, 1, true)
      end
   else
      return false
   end
   return true
end
playerData = {}
objectData = {}
groundData = {}
jointData = {}
patternData = {}
bulletData = {}

MAX_ID = 400
MAX_ERRORS = 7

GROUND0 = {
   type = 13,
   color = 0xFFFFFF,
   dynamic = false,
   miceCollision = false,
   groundCollision = false
}

CONTROL = {
   type = 13,
   dynamic = true,
   mass = 1,
   groundCollision = false,
   miceCollision = false
}

IFJOINT = {
   type = 2,
   point2 = '0,0',
   point3 = '0,0',
   point4 = '0,0'
}

IF1JOINT = {
   type = 1,
   axis = '3,2',
   angle = 0,
   forceMotor = 255
}

RESET = {
   shooting = false,
   bombing = false,
   lives = 5,
   bombs = 3,
   shot_cd = 0,
   bomb_cd = 0,
   vx = 0
}

playerKeys = {
   kc.space,
   kc.w, kc.s, kc.a, kc.d,
   kc.left, kc.right, kc.up, kc.down,
   kc.kp4, kc.kp6, kc.kp8, kc.kp5,
   kc.e, kc.q,
   kc.shift
}
reservedKeys = invert(playerKeys, true)

pk_vx = {
   [kc.a] = -1,
   [kc.left] = -1,
   [kc.kp4] = -1,
   [kc.d] = 1,
   [kc.right] = 1,
   [kc.kp6] = 1
}

pk_vy = {
   [kc.space] = -1,
   [kc.w] = -1,
   [kc.up] = -1,
   [kc.kp8] = -1,
   [kc.s] = 1,
   [kc.down] = 1,
   [kc.kp5] = 1
}

eventCode = {
   key = keycode,
   obj = objcode,
   objend = objcode
}

mapWidth = 1600
mapHeight = 800
defaultMap = emptyMap(mapWidth, mapHeight)
X_MIN = 16
X_MAX = mapWidth - 16
Y_MIN = 16
Y_MAX = mapHeight - 16

maxLives = 8
maxBombs = 6

shotTypes = {
   {
      name = 'default shot',
      func = defaultShot,
      cd = 1
   },
   {
      name = 'homing anvils',
      func = homingShot,
      cd = 2
   }
}

bombTypes = {
   {
      name = '',
      func = bomb1,
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
      func = bomb2,
      callback = nil,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 20,
      cd = 5
   }
}

patternTypes = {
   {
      func = testPattern,
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
      callback = nil,

      cd = 500,
      points = 1,

      maxBinds = 3,

      restrict = {
         key = nil,
         obj = nil,
         objend = nil
      },
   },
   {
      func = testPattern2,
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
      func = testPattern3,
      callback = nil,

      cd = 1000,
      points = 1,

      maxBinds = 2,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   },
   {
      func = testPattern4,
      callback = nil,

      cd = 250,
      points = 1,

      maxBinds = 2,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   }
}

playerConfig = {
   Cafecafe = {
      color = 0xB06FFD --0x9852B4
   },
   Rar = {
      color = 0x553399
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
Focus - Shift
Up    - W, ↑, Space
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
]]
}

MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'

do
   local desc = function(t, n)
      local ret = {'<font face="mono" size="15">'}
      for k, v in ipairs(t) do
         if v.name then
            ret[#ret + 1] = string.format('%d - %s\n', k, v.name)
         else
            ret[#ret + 1] = string.format('%d\n', k)
         end
         if v.cost then
            ret[#ret + 1] = string.format('    Cost: %d\n', v.cost)
         end
         if v.time then
            ret[#ret + 1] = string.format('    Duration: %fs\n', v.time / 2.0)
         end
         if v.cd then
            ret[#ret + 1] = string.format('    Cooldown: %fs\n', v.cd / n)
         end
         if v.maxBinds then
            ret[#ret + 1] = string.format('    Max. binds: %d\n', v.maxBinds)
         end
         ret[#ret + 1] = '\n'
      end
      return table.concat(ret)
   end
   MODULE_HELP['Shot types'] = desc(shotTypes, 2.0)
   MODULE_HELP['Bomb types'] = desc(bombTypes, 2.0)
   MODULE_HELP['Pattern types'] = desc(patternTypes, 1000.0)
end

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
for k, v in pairs(tfm.get.room.playerList) do
   initPlayer(k)
end

setMap(defaultMap)
