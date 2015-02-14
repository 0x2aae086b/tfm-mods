playerData = {}
objectData = {}
groundData = {}
jointData = {}
patternData = {}
bulletData = {}

MAX_ID = 400
MAX_ERRORS = 7

CONTROL = {
   type = 13,
   dynamic = true,
   mass = 1,
   groundCollision = false,
   miceCollision = false
}

playerKeys = { 32, 83, 40, 100, 101, 102, 104, 65, 68, 69, 81, --[[87,]] 37, 39, 38, 90 }
reservedKeys = invert(playerKeys, true)

eventCode = {
   key = keycode,
   obj = objcode,
   objend = objcode
}

--defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'
defaultMap='<C><P L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'
mapWidth = 1600
mapHeight = 800

maxLives = 8
maxBombs = 6

shotTypes = {
   {
      name = 'default shot',
      func = defaultShot,
      cd = 1
   },
   {
      name = 'homing anvils',
      func = homingShot,
      cd = 2
   }
}

bombTypes = {
   {
      name = '',
      func = bomb1,
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
      func = bomb2,
      callback = nil,
      shot = {
         func = nop,
         cd = 1
      },
      cost = 1,
      time = 20,
      cd = 5
   }
}

patternTypes = {
   {
      func = testPattern,
      callback = nil,

      cd = 250,
      points = 1,

      maxBinds = 3,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   },
   {
      func = testPattern1,
      callback = nil,

      cd = 500,
      points = 1,

      maxBinds = 3,

      restrict = {
         key = nil,
         obj = nil,
         objend = nil
      },
   },
   {
      func = testPattern2,
      callback = nil,

      cd = 250,
      points = 1,

      maxBinds = 3,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   },
   {
      func = testPattern3,
      callback = nil,

      cd = 16000,
      points = 1,

      maxBinds = 2,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   }
}

playerConfig = {
   Cafecafe = {
      bomb = bombTypes[1],
      color = 0x9852B4 -- 0xB06FFD
   },
   Rar = {
      color = 0x553399
   }
}
