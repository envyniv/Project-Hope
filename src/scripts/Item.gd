extends Resource
class_name Item
export(String) var name
export(String, MULTILINE) var Description
export(int,1,99) var RequiredLevel
export(int,0,999999) var Price
export(bool) var Stackable=false
export(int,1,99) var maxStack=1
export(String, "GENERIC","CONSUMABLE","KEY","EQUIP","STATUS") var type
export(Dictionary) var affect
