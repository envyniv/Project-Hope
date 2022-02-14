extends Resource
# THE DATA CONTAINED HERE REPLACES FileMan.default_data
class_name Save
#TODO
export(Array) var mods = []

#game
export(String) var name
export(int, 0, 13) var hm # supposed to be a "secrets" value, kinda like WTF or FUN; doubt i'll use it, but if i do, here it is.
export(Array) var party = ["kevin"]
export(Dictionary) var inv = {}
export(String) var location = "kevinsbedroom"
export(int) var playtime = 0
export(int, 0, 999999999) var money = 100 #to quote medic from tf2: "Ooh, Money!"
export(int, 0, 99) var level = 1 #global level, should be average of party members #TODO

export(PoolByteArray) var preview

export(Vector2) var position
export(Vector2) var facing #FIXME: maybe wrong export type

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
  "nextEXP":10, # 10 to 10098
  "PRO":0, #mana regen boost
  "CHR":0, #charm
  "LUC":0, #luck/chance of crit hit
  "god":[],
  "equip":{ "HELM":null, "EQUIP":null, "ACCESSORY":null },
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
  "nextEXP":10,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "god":[],
  "equip":{ "HELM":"", "EQUIP":"", "ACCESSORY":"" },
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
  "nextEXP":10,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "god":[],
  "equip":{ "HELM":"", "EQUIP":"", "ACCESSORY":"" },
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
  "nextEXP":10,
  "PRO":0,
  "CHR":0,
  "LUC":0,
  "god":[],
  "equip":{ "HELM":"", "EQUIP":"", "ACCESSORY":"" },
}
