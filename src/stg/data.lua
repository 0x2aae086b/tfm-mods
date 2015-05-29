playerData = {}
objectData = {}
groundData = {}
jointData = {}
patternData = {}
bulletData = {}

MAX_ID = 400
MAX_ERRORS = 7

GROUND0 = {
   type = 13,
   color = 0xFFFFFF,
   dynamic = false,
   miceCollision = false,
   groundCollision = false
}

CONTROL = {
   type = 13,
   dynamic = true,
   mass = 1,
   groundCollision = false,
   miceCollision = false
}

IFJOINT = {
   type = 2,
   point2 = '0,0',
   point3 = '0,0',
   point4 = '0,0'
}

IF1JOINT = {
   type = 1,
   axis = '3,2',
   angle = 0,
   forceMotor = 255
}

RESET = {
   shooting = false,
   bombing = false,
   lives = 5,
   bombs = 3,
   shot_cd = 0,
   bomb_cd = 0,
   vx = 0
}

playerKeys = {
   kc.space,
   kc.w, kc.s, kc.a, kc.d,
   kc.left, kc.right, kc.up, kc.down,
   kc.kp4, kc.kp6, kc.kp8, kc.kp5,
   kc.e, kc.q,
   kc.shift
}
reservedKeys = invert(playerKeys, true)

pk_vx = {
   [kc.a] = -1,
   [kc.left] = -1,
   [kc.kp4] = -1,
   [kc.d] = 1,
   [kc.right] = 1,
   [kc.kp6] = 1
}

pk_vy = {
   [kc.space] = -1,
   [kc.w] = -1,
   [kc.up] = -1,
   [kc.kp8] = -1,
   [kc.s] = 1,
   [kc.down] = 1,
   [kc.kp5] = 1
}

eventCode = {
   key = keycode,
   obj = objcode,
   objend = objcode
}

mapWidth = 1600
mapHeight = 800
defaultMap = emptyMap(mapWidth, mapHeight)
X_MIN = 16
X_MAX = mapWidth - 16
Y_MIN = 16
Y_MAX = mapHeight - 16

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

      cd = 1000,
      points = 1,

      maxBinds = 2,

      restrict = {
         key = {},
         obj = nil,
         objend = nil
      },
   },
   {
      func = testPattern4,
      callback = nil,

      cd = 250,
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
      color = 0xB06FFD --0x9852B4
   },
   Rar = {
      color = 0x553399
   }
}
