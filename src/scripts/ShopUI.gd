extends Control

onready var ShopPanel = $PanelShop
onready var AvailableList = $PanelShop/BuyList
onready var Money = $MoneyCount
onready var ItemDesc = $Description
onready var InvPanel = $PanelInv
onready var HaveList = $PanelInv/ItemList
onready var selllabel = $PanelInv/Sell
onready var buylabel = $PanelShop/Buy
var playermoney = FileMan.money
var playerlevel = FileMan.level
var playerinv = FileMan.data.inv
var existingitems = ItemDatabase.items
var select
var desc

func _ready():
  # warning-ignore:return_value_discarded
  SceneManager.connect("vending", self, "show")
  # warning-ignore:return_value_discarded
  SceneManager.connect("vending", self, "enable_input")
  # warning-ignore:return_value_discarded
  SceneManager.connect("left_vending", self, "disable_input")
    # get all items and add them if the player's level is high enough
    # and if the item in question is not a key item
  for i in existingitems:
    if ItemDatabase.get_item(i.name).RequiredLevel <= playerlevel:
      if ItemDatabase.get_item(i.name).type != "KEY":
        AvailableList.add_item(i.name, guess_icon(i.type), true)
  AvailableList.select(0)
  getPlayerInv()
  ItemDesc.text=""
  update_money()

func enable_input():
  set_process_input(true)
  return

func disable_input():
  set_process_input(false)
  return

func update_money():
  Money.text = str(playermoney)+" G"
  return

#when an item in the left panel is selected, show its description
func _on_BuyList_item_selected(index):
  setDesc(index)
  return

# This funcion simply returns the right icon. Nothing to see here
func guess_icon(itemtype):
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

# if an item is activated, subtract value from money and add item
func _on_BuyList_item_activated(index):
    select = AvailableList.get_item_text(index)

    if playermoney >= ItemDatabase.get_item(select).Price && playerinv.size()!=255:
        FileMan.add_item(select)
        playermoney -= ItemDatabase.get_item(select).Price
        setDesc(index)
        $money.play()
    else:
        $denied.play()

    getPlayerInv()
    update_money()

# if an item in the player's inventory gets activated, remove item and give money
func _on_ItemList_item_activated(index):
    select = HaveList.get_item_text(index)
    FileMan.remove_item(select)
    playermoney += ItemDatabase.get_item(select).Price*0.8
    $money.play()
    getPlayerInv()

func _on_ItemList_item_selected(index):
    setDesc_Inv(index)

func getPlayerInv():
    HaveList.clear()
    for i in playerinv:
        var itemType = ItemDatabase.get_item(i).type
        if itemType != "KEY":
            HaveList.add_item(i, guess_icon(itemType), true)

#set description and item amount
func setDesc(index):
    select = AvailableList.get_item_text(index)
    desc = ItemDatabase.get_item(select).Description
    ItemDesc.text = desc

func setDesc_Inv(index):
    select = HaveList.get_item_text(index)
    desc = ItemDatabase.get_item(select).Description
    ItemDesc.text = desc

func _input(_event):
  if Input.is_action_pressed("ui_cancel"):
    hide()
    SceneManager.vending_left()
    #FileMan.inShop=false
