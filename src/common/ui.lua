_errors = { '<TI><p align="center">Errors</p>' }

ERROR_TA = 3
MAX_ERRORS = 7

function alert(str, name)
   ui.addPopup(0, 0, string.format('<font face="mono" size="15">%s</font>', str), name, 200, 150, 400, true)
end

function addError(err)
   err = string.format("• %s\n", err)
   for i = #_errors + 1, 3, -1 do
      _errors[i] = _errors[i - 1]
   end
   _errors[2] = err
   _errors[MAX_ERRORS + 1] = nil
   ui.updateTextArea(ERROR_TA, table.concat(_errors), nil)
end
