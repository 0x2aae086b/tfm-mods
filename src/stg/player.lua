function initPlayer(name)
   local data = {
      color = randomColor(),

      shooting = false,
      bombing = false,

      shot = shotTypes[1],

      bomb = bombTypes[1],
      bombTime = nil,

      patterns = {
         key = {},
         obj = {},
         objend = {}
      },
      pattern_data = {},

      lives = 5,
      bombs = 3,
      resetBombs = 3,

      shot_cd = 0,
      bomb_cd = 0,

      bomb_id = nil
   }

   if playerConfig[name] == nil then
      playerConfig[name] = {}
   end

   copy(data, playerConfig[name])

   playerData[name] = data

   for k, v in pairs(playerKeys) do
      bindKey(name, v, true, true)
      bindKey(name, v, false, true)
   end

   --system.bindMouse(name, true)

   ui.addTextArea(1, getText(data), name, 5, 25, 150, 38, nil, nil, nil, true)
   ui.addTextArea(104, '<TI><a href="event:help">?</a>', name, 145, 25, 10, 20, nil, nil, nil, true)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, playerData[name].color)
end

function resetPlayer(name)
   local reset = {
      shooting = false,
      bombing = false,
      bombTime = nil,

      lives = 5,
      bombs = 3,

      shot_cd = 0,
      bomb_cd = 0,

      bomb_id = nil
   }

   local data = playerData[name]

   copy(data, reset)

   updateTextAreas(name, data)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, data.color)
end

function deletePlayer(name)
   --ui.removeTextArea(1, name)
   local data = playerData[name]
   if data.bombing then
      removeBomb(name, data)
   end
   playerData[name] = nil
end

function respawn(name)
   do_respawn(name)
   setNameColor(name, playerData[name].color)
end