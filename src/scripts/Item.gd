extends Resource
class_name Item
export(String) var name
export(String, MULTILINE) var Description
export(int,1,99) var RequiredLevel
export(int,0,999999) var Price
export(String, "GENERIC","CONSUMABLE","KEY","EQUIP","STATUS","ACCESSORY","HELM") var type
export(bool) var isSold
export(Dictionary) var affect
export(String, "BATTLE", "OVERWORLD", "BOTH") var whereCanBeUsed
