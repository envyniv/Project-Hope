extends Node

var items=[]

func _ready() -> void:
  var directory=Directory.new()
  directory.open("res://scripts/items/")
  directory.list_dir_begin()
  var filename=directory.get_next()
  while(filename):
    if !directory.current_is_dir():
      items.append(load("res://scripts/items/%s" % filename))
    filename=directory.get_next()
  print(items)
  return

func get_item(item : String) -> Resource:
  for i in items:
    if i.name == item:
      return i
  return null
  
func get_translation_item(item : String) -> Resource:
  for i in items:
    if item == TranslationServer.translate(i.name):
      return i
  return null
  
func guess_icon(itemtype : String) -> Resource:
  var icons={
    "generic"    : load("res://assets/item-icon/item-icon.png"),
    "status"     : load("res://assets/item-icon/item-icon2.png"),
    "helm"       : load("res://assets/item-icon/item-icon3.png"),
    "equip"      : load("res://assets/item-icon/item-icon4.png"),
    "consumable" : load("res://assets/item-icon/item-icon5.png"),
    "skill"      : load("res://assets/item-icon/item-icon6.png"),
    "key"        : load("res://assets/item-icon/item-icon7.png"),
    "accessory"  : load("res://assets/item-icon/item-icon8.png")
  }
  if itemtype.to_lower() in icons:
    return icons[itemtype.to_lower()]  
  print("ERROR IN ItemDatabase.gd:guess_icon()\nWASN'T ABLE TO MATCH ITEMTYPE")
  return null #usually unreachable
