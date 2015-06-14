shoot = {
   function(player, data, spd, cntl)
      local da = math.random(-10, 10)
      local a
      for a = da - 15, da + 15, 15 do
         c = math.rad(a)
         s = math.sin(c)
         c = math.cos(c) * data.dir
         addObject(cntl.obj, player.x + c * cntl.off, player.y + s * cntl.off, a, spd * c, spd * s, false, 10)
      end
   end,

   function(player, data, spd, cntl)
      local a
      local c, s
      cntl.da = (cntl.da + 10) % 60
      for a = cntl.da, 359 + cntl.da, 60 do
         c = math.rad(a)
         s = math.sin(c)
         c = math.cos(c)
         addObject(cntl.obj, player.x + c * cntl.off, player.y + s * cntl.off, a, spd * c, spd * s, false, 10)
      end
   end
}
