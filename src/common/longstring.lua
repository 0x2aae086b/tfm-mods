function split1(str, pattern, maxlen, fmt)
   if fmt == nil then
      fmt = '%s'
   end

   maxlen = maxlen - #fmt + 2

   local len = #str

   if len <= maxlen then
      return { string.format(fmt, str) }
   end

   local ret = {}

   local start = 1
   local prev_i, prev_j
   local i, j = string.find(str, pattern)

   while i ~= nil do
      if i - start > maxlen then
         if prev_i ~= nil and prev_i > start then
            ret[#ret + 1] = string.format(fmt, string.sub(str, start, prev_i - 1))
            start = prev_j + 1
         end
         while i - start > maxlen do
            ret[#ret + 1] = string.format(fmt, string.sub(str, start, start + maxlen - 1))
            start = start + maxlen
         end
      end

      prev_i, prev_j = i, j

      i, j = string.find(str, pattern, j + 1)

      if i == nil and prev_j < len then
         i, j = len, len
      end
   end

   if start < len then
      ret[#ret + 1] = string.format(fmt, string.sub(str, start, len))
   end

   return ret
end

function do_showLongString(ls, name)
   ui.addTextArea(ls.id, ls.pages[ls.page], name, 100, 80, 579, 284, nil, nil, ls.alpha, true)
   ui.addTextArea(ls.id + 1, string.format('<a href="event:lsalpha%s"><p align="center"><font face="mono" size="15">%s</font></p></a>', name, ls.title), name, 100, 50, 400, 22, nil, nil, ls.alpha, true)
   ui.addTextArea(ls.id + 2, string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>', ls.page, ls.maxPage), name, 508, 50, 148, 22, nil, nil, ls.alpha, true)
   ui.addTextArea(ls.id + 3, '<TI><a href="event:lsclose"><p align="center">X</p></a>', name, 664, 50, 15, 22, nil, nil, ls.alpha, true)
end

function showLongString(title, str, name, alpha)
   if alpha == nil then
      alpha = 1
   end

   local pages = split1(str, '\n', 2000, '<font face="mono" size="15">%s</font>')
   local p = #pages

   ls = {
      id = 200,
      title = title,
      pages = pages,
      page = 1,
      alpha = alpha,
      maxPage = p
   }

   if playerData[name] == nil then
      playerData[name] = {}
   end

   playerData[name].longString = ls

   do_showLongString(ls, name)
end

function updateLongString(name, ls)
   ui.updateTextArea(ls.id, ls.pages[ls.page], name)
   ui.updateTextArea(ls.id + 2, string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>', ls.page, ls.maxPage), name)
end

function lsTextAreaCallback(id, name, callback)
   if callback == 'next' then
      local ls = playerData[name].longString
      local p = ls.page
      if p < ls.maxPage then
         ls.page = p + 1
      end
      updateLongString(name, ls)
   elseif callback == 'prev' then
      local ls = playerData[name].longString
      local p = ls.page
      if p > 1 then
         ls.page = p - 1
      end
      updateLongString(name, ls)
   elseif callback == 'lsclose' then
      ui.removeTextArea(id - 3, name)
      ui.removeTextArea(id - 2, name)
      ui.removeTextArea(id - 1, name)
      ui.removeTextArea(id, name)
      playerData[name].longString = nil
   elseif string.sub(callback, 1, 7) == 'lsalpha' then
      local name = string.sub(callback, 8)
      local ls = playerData[name].longString
      ls.alpha =  1.0 - ls.alpha
      do_showLongString(ls, name)
   else
      return false
   end
   return true
end
