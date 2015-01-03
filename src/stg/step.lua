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
