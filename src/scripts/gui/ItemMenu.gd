extends NinePatchRect

onready var HaveList = $HBox/ItemList
onready var desc = $Desc
var playerinv = FileMan.data.inv

signal itemusage

func _ready():
  HaveList.connect("item_selected", self, "updItemDesc")
  HaveList.connect("item_activated", self, "onItemUse")
  updPlayerInv()
  return

func updPlayerInv(filter := "") -> void:
  HaveList.clear() #nuclearize
  for i in playerinv:     #fill the list
    var itemType = ItemDatabase.get_item(i).type
    var translatedName=TranslationServer.translate(i)
    
    if filter in itemType:
      print("Type: "+itemType+"\nFilter:"+filter)
      if playerinv[i]>1:
        HaveList.add_item(str(translatedName, " ×", playerinv[i]), ItemDatabase.guess_icon(itemType), true)
      else:
        HaveList.add_item(str(translatedName), ItemDatabase.guess_icon(itemType), true)
  return

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
