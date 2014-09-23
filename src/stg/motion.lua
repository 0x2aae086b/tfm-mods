function motionEnd(id, data)
   local a = data.callback_args
   if a._on_remove then
      a._on_remove(id, data)
   end
   do_removeControl(a._controls, id)
end

function addControl(controls, ...)
   local id = addGround(...)
   local data = groundData[id]
   data.callback_args._on_remove = data.on_remove
   data.callback_args._controls = controls
   data.on_remove = motionEnd
   controls[#controls + 1] = id
   return id
end

function addControl1(controls, ...)
   return addGround(...)
end

function addMotion(type, id, is_bullet, ...)
   if is_bullet then
      local data = bulletData[id]
      return type(addControl, bulletData[id].controls, ...)
   else
      return type(addControl1, {id}, ...)
   end
end
