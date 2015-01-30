function do_addControl(controls, control)
   controls[#controls + 1] = control
end

function do_removeControl(controls, idx)
   while controls[idx] do
      controls[idx] = nil
      idx = idx + 1
   end
end

function motionEnd(id, data)
   do_removeControl(data.callback_args._controls, data.callback_args._idx)
end

function addControl(controls, ...)
   local idx = #controls + 1
   local id = addGround(...)
   local data = groundData[id]
   if data.callback_args == nil then
      data.callback_args = { _controls = controls, _idx = idx }
   else
      data.callback_args._controls = controls
      data.callback_args._idx = idx
   end
   if data.on_remove == nil then
      data.on_remove = { motionEnd }
   else
      data.on_remove[#data.on_remove + 1] = motionEnd
   end
   controls[#controls + 1] = id
   return id
end

function addControl1(controls, ...)
   return addGround(...)
end

function addMotion(mtype, id, is_bullet, args)
   local data
   local ac
   if is_bullet then
      data = bulletData[id].controls
      ac = addControl
   else
      data = { id }
      ac = addControl1
   end
   local st, err = pcall(mtype, ac, data, args)
   if not st then
      error(string.format("addMotion: %s", err))
   end
end
