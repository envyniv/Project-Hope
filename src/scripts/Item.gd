extends Resource
class_name Item
#item<filename> will be automatically fetched instead
  #export(String) var name
#item<filename>Desc will be automatically fetched instead
  #export(String, MULTILINE) var Description
export(String) var name
export(int, 1, 99) var RequiredLevel
export(int, 0, 999999) var Price
export(int,
  "GENERIC",
  "CONSUMABLE",
  "KEY",
  "EQUIP",
  "STATUS",
  "ACCESSORY",
  "HELM"
  ) var type
var icon setget ,get_icon
export(bool) var isSold
export(Dictionary) var affect
export(String, "BATTLE", "OVERWORLD", "BOTH") var whereCanBeUsed

func get_icon() -> Resource:
  return load("res://assets/gui/item-icon/item-icon%s.png" % type)
