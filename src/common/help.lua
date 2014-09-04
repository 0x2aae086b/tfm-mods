function help(name)
   ui.addTextArea(100, MODULE_HELP[MODULE_HELP_START], name, 258, 78, 421, 284, nil, nil, nil, true)
   ui.addTextArea(101, string.format('<p align="center"><font face="mono" size="15">%s</font></p>', MODULE_HELP_START), name, 258, 50, 398, 20, nil, nil, nil, true)
   ui.addTextArea(102, MODULE_HELP_CONTENTS, name, 100, 50, 150, 312, nil, nil, nil, true)
   ui.addTextArea(103, MODULE_HELP_CLOSE, name, 664, 50, 15, 20, nil, nil, nil, true)
end

function helpTextAreaCallback(id, name, callback)
   if callback == 'help' then
      help(name)
   elseif callback == 'help_close' and id == 103 then
      ui.removeTextArea(100, name)
      ui.removeTextArea(101, name)
      ui.removeTextArea(102, name)
      ui.removeTextArea(103, name)
   else
      local str = MODULE_HELP[callback]
      if str ~= nil then
         ui.updateTextArea(100, str, name)
         ui.updateTextArea(101, string.format('<font face="mono" size="15"><p align="center">%s</p></font>', callback), name)
      else
         return false
      end
   end
   return true
end
