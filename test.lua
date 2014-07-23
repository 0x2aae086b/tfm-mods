defaultMap = "0"

addObject = tfm.exec.addShamanObject
removeObject = tfm.exec.removeObject
movePlayer = tfm.exec.movePlayer
setMap = tfm.exec.newGame
bindKey = tfm.exec.bindKeyboard
respawn = tfm.exec.respawnPlayer
kill = tfm.exec.killPlayer

function getfield(f)
   local v = _G    -- start with the table of globals
   for w in string.gmatch(f, "[%w_]+") do
      if type(v) ~= 'table' then
         return nil
      end
      v = v[w]
   end
   return v
end

function alert(str, name)
   ui.addPopup(0, 0, str, name, 300, 150, 200)
end

function eventNewPlayer(name)
   --tfm.exec.setShaman(name)
   respawn(name)
end

function clear()
   local ids={}

   for i, object in pairs(tfm.get.room.objectList) do
      table.insert(ids, i)
   end

   for k, v in pairs(ids) do
      removeObject(v)
   end
end

function eventChatCommand(name, message)
   local i
   local j
   local cmd
   local arg

   while true do
      i, j = string.find(message, "%s+")

      if i == nil then
         cmd = message
         arg = ""
         break
      elseif i == 1 then
         message = string.sub(message, j + 1)
         if message == "" then
            cmd = ""
            arg = ""
            break
         end
      else
         cmd = string.sub(message, 1, i - 1)
         arg = string.sub(message, j + 1)
         break
      end
   end

   cmd = string.lower(cmd)

   if cmd == "clear" then
      clear()
   elseif cmd == "reset" then
      arg = string.lower(arg)
      setMap(defaultMap)
   elseif cmd == "map" then
      setMap(arg)
   elseif cmd == "dir" then
      local str = "<TI>----" .. arg .. "----\n"
      local var = getfield(arg)
      if var ~= nil then
         for k, v in pairs(var) do
            str = str .. k .. "\n"
         end
         ui.addTextArea(2, str, name, -150, 0, 150, 600)
      end
   elseif cmd == "dump" then
      local str = "<TI>----" .. arg .. "----\n"
      local var = getfield(arg)
      var = DataDumper(var)
      for k, v in ipairs({{'&', '&amp;'}, {'<', '&lt;'}, {'>', '&gt;'}}) do
         var = string.gsub(var, v[1], v[2])
      end
      ui.addTextArea(2, str .. var .. "\n", name, -150, 0, 150, 600)
   end
end

function eventNewGame()
   tfm.exec.disableAfkDeath(true)
   tfm.exec.disableAutoNewGame(true)
   tfm.exec.disableAutoScore(true)
   tfm.exec.setGameTime(0)
end

function eventPlayerDied(name)
   respawn(name)
end

setMap(defaultMap)

-------------------------------------

--[[ DataDumper.lua
Copyright (c) 2007 Olivetti-Engineering SA

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
]]

local dumplua_closure = [[
local closures = {}
local function closure(t) 
  closures[#closures+1] = t
  t[1] = assert(loadstring(t[1]))
  return t[1]
end

for _,t in pairs(closures) do
  for i = 2,#t do 
    debug.setupvalue(t[1], i-1, t[i]) 
  end 
end
]]

local lua_reserved_keywords = {
   'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 
   'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 
   'return', 'then', 'true', 'until', 'while' }

local function keys(t)
   local res = {}
   local oktypes = { stringstring = true, numbernumber = true }
   local function cmpfct(a,b)
      if oktypes[type(a)..type(b)] then
         return a < b
      else
         return type(a) < type(b)
      end
   end
   for k in pairs(t) do
      res[#res+1] = k
   end
   table.sort(res, cmpfct)
   return res
end

local c_functions = {}
for _,lib in pairs{'_G', 'string', 'table', 'math', 
                   'io', 'os', 'coroutine', 'package', 'debug'} do
   local t = _G[lib] or {}
   lib = lib .. "."
   if lib == "_G." then lib = "" end
   for k,v in pairs(t) do
      if type(v) == 'function' and not pcall(string.dump, v) then
         c_functions[v] = lib..k
      end
   end
end

function DataDumper(value, varname, fastmode, ident)
   local defined, dumplua = {}
   -- Local variables for speed optimization
   local string_format, type, string_dump, string_rep = 
      string.format, type, string.dump, string.rep
   local tostring, pairs, table_concat = 
      tostring, pairs, table.concat

   local keycache, strvalcache, out, closure_cnt = {}, {}, {}, 0

   local function index(t, value)
      local res = string_format('%q', value)
      t[value] = res
      return res
   end

   local fcts = {
      string = function(value) return index(strvalcache, value) end,
      number = function(value) return value end,
      boolean = function(value) return tostring(value) end,
      ['nil'] = function(value) return 'nil' end,
      ['function'] = function(value) 
         return string_format("loadstring(%q)", string_dump(value)) 
      end,
      userdata = function() return "<userdata>" end,
      thread = function() return "<thread>" end,
   }
   local function test_defined(value, path)
      if defined[value] then
         if path:match("^getmetatable.*%)$") then
            out[#out+1] = string_format("s%s, %s)\n", path:sub(2,-2), defined[value])
         else
            out[#out+1] = path .. " = " .. defined[value] .. "\n"
         end
         return true
      end
      defined[value] = path
   end
   local function make_key(t, key)
      local s
      if type(key) == 'string' and key:match('^[_%a][_%w]*$') then
         s = key .. "="
      else
         s = "[" .. dumplua(key, 0) .. "]="
      end
      t[key] = s
      return s
   end
   for _,k in ipairs(lua_reserved_keywords) do
      keycache[k] = '["'..k..'"] = '
   end

   fcts.table = function (value)
      -- Table value
      local numidx = 1
      out[#out+1] = "{"
      for key,val in pairs(value) do
         if key == numidx then
            numidx = numidx + 1
         else
            out[#out+1] = make_key(keycache, key)
         end
         local str = dumplua(val)
         out[#out+1] = str..","
      end
      if string.sub(out[#out], -1) == "," then
         out[#out] = string.sub(out[#out], 1, -2);
      end
      out[#out+1] = "}"
      return "" 
   end

   fcts['function'] = function (value, ident, path)
      if true then
         return "<function>"
      end
      if test_defined(value, path) then return "nil" end
      if c_functions[value] then
         return c_functions[value]
      elseif debug == nil or debug.getupvalue(value, 1) == nil then
         return string_format("loadstring(%q)", string_dump(value))
      end
      closure_cnt = closure_cnt + 1
      local res = {string.dump(value)}
      for i = 1,math.huge do
         local name, v = debug.getupvalue(value,i)
         if name == nil then break end
         res[i+1] = v
      end
      return "closure " .. dumplua(res, ident, "closures["..closure_cnt.."]")
   end

   function dumplua(value, ident, path)
      return fcts[type(value)](value, ident, path)
   end
   if varname == nil then
      varname = "return "
   elseif varname:match("^[%a_][%w_]*$") then
      varname = varname .. " = "
   end
   if fastmode then
      out[1] = varname
      table.insert(out,dumplua(value, 0))
      return table.concat(out)
   else
      local items = {}
      for i=1,10 do items[i] = '' end
      items[3] = dumplua(value, ident or 0, "t")
      if closure_cnt > 0 then
         items[1], items[6] = dumplua_closure:match("(.*\n)\n(.*)")
         out[#out+1] = ""
      end
      if #out > 0 then
         items[2], items[4] = "local t = ", "\n"
         items[5] = table.concat(out)
         items[7] = varname .. "t"
      else
         items[2] = varname
      end
      return table.concat(items)
   end
end
