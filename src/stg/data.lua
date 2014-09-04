playerData = {}
objectData = {}
groundData = {}
jointData = {}
patternData = {}
bulletData = {}

groundId = {
   max = 0,
   free = {}
}

jointId = {
   max = 0,
   free = {}
}

patternId = {
   max = 0,
   free = {}
}

bulletId = {
   max = 0,
   free = {}
}

bombs = {
   top = 0,
   val = {}
}

playerKeys = { 32, 83, 40, 100, 101, 102, 104, 81, 68, 69, 82, 87, 37, 39 }
reservedKeys = invert(playerKeys, true)

eventCode = {
   key = keycode,
   obj = objcode,
   objend = objcode
}

defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'
maxLives = 8
maxBombs = 6

shotTypes = {
   {
      func = defaultShot,
      cd = 1
   },
   {
      func = homingShot,
      cd = 2
   }
}

bombTypes = {
   {
      name = 'default bomb',
      func = defaultBomb,
      callback = defaultBombCallback,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 20,
      cd = 0
   },
   {
      name = '',
      func = bomb2,
      callback = nil,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 20,
      cd = 5
   },
   {
      name = '',
      func = bomb3,
      callback = nil,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 6,
      cd = 5
   }
}

patternTypes = {
   {
      func = testPattern,
      time = 0,
      callback = nil,

      cd = 250,
      points = 1,

      maxBinds = 3,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   }
}

playerConfig = {
   Cafecafe = {
      bomb = bombTypes[3],
      color = '0xB06FFD'
   }
}
