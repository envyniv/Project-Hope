extends Resource
# THE DATA CONTAINED HERE REPLACES FileMan.default_data
class_name Save
#sys
export(Array) var mods

#game
export(String) var name
export(int, 0, 13) var hm #TODO? supposed to be a "secrets" value, kinda like WTF or FUN; doubt i'll use it, but if i do, here it is.
export(Array) var party = ["Kevin"]
export(Array) var inv
export(String) var location = "kevinsbedroom"

export(PoolByteArray) var preview

export(Dictionary) var kevin = { #stats show base, not bonuses
  "LVL":1,
  "HP":20, #health
  "maxHP":20,
  "DEF":10, #defense
  "maxDEF":10,
  "MANA":5,
  "maxMANA":5,
  "EVA":8, #evasion
  "ATK":12, #attack
  "EXP":0, #experience
  "PRO":0, #proficiency/times the exp 0x up to 3x
  "CHR":0, #charm
  "LUC":0, #luck/chance of crit hit
  "god":[],
  "equip":[],
}

export(Dictionary) var quinton = {
  "LVL":1,
  "HP":20, #health
  "maxHP":20,
  "DEF":10, #defense
  "maxDEF":10,
  "MANA":5,
  "maxMANA":5,
  "EVA":6,
  "ATK":8,
  "EXP":0,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "equip":[],
}

export(Dictionary) var bella = {
  "LVL":1,
  "HP":20, #health
  "maxHP":20,
  "DEF":10, #defense
  "maxDEF":10,
  "MANA":5,
  "maxMANA":5,
  "EVA":6,
  "ATK":8,
  "EXP":0,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "equip":[],
}

export(Dictionary) var charlie = {
  "LVL":1,
  "HP":20, #health
  "maxHP":20,
  "DEF":10, #defense
  "maxDEF":10,
  "MANA":5,
  "maxMANA":5,
  "EVA":6,
  "ATK":8,
  "EXP":0,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "equip":[],
}

#settings
#export(float) var sfxvol = 1.000
#export(float) var bgmvol = 1.000
#export(bool) var voice = true
#export(String) var lang = "en"
