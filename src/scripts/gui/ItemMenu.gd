extends NinePatchRect

onready var HaveList = $HBox/ItemList
onready var desc     = $Desc
var playerinv        = FileMan.data.inv

signal itemusage

func _ready():
  HaveList.connect("item_selected", self, "updItemDesc")
  HaveList.connect("item_activated", self, "onItemUse")
  updPlayerInv()
  return

func updPlayerInv(filter := "") -> void:
  HaveList.clear() #nuclearize
  for i in playerinv:     #fill the list
    if filter in i.type:
      if playerinv[i] > 1:
        HaveList.add_icon_item(i.get_icon(),str(i.name, " ×", playerinv[i]), i.icon, true)

      else:
        HaveList.add_icon_item(i.get_icon(),str(i.name), i.icon, true)
  return

func onItemUse(_idx) -> void:
  #TODO:
  return

func updItemDesc(_idx) -> void:
  #TODO:
  return
"""
 func onItemUse(idx) -> void:
   var temp                = HaveList.get_item_text(idx)
   var itemfromtranslation = ItemDatabase.get_translation_item(temp)
   emit_signal("itemusage", itemfromtranslation)
   desc.hide()
   return

 func updItemDesc(idx) -> void:
   desc.show()
  var select = HaveList.get_item_text(idx)
   if " ×" in select :
     select.erase(  select.find(" ×"), ( select.length() - select.find(" ×") )  )
   desc.get_node("Label").text= ItemDatabase.get_translation_item(select).Description
   return
"""

func _input():
  if Input.is_action_just_pressed("ui_cancel"):
    emit_signal("exit_menumore")
    release_focus()
  return
