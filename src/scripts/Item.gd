extends Resource
class_name Item
export(String) var name
export(bool) var Stackable=false
export(int,1,99) var maxStack=1
enum ItemType {GENERIC,CONSUMABLE,KEY,EQUIP}
export(ItemType) var type
export(Dictionary) var affect
export(String, MULTILINE) var Description
