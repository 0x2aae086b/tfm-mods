function clear()
   for k, v in ipairs(keys(tfm.get.room.objectList)) do
      do_removeObject(v)
   end
end

function map1(w, h, s)
   local m = emptyMap(w, h, s)
   setMap(m)
   curMap = m
   curMapXML = m
end
