extends Control
onready var AvailableList = $HBoxContainer/VBoxContainer/BuyList

onready var ItemDesc = $Description
onready var HaveList = $HBoxContainer/VBoxContainer2/ItemList
onready var selllabel = $HBoxContainer/VBoxContainer2/Sell
onready var buylabel = $HBoxContainer/VBoxContainer/Buy

var playermoney = FileMan.data.money
var playerlevel = FileMan.data.level
var playerinv = FileMan.data.inv
var existingitems = ItemDatabase.items
var select

func _ready():
  # warning-ignore:return_value_discarded
  SceneManager.connect("vending", self, "showStuff")
  # warning-ignore:return_value_discarded
  SceneManager.connect("left_vending", self, "hideStuff")

  for i in existingitems:
    if ItemDatabase.get_item(i.name).RequiredLevel <= playerlevel: #if the player is at a high enough level
      if ItemDatabase.get_item(i.name).isSold:                     #if the item can be sold
        AvailableList.add_item(TranslationServer.translate(i.name), ItemDatabase.guess_icon(i.type), true) #show it
  AvailableList.select(0)
  updPlayerInv()
  ItemDesc.text=""

func showStuff():
  show()
  set_process_input(true)
  if HaveList.get_item_count()>0:
    HaveList.select(0, true)
  #AvailableList.grab_focus()
  return

func hideStuff():
  set_process_input(false)
  hide()
  return

#when an item in the left panel is selected, show its description
func _on_BuyList_item_selected(index) -> void:
  setDesc(index)
  return

# if an item is activated, subtract value from money and add item
func _on_BuyList_item_activated(index) -> void:
    select = AvailableList.get_item_text(index)

    if playermoney >= ItemDatabase.get_translation_item(select).Price:
        if FileMan.add_item(ItemDatabase.get_translation_item(select).name):
          playermoney -= ItemDatabase.get_translation_item(select).Price
          setDesc(index)
          $money.play()
    else:
      $denied.play()
    updPlayerInv()
    return

# if an item in the player's inventory gets activated, remove item and give 80% the price
func _on_ItemList_item_activated(index) -> void:
  var wasSelected = 0
  select = HaveList.get_item_text(index)
  if " ×" in select :
    select.erase(  select.find(" ×"), ( select.length() - select.find(" ×") )  )
  FileMan.remove_item(ItemDatabase.get_translation_item(select).name)
  playermoney += ItemDatabase.get_translation_item(select).Price*0.8
  $money.play()
  for i in HaveList.get_item_count():
    if select in HaveList.get_item_text(i):
      wasSelected = i
  updPlayerInv()
  HaveList.select(wasSelected, true)
  return

func _on_ItemList_item_selected(index) -> void:
  setDesc(index, true)
  return

func updPlayerInv() -> void:
  HaveList.clear() #nuclearize
  for i in playerinv:     #fill the list
    var itemType = ItemDatabase.get_item(i).type
    if itemType != "KEY":
      var translatedName=TranslationServer.translate(i)
      if playerinv[i]>1:
        HaveList.add_item(str(translatedName, " ×", playerinv[i]), ItemDatabase.guess_icon(itemType), true)
      else:
        HaveList.add_item(str(translatedName), ItemDatabase.guess_icon(itemType), true)
  return

#set description and item amount
func setDesc(index, inv=false) -> void:
  var desc
  if inv:       #if we need a description of an item from the inventory
    select = HaveList.get_item_text(index)
  else:
    select = AvailableList.get_item_text(index)
  if " ×" in select :
    select.erase(  select.find(" ×"), ( select.length() - select.find(" ×") )  )
  desc = ItemDatabase.get_translation_item(select).Description
  ItemDesc.text = desc
  return

func _input(_event) -> void:
  if Input.is_action_pressed("ui_cancel"):
    SceneManager.vending_left()
  return
