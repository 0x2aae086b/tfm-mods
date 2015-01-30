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
