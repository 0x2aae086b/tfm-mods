function emptyMap(w, h, s, s1)
   local w2, h2 = w / 2.0, h / 2.0
   local x, y
   local t = { string.format('<C><P G="0,0" L="%d" H="%d" /><Z><S>', w, h) }
   s = s or 256
   s1 = s1 or s
   for x = 16, w, s do
      for y = 16, h, s1 do
         t[#t + 1] = string.format('<S o="%02x00%02x" L="16" Y="%d" c="4" P="0,0,0,0,0,0,0,0" T="13" X="%d" H="10" />', math.abs(w2 - x) / w2 * 255, math.abs(h2 - y) / h2 * 255, y, x)
      end
   end
   t[#t + 1] = '</S><D><DS X="200" Y="200" /></D><O /></Z></C>'
   return table.concat(t)
end
