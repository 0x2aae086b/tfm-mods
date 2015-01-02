function addError(name, err)
   err = string.format("• %s\n", err)
   local l = #errors
   if l == MAX_ERRORS then
      for i = 3, l do
         errors[i] = errors[i - 1]
      end
      errors[2] = err
   else
      errors[l + 1] = err
   end
   ui.addTextArea(3, table.concat(errors), nil, 805, 5, 200, 590, nil, nil, 0.5, true)
end

function getText(data)
   local lives = data.lives - 1
   local bombs = data.bombs

   if lives >= maxLives then
      lives = maxLives - 1
   end
   if lives < 0 then
      lives = 0
   end

   if bombs > maxBombs then
      bombs = maxBombs
   elseif bombs < 0 then
      bombs = 0
   end

   if data.lives < 1 then
      l = 0
   else
      l = data.lives
   end

   return string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',
                        string.rep('★', lives),
                        string.rep('★', bombs)
   )
end

function updateTextAreas(name, data)
   ui.updateTextArea(1, getText(data), name)
   ui.updateTextArea(104, '<TI><a href="event:help">?</a>', name)
end
