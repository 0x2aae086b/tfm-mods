function shoot(name, data)
   if data.shot_cd == 0 then
      if data.bombing and data.bomb.shot ~= nil then
         data.shot_cd = data.bomb.shot.cd
         data.bomb.shot.func(name, data)
      else
         data.shot_cd = data.shot.cd
         data.shot.func(name, data)
      end
   end
end
