TIME = os.time()
TIMER_RES = 250

_timerId = {
   max = 0,
   free = {}
}

_timerData = {
}

function initTimers()
   TIME = os.time()
   _timerId = {
      max = 0,
      free = {}
   }
   _timerData = {}
end

function timer()
   local cur = os.time()
   while TIME + TIMER_RES <= cur do
      eventTimer()
      TIME = TIME + TIMER_RES
   end
end

function timers()
   local cur = os.time()
   local t, st, ret
   for k, v in ipairs(_timerData) do
      t = v.time
      ret = true
      while t + v.res <= cur do
         t = t + v.res
         st, ret = pcall(v.func, k, v)
         if not st then
            addError(string.format('timer %d: %s', k, ret))
            ret = false
         end
         if not ret then
            break
         end
      end
      if ret then
         v.time = t
      else
         removeTimer(k)
      end
   end
end

function addTimer(func, args, res)
   local id = newId(_timerId)
   _timerData[id] = {
      func = func,
      args = args,
      res = res,
      time = os.time()
   }
end

function removeTimer(id)
   freeId(_timerId, id)
end
