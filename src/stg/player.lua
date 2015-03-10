do_respawn_1 = do_respawn

function do_respawn(name)
   do_respawn_1(name)
   local s = playerData[name].spawn
   movePlayer(name, s[0], s[1], false, 0, 0, true)
end

function initPlayer(name)
   local data = {
      color = randomColor(),

      shooting = false,
      bombing = false,
      focused = false,

      shot = shotTypes[1],

      bomb = bombTypes[1],
      bombTime = nil,

      patterns = {
         key = {},
         obj = {},
         objend = {}
      },
      pattern_data = {},

      spawn = { 200, 200 },

      speed = 50,
      focusedSpeed = 35,
      curSpeed = 50,
      vx = 0,
      vy = 0,

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

   for k, v in ipairs(playerKeys) do
      bindKey(name, v, true, true)
      bindKey(name, v, false, true)
   end

   system.bindMouse(name, true)

   ui.addTextArea(1, getText(data), name, 5, 25, 151, 40, nil, nil, 0.5, true)
   ui.addTextArea(104, '<TI><a href="event:help">?</a>', name, 145, 25, 11, 20, nil, nil, 0.0, true)
   ui.addTextArea(ERROR_TA, table.concat(_errors), name, 805, 5, 200, 590, nil, nil, 0.5, true)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, playerData[name].color)
end

function resetPlayer(name)
   local data = playerData[name]

   copy(data, RESET)

   updateTextAreas(name, data)

   do_respawn(name)
   setShaman(name)
   setNameColor(name, data.color)
end

function deletePlayer(name)
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

function movePlayer1(name, data, vx, vy, down)
   if vx then
      if down then
         data.vx = vx
         vx = vx * data.curSpeed
         if data.vx > 0 then
            data.dir = 1
         else
            data.dir = -1
         end
         movePlayer(name, 0, 0, false, vx, 0, false)
      else
         data.vx = 0
         movePlayer(name, 0, 0, false, 1, 0, false)
         movePlayer(name, 0, 0, false, -1, 0, true)
      end
   elseif vy then
      if down then
         data.vy = vy
         vy = vy * data.curSpeed
         movePlayer(name, 0, 0, false, data.vx * data.curSpeed, vy, false)
      else
         data.vy = 0
         movePlayer(name, 0, 0, false, 0, -1, false)
         movePlayer(name, 0, 0, false, 0, 1, true)
      end
   else
      return false
   end
   return true
end
