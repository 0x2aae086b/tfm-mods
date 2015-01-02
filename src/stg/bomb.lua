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
