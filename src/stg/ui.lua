function getText(data)
   local lives = data.lives - 1
   local bombs = data.bombs

   if lives >= maxLives then
      lives = maxLives - 1
   elseif lives < 0 then
      lives = 0
   end

   if bombs > maxBombs then
      bombs = maxBombs
   elseif bombs < 0 then
      bombs = 0
   end

   return string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',
                        string.rep('★', lives), string.rep('★', bombs)
   )
end

function updateTextAreas(name, data)
   ui.updateTextArea(1, getText(data), name)
   ui.updateTextArea(104, '<TI><a href="event:help">?</a>', name)
end
