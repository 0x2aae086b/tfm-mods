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
