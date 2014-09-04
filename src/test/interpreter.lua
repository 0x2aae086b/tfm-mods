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
