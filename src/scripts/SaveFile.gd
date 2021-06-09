extends Resource
class_name Save
#sys
export(Array) var mods

#game
export(int, 0, 13) var hm
export(Array) var party
export(Array) var inv
export(Dictionary) var invS
export(String) var location

export(Dictionary) var kevin = { #stats show base, not bonuses
  "LVL":1,
  "HP":20, #health
  "DEF":10, #defense
  "EVA":8, #evasion
  "ATK":12, #attack
  "LV":1, #level
  "EXP":0, #experience
  "PRO":0, #proficiency/times the exp 0x up to 3x
  "CHR":0, #charm
  "LUC":0, #luck/chance of crit hit
  "god":[],
  "equip":[],
}

export(Dictionary) var quinton = {
  "LVL":1,
  "HP":17,
  "DEF":25,
  "EVA":6,
  "ATK":8,
  "LV":1,
  "EXP":0,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "equip":[],
}

export(Dictionary) var bella = {
  "LVL":1,
  "HP":17,
  "DEF":25,
  "EVA":6,
  "ATK":8,
  "LV":1,
  "EXP":0,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "equip":[],
}

export(Dictionary) var charlie = {
  "LVL":1,
  "HP":17,
  "DEF":25,
  "EVA":6,
  "ATK":8,
  "LV":1,
  "EXP":0,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "equip":[],
}

#settings
export(float) var sfxvol
export(float) var bgmvol
export(bool) var voice
export(String) var lang
