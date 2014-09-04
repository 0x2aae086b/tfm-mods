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
