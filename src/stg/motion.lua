function motionEnd(id, data)
   do_removeControl(data.callback_args._controls, id)
end

function addControl(controls, ...)
   local id = addGround(...)
   local data = groundData[id]
   if data.callback_args == nil then
      data.callback_args = { _controls = controls }
   else
      data.callback_args._controls = controls
   end
   if data.on_remove == nil then
      data.on_remove = motionEnd
   else
      data.on_remove[#data.on_remove + 1] = motionEnd
   end
   controls[#controls + 1] = id
   return id
end

function addControl1(controls, ...)
   return addGround(...)
end

function addMotion(mtype, id, is_bullet, ...)
   local data
   local ac
   if is_bullet then
      data = bulletData[id].controls
      ac = addControl
   else
      data = { id }
      ac = addControl1
   end
   local st, err = pcall(mtype, ac, data, ...)
   if not st then
      error(string.format("addMotion: %s", err))
   end
end
