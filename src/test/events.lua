function eventNewPlayer(name)
   playerData[name] = {
      lastFunction = {},
      newFunction = {},
      append = false
   }
   ui.addTextArea(104, '<TI><a href="event:help"><p align="center">Help</p></a>', name, 5, 25, 40, 22, nil, nil, nil, true)
   ui.addTextArea(ERROR_TA, table.concat(_errors), name, 805, 5, 200, 590, nil, nil, 0.5, true)
   --tfm.exec.setShaman(name)
   do_respawn(name)
end

function eventPlayerLeft(name)
   playerData[name] = nil
end

function eventNewGame()
   tfm.exec.disableAfkDeath(true)
   tfm.exec.disableAutoNewGame(true)
   tfm.exec.disableAutoScore(true)
   tfm.exec.setGameTime(0)
   tfm.exec.addPhysicObject(0, 0, 0, { type=13, color=0xFFFFFF })
end

function eventPlayerDied(name)
   do_respawn(name)
end

function eventPlayerWon(name)
   do_respawn(name)
end

function eventTextAreaCallback(id, name, callback)
   if not lsTextAreaCallback(id, name, callback) then
      helpTextAreaCallback(id, name, callback)
   end
end
