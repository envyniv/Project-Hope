extends NinePatchRect

export(NodePath) var itemList
export(NodePath) var desc
enum mode {SELL, USE}
export(mode) var listMode

var invRef = null #what inventory to reference

signal itemusage

#var itemqualities = []

func _ready():
  desc = get_node(desc)
  itemList = get_node(itemList)
  itemList.connect("item_selected", self, "updItemDesc")
  itemList.connect("item_activated", self, "onItemUse")
  return

func updInv(invRef: Dictionary, filter := "", setMode="") -> void:
  listMode=mode.get(setMode)
  itemList.clear() #nuclearize
  var itemicon
  var text = ""
  for i in invRef:     #fill the list
    if filter in i.type:
      itemicon = i.get_icon()
      if invRef[i] > 1:
        text = str(i.get_name(), " ×", invRef[i])
      else:
        if listMode == mode.SELL:
          text = str(i.get_name(), "\t", i.price) #shops don't have limited stock
        else:
          text = str(i.get_name())
      

      itemList.add_item(text, itemicon)
  return

func onItemUse(idx) -> void:
  if (invRef[idx] > 1):
    itemList.set_item_text(str(invRef[idx].get_name(), " ×", invRef[idx]))
  else:
    itemList.remove_item(idx)
  emit_signal("itemusage")
  return

func updItemDesc(idx) -> void:
  # TODO:
  desc.get_parent().show()
  desc.set_text(invRef[idx].get_desc())
  return


"""
 func onItemUse(idx) -> void:
   var temp                = HaveList.get_item_text(idx)
   var itemfromtranslation = ItemDatabase.get_translation_item(temp)
   emit_signal('itemusage', itemfromtranslation)
   desc.hide()
   return

 func updItemDesc(idx) -> void:
   desc.show()
  var select = HaveList.get_item_text(idx)
   if " ×" in select :
     select.erase(  select.find(" ×"), ( select.length() - select.find(" ×") )  )
   desc.get_node('Label').text= ItemDatabase.get_translation_item(select).Description
   return

func _input(_event) -> void:
  if Input.is_action_just_pressed("ui_cancel"):
    emit_signal("exit_menumore")
    release_focus()
  return
"""