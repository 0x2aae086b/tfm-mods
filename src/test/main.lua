function clear()
   for k, v in ipairs(keys(tfm.get.room.objectList)) do
      removeObject(v)
   end
end

for k, v in pairs(tfm.get.room.playerList) do
   eventNewPlayer(k)
end

setMap(defaultMap)
