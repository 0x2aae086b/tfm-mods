MODULE_HELP_START = 'Keys'

MODULE_HELP_CONTENTS = [[<font face="mono" size="15"><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
<a href="event:Pattern types">Pattern types</a>
<a href="event:Shaman objects">Shaman objects</a>
]]
--<a href="event:Key codes">Key codes</a></font>

MODULE_HELP = {
      ['Keys'] = [[<font face="mono" size="15">Shoot - E
Bomb  - Q
Up    - W, ↑, Space
Down  - S, ↓
Left  - A, ←
Right - D, →</font>
]],
      ['Commands'] = [[<font face="mono" size="15">!help

!clear

!color [&lt;color&gt;]

!reset [map]
    tfm.exec.newGame(defaultMap)

!reset [!]me|all|&lt;name&gt;...
    resetPlayer()

!init [!]me|all|&lt;name&gt;...
    deletePlayer()
    initPlayer()

!respawn [!]me|all|&lt;name&gt;...
    tfm.exec.respawnPlayer()

!map [&lt;map&gt;]
    tfm.exec.newGame()

!shot [type]

!bomb [type]

!bind &lt;pattern&gt; key|obj|objend &lt;name|code&gt;

!unbind [all]
!unbind key|obj|objend [&lt;name|code&gt;]
</font>
]]
}

MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'

do
   local desc = function(t, n)
      local ret = {'<font face="mono" size="15">'}
      for k, v in ipairs(t) do
         if v.name then
            ret[#ret + 1] = string.format('%d - %s\n', k, v.name)
         else
            ret[#ret + 1] = string.format('%d\n', k)
         end
         if v.cost then
            ret[#ret + 1] = string.format('    Cost: %d\n', v.cost)
         end
         if v.time then
            ret[#ret + 1] = string.format('    Duration: %fs\n', v.time / 2.0)
         end
         if v.cd then
            ret[#ret + 1] = string.format('    Cooldown: %fs\n', v.cd / n)
         end
         if v.maxBinds then
            ret[#ret + 1] = string.format('    Max. binds: %d\n', v.maxBinds)
         end
         ret[#ret + 1] = '\n'
      end
      return table.concat(ret)
   end
   MODULE_HELP['Shot types'] = desc(shotTypes, 2.0)
   MODULE_HELP['Bomb types'] = desc(bombTypes, 2.0)
   MODULE_HELP['Pattern types'] = desc(patternTypes, 1000.0)
end

do
   local join1 = function(t, w)
      local ret = {'<font face="mono" size="15">'}
      local i

      for v, k in ipairs(keys1(t)) do
         i = w - #k
         if i > 0 then
            v = k .. string.rep(' ', i)
         else
            v = k
         end

         ret[#ret + 1] = string.format('%s = %4d\n', v, t[k])
      end

      ret[#ret + 1] = '</font>'

      return table.concat(ret)
   end

   MODULE_HELP['Shaman objects'] = join1(objcode, 15)
   --MODULE_HELP['Key codes'] = join1(keycode, 2)
end
