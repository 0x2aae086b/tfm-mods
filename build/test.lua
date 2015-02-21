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
      ret = ret + 1.0
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
            addError(nil, string.format('timer %d: %s', k, ret))
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
dump_func = {
   ['function'] = function(...)
      return '&lt;function&gt;'
   end,
   ['userdata'] = function(...)
      return '&lt;userdata&gt;'
   end,
   ['thread'] = function(...)
      return '&lt;thread&gt;'
   end,

   ['nil'] = function(...)
      return 'nil'
   end,

   ['number'] = function(var, ...)
      return tostring(var)
   end,

   ['boolean'] = function(var, ...)
      return tostring(var)
   end,

   ['string'] = function(var, ...)
      for k, v in ipairs({{'&', '&amp;'}, {'<', '&lt;'}, {'>', '&gt;'}}) do
         var = string.gsub(var, v[1], v[2])
      end
      return string.format('%q', var)
   end,

   ['table'] = function(var, off)
      if off == nil then
         off = ''
      end

      local ret = { "{\n" }
      local off1 = off .. ' '

      for k, v in pairs(var) do
         ret[#ret + 1] = off1 .. '['
         ret[#ret + 1] = dump_func[type(k)](k, off1)
         ret[#ret + 1] = '] = '
         ret[#ret + 1] = dump_func[type(v)](v, off1)
         ret[#ret + 1] = ',\n'
      end

      local i = #ret
      if i > 1 then
         ret[i] = '\n'
      end

      ret[#ret + 1] = off .. '}'

      return table.concat(ret)
   end
}

function dump(var)
   return dump_func[type(var)](var)
end
function split1(str, pattern, maxlen, fmt)
   if fmt == nil then
      fmt = '%s'
   end

   maxlen = maxlen - #fmt + 2

   local len = #str

   if len <= maxlen then
      return { string.format(fmt, str) }
   end

   local ret = {}

   local start = 1
   local prev_i, prev_j
   local i, j = string.find(str, pattern)

   while i ~= nil do
      if i - start > maxlen then
         if prev_i ~= nil and prev_i > start then
            ret[#ret + 1] = string.format(fmt, string.sub(str, start, prev_i - 1))
            start = prev_j + 1
         end
         while i - start > maxlen do
            ret[#ret + 1] = string.format(fmt, string.sub(str, start, start + maxlen - 1))
            start = start + maxlen
         end
      end

      prev_i, prev_j = i, j

      i, j = string.find(str, pattern, j + 1)

      if i == nil and prev_j < len then
         i, j = len, len
      end
   end

   if start < len then
      ret[#ret + 1] = string.format(fmt, string.sub(str, start, len))
   end

   return ret
end

function do_showLongString(ls, name)
   ui.addTextArea(ls.id, ls.pages[ls.page], name, 100, 80, 579, 284, nil, nil, ls.alpha, true)
   ui.addTextArea(ls.id + 1, string.format('<a href="event:lsalpha%s"><p align="center"><font face="mono" size="15">%s</font></p></a>', name, ls.title), name, 100, 50, 400, 22, nil, nil, ls.alpha, true)
   ui.addTextArea(ls.id + 2, string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>', ls.page, ls.maxPage), name, 508, 50, 148, 22, nil, nil, ls.alpha, true)
   ui.addTextArea(ls.id + 3, '<TI><a href="event:lsclose"><p align="center">X</p></a>', name, 664, 50, 15, 22, nil, nil, ls.alpha, true)
end

function showLongString(title, str, name, alpha)
   if alpha == nil then
      alpha = 1
   end

   local pages = split1(str, '\n', 2000, '<font face="mono" size="15">%s</font>')
   local p = #pages

   ls = {
      id = 200,
      title = title,
      pages = pages,
      page = 1,
      alpha = alpha,
      maxPage = p
   }

   if playerData[name] == nil then
      playerData[name] = {}
   end

   playerData[name].longString = ls

   do_showLongString(ls, name)
end

function updateLongString(name, ls)
   ui.updateTextArea(ls.id, ls.pages[ls.page], name)
   ui.updateTextArea(ls.id + 2, string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>', ls.page, ls.maxPage), name)
end

function lsTextAreaCallback(id, name, callback)
   if callback == 'next' then
      local ls = playerData[name].longString
      local p = ls.page
      if p < ls.maxPage then
         ls.page = p + 1
      end
      updateLongString(name, ls)
   elseif callback == 'prev' then
      local ls = playerData[name].longString
      local p = ls.page
      if p > 1 then
         ls.page = p - 1
      end
      updateLongString(name, ls)
   elseif callback == 'lsclose' then
      ui.removeTextArea(id - 3, name)
      ui.removeTextArea(id - 2, name)
      ui.removeTextArea(id - 1, name)
      ui.removeTextArea(id, name)
      playerData[name].longString = nil
   elseif string.sub(callback, 1, 7) == 'lsalpha' then
      local name = string.sub(callback, 8)
      local ls = playerData[name].longString
      ls.alpha =  1.0 - ls.alpha
      do_showLongString(ls, name)
   else
      return false
   end
   return true
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

   for _, v in ipairs(ids) do
      remove(v)
   end
end
defaultMap = '90'
UI_DEFAULT = false
MTYPE = 0

curMap = defaultMap

playerData = {}
objectData = {}
groundData = {}
jointData = {}
function getfield(var, err)
   local t = _G

   for p, k in string.gmatch(var, '([[.]?)([^][.]+)') do
      if type(t) ~= 'table' then
         if err then
            error('Invalid field: ' .. var)
         else
            return nil
         end
      end

      if p == '[' then
         k = do_parse_arg(k, nil)
         if k == nil then
            if err then
               error('Invalid field: ' .. var)
            else
               return nil
            end
         end
      end

      t = t[k]
   end

   return t
end

function do_parse_arg(str, iter)
   if str == 'true' then
      return true
   elseif str == 'false' then
      return false
   elseif str == 'nil' then
      return nil
   elseif str == '{' then
      if iter ~= nil then
         return parse_arg(iter, str)
      else
         return nil
      end
   else
      local tmp = string.sub(str, 1, 1)
      if tmp == '"' or tmp == "'" then
         return unescape(string.sub(str, 2, -2))
      else
         tmp = tonumber(str)
         if tmp ~= nil then
            return tmp
         else
            return getfield(str, true)
         end
      end
   end
end

function do_parse_key(str)
   local tmp

   while true do
      if str == 'true' then
         return true
      elseif str == 'false' then
         return false
      else
         local tmp = string.sub(str, 1, 1)
         if tmp == '"' or tmp == "'" then
            return unescape(string.sub(str, 2, -2))
         elseif tmp == '[' then
            str = string.sub(str, 2, -2)
         else
            tmp = tonumber(str)
            if tmp ~= nil then
               return tmp
            else
               return unescape(str)
            end
         end
      end
   end
end

function parse_arg(iter, str)
   local ret
   local s1, s2

   if str == nil then
      str = iter()
   end

   if str == nil then
      return nil, true
   elseif str == '{' then
      ret = {}
      str = iter()
      while str ~= nil and str ~= '}' do
         s1, s2 = string.gmatch(str, '(.+)=(.+)')()
         if s1 == nil then
            ret[#ret + 1] = do_parse_arg(str, iter)
         else
            ret[do_parse_key(s1)] = do_parse_arg(s2, iter)
         end
         str = iter()
      end
      return ret, str == nil
   else
      return do_parse_arg(str), false
   end
end

function call(func, args_s, get)
   local args = {}
   local argc = 0
   local iter = string.gmatch(args_s, '[^%s]+')

   local arg, exit = parse_arg(iter)

   while not exit do
      argc = argc + 1
      args[argc] = arg
      arg, exit = parse_arg(iter)
   end

   if get then
      return { func, args, argc }
   else
      return func(unpack(args, argc))
   end
end
MODULE_HELP_START = 'Commands'

MODULE_HELP_CONTENTS = [[<font face="mono" size="15"><a href="event:Commands">Commands</a></font>
]]

MODULE_HELP = {
      ['Commands'] = [[<font face="mono" size="15">!help

!init

!s &lt;command&gt;

!ui [!]me|all|&lt;name&gt;...

!r
!reset
    tfm.exec.newGame(curMap)

!m [&lt;map&gt;]
!map [&lt;map&gt;]
    tfm.exec.newGame()

!mtype 0|1|2

!dir &lt;variable&gt;

!dump &lt;value&gt;

!&lt;function&gt; [&lt;value&gt;...]

!do

!end

!redo

!undo
</font>
]]
}

MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'
function changeUI(name)
   local data = playerData[name]
   data.ui = not data.ui
   if data.ui then
      ui.addTextArea(104, '<TI><a href="event:help"><p align="center">Help</p></a>', name, 5, 25, 40, 22, nil, nil, nil, true)
      ui.addTextArea(ERROR_TA, table.concat(_errors), name, 805, 5, 200, 590, nil, nil, 0.5, true)
   else
      ui.removeTextArea(104, name)
      ui.removeTextArea(ERROR_TA, name)
   end
end

MODULE_CHAT_COMMAND = {
   ['help'] = help,

   ['s'] = function(name, cmdl, arg)
      eventChatCommand(name, arg)
   end,

   ['ui'] = function(name, cmdl, arg)
      parsePlayerNames(name, arg, changeUI)
   end,

   ['mtype'] = function(name, cmdl, arg)
      local a = tonumber(arg)
      if a == nil or a < 0 or a > 2 then
         alert('Invalid value for MTYPE: ' .. arg, name)
      end
      MTYPE = a
   end,
   ['control'] = function(name, cmdl, arg)
      arg = string.lower(arg)
      arg = string.gsub(arg, '^%l', string.upper)
      playerData[name].cntl = {
         name = arg,
         obj = objcode.anvil,
         off = 32,
         da = 0
      }
   end,

   ['reset'] = function()
      setMap(curMap)
   end,
   ['map'] = function(name, cmdl, arg)
      if arg == '' then
         arg = defaultMap
      end
      setMap(arg)
      curMap = arg
   end,

   ['init'] = function()
      defaultMap = '0'
      curMap = defaultMap
      playerData = {}
      for k, v in pairs(tfm.get.room.playerList) do
         eventNewPlayer(k)
      end
      setMap(curMap)
   end,

   ['dir'] = function(name, cmdl, arg)
      local str = ''
      local status, var = pcall(getfield, arg)
      if status then
         if type(var) == 'table' then
            for k, v in pairs(var) do
               str = str .. k .. '\n'
            end
            showLongString(arg, str, name, 0.8)
         else
            alert(arg .. ' is not a table', name)
         end
      else
         alert(var, name)
      end
   end,
   ['dump'] = function(name, cmdl, arg)
      local status, ret = pcall(call, dump, arg)
      if status then
         showLongString(arg, ret, name, 0.8)
      else
         alert(ret, name)
      end
   end,

   ['do'] = function(name)
      local data = playerData[name]
      data.append = true
      data.newFunction = {}
   end,

   ['end'] = function(name, cmdl)
      local data = playerData[name]
      if cmdl == 'end' then
         data.append = false
         data.lastFunction = data.newFunction
      end
      local status, err
      for _, f in pairs(data.lastFunction) do
         status, err = pcall(call, f[1], f[2])
         if not status then
            alert(err, name)
            break
         end
      end
   end,

   ['undo'] = function(name)
      local data = playerData[name]
      data.append = false
      data.newFunction = {}
   end
}

MODULE_CHAT_COMMAND['redo'] = MODULE_CHAT_COMMAND['end']
MODULE_CHAT_COMMAND['r'] = MODULE_CHAT_COMMAND['reset']
MODULE_CHAT_COMMAND['m'] = MODULE_CHAT_COMMAND['map']

MODULE_CHAT_COMMAND_1 = function(name, cmd, arg)
   local func = getfield(cmd)
   local data = playerData[name]
   if type(func) == 'function' then
      if data.append then
         data.newFunction[#data.newFunction + 1] = {func, arg}
      else
         data.lastFunction = {{func, arg}}
         local status, err = pcall(call, func, arg)
         if not status then
            alert(err, name)
         end
      end
   else
      alert('Invalid command: ' .. cmd, name)
   end
end

system.disableChatCommandDisplay('s', true)
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
   do_respawn(name)
end

function eventPlayerLeft(name)
   playerData[name] = nil
end

function eventNewGame()
   initTimers()

   tfm.exec.disableAfkDeath(true)
   tfm.exec.disableAutoNewGame(true)
   tfm.exec.disableAutoScore(true)
   tfm.exec.setGameTime(0)

   objectData = {}
   groundData = {}
   jointData = {}
   
   do_addGround(0, 0, 0, { type=13 })
end

function eventPlayerDied(name)
   do_respawn(name)
end

function eventPlayerWon(name)
   do_respawn(name)
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
end
function clear()
   for k, v in ipairs(keys(tfm.get.room.objectList)) do
      do_removeObject(v)
   end
end

function map1(w, h, s)
   local m = emptyMap(w, h, s)
   setMap(m)
   curMap = m
end
for k, v in pairs(tfm.get.room.playerList) do
   eventNewPlayer(k)
end

setMap(defaultMap)
