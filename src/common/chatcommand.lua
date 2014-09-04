function eventChatCommand(name, message)
   local i, j
   local cmd, arg

   for k, v in ipairs({{'&lt;', '<'}, {'&amp;', '&'}}) do
      message = string.gsub(message, v[1], v[2])
   end

   while true do
      i, j = string.find(message, '%s+')

      if i == nil then
         cmd = message
         arg = ''
         break
      elseif i == 1 then
         message = string.sub(message, j + 1)
         if message == '' then
            cmd = ''
            arg = ''
            break
         end
      else
         cmd = string.sub(message, 1, i - 1)
         arg = string.sub(message, j + 1)
         break
      end
   end

   local cmdl = string.lower(cmd)
   local func = MODULE_CHAT_COMMAND[cmdl]

   if func ~= nil then
	  func(name, cmdl, arg)
   else
	  MODULE_CHAT_COMMAND_1(name, cmd, arg)
   end
end
