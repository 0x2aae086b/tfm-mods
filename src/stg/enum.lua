keycode = {
   backspace = 8,
   enter = 13,
   shift = 16,
   ctrl = 17,
   alt = 18,
   capslock = 20,
   esc = 27,
   space = 32,

   ['0'] = 48, ['1'] = 49, ['2'] = 50, ['3'] = 51, ['4'] = 52,
   ['5'] = 53, ['6'] = 54, ['7'] = 55, ['8'] = 56, ['9'] = 57,

   a = 65, b = 66, c = 67, d = 68, e = 69, f = 70, g = 71, h = 72, i = 73,
   j = 74, k = 75, l = 76, m = 77, n = 78, o = 79, p = 80, q = 81, r = 82,
   s = 83, t = 84, u = 85, v = 86, w = 87, x = 88, y = 89, z = 90,

   [';'] = 186, ['='] = 187, [','] = 188, ['-'] = 189, ['.'] = 190,
   ['/'] = 191, ['`'] = 192,

   [':'] = 186, ['+'] = 187, ['<'] = 188, ['_'] = 189, ['>'] = 190,
   ['?'] = 191, ['~'] = 192,

   ['['] = 219, ['\\'] = 220, [']'] = 221, ["'"] = 222,
   ['{'] = 219, ['|'] = 220,  ['}'] = 221, ['"'] = 222,

   [')'] = 48, ['!'] = 49, ['@'] = 50, ['#'] = 51, ['$'] = 52,
   ['%'] = 53, ['^'] = 54, ['&'] = 55, ['*'] = 56, ['('] = 57,

   kp0 = 96,  kp1 = 97,  kp2 = 98,  kp3 = 99,  kp4 = 100,
   kp5 = 101, kp6 = 102, kp7 = 103, kp8 = 104, kp9 = 105,

   ['kp*'] = 106, ['kp+'] = 107, ['kp-'] = 109, ['kp.'] = 110, ['kp/'] = 111,

   left = 37,
   up = 38,
   right = 39,
   down = 40,

   f1 = 112, f2 = 113, f3 = 114, f4 = 115,  f5 = 116,  f6 = 117,
   f7 = 118, f8 = 119, f9 = 120, f10 = 121, f11 = 122, f12 = 123
}

particles = {
   white = 0,
   purple = 1,
   orange = 2,
   soft_white = 4,
   teal = 9,
   yellow = 11,
   red = 13,

   spawn = 3,

   heart = 5,
   red_heart = 30,
   pink_heart = 31,

   bubble = 6,
   bubble1 = 7,
   bubble2 = 8,
   water = 14,

   spirit = 10,
   red_spirit = 12,

   plus1 = 15,
   plus10 = 16,
   plus12 = 17,
   plus14 = 18,
   plus16 = 19,

   meep = 20,

   red_confetti = 21,
   green_confetti = 22,
   blue_confetti = 23,
   yellow_confetti = 24,

   rain = 25,
   wind = 26,
   wind1 = 27,
   lightning = 28,

   star = 29,
   flower = 32
}

objcode = {
   arrow = 0,
   small_box = 1,
   box = 2,
   small_plank = 3,
   plank = 4,
   ball = 6,
   trampoline = 7,
   anvil = 10,
   anvil1 = 1002,
   B = 11,
   Bc = 12,
   Bcc = 13,
   V = 14,
   Vc = 15,
   Vcc = 16,
   cannon_up = 17,
   cannon_down = 18,
   cannon_right = 19,
   cannon_left = 20,
   C = 22,
   bomb = 23,
   spirit = 24,
   cheese = 25,
   blue_portal = 26,
   orange_portal = 27,
   balloon1 = 2806,
   balloon = 28,
   red_balloon = 29,
   green_balloon = 30,
   yellow_balloon = 31,
   rune = 32,
   snow = 34,
   arrow1 = 35,
   apple = 39,
   sheep = 40,
   demolition = 41,
   totem = 44,
   ice_plank = 45,
   choco_plank = 46,
   cloud = 57,
   architect = 58,
   bubble = 59,
   tiny_plank = 60,
   companion_crate = 61,
   stable_rune = 62,
   ballon_anchor = 66,
   windmill_anchor = 88
}

copy(objcode, tfm.enum.shamanObject)
