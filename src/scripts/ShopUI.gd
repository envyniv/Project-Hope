extends Control

onready var ShopPanel = $PanelShop
onready var AvailableList = $PanelShop/BuyList
onready var Money = $PanelShop/MoneyCount
onready var ItemDesc = $PanelInv/Description
onready var InvPanel = $PanelInv
onready var HaveList = $PanelInv/ItemList
onready var HaveLabel = $PanelInv/YouHave
onready var HaveNum = $PanelInv/YouHave/Num
var playermoney = SaveLoad.money
var playerlevel = SaveLoad.level
var playerinvS = SaveLoad.invS
var playerinv = SaveLoad.inv
var existingitems = ItemDatabase.items
var select
var desc

func _ready():
	# get all items and add them if the player's level is high enough
	# and if the item in question is not a key item
	for i in existingitems:
		if ItemDatabase.get_item(i.name).RequiredLevel <= playerlevel:
			if ItemDatabase.get_item(i.name).type != "KEY":
				AvailableList.add_item(i.name, guess_icon(i.type), true)
	AvailableList.select(0)
	getPlayerInv()
	ItemDesc.text=""

func _process(_delta):
	if !int(HaveNum.text):
		HaveLabel.hide()
	else:
		HaveLabel.show()
	Money.text = str(playermoney)

#when an item in the left panel is selected, show its description
func _on_BuyList_item_selected(index):
	setDesc(index)

# This funcion simply returns the right icon. Nothing to see here
func guess_icon(itemtype):
	var icons={
		"generic" : load("res://assets/item-icon/item-icon.png"),
		"status" : load("res://assets/item-icon/item-icon2.png"),
		"key" : load("res://assets/item-icon/item-icon3.png"),
		"equip" : load("res://assets/item-icon/item-icon4.png"),
		"consumable" : load("res://assets/item-icon/item-icon5.png"),
		"skill" : load("res://assets/item-icon/item-icon6.png")
	}
	if itemtype.to_lower() in icons:
		return icons[itemtype.to_lower()]

# this function returns the amount of an item in the inventory
func get_have(item):
	if item in playerinvS:
		return playerinvS[item]
	else:
		return 0

# if an item is activated, subtract value from money and add item
func _on_BuyList_item_activated(index):
	select = AvailableList.get_item_text(index)
	
	if playermoney >= ItemDatabase.get_item(select).Price && playerinv.size()+playerinvS.size()!=32:
		SaveLoad.add_item(select)
		playermoney -= ItemDatabase.get_item(select).Price
		setDesc(index)
		$money.play()
	else:
		$denied.play()
	
	getPlayerInv()

# if an item in the player's inventory gets activated, remove item and give money
func _on_ItemList_item_activated(index):
	select = HaveList.get_item_text(index)
	SaveLoad.remove_item(select)
	playermoney += ItemDatabase.get_item(select).Price*0.8
	HaveNum.text = str(get_have(select))
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
	for i in playerinvS:
		var itemType = ItemDatabase.get_item(i).type
		HaveList.add_item(i, guess_icon(itemType), true)

#set description and item amount
func setDesc(index):
	select = AvailableList.get_item_text(index)
	desc = ItemDatabase.get_item(select).Description
	ItemDesc.text = desc
	HaveNum.text = str(get_have(select))

func setDesc_Inv(index):
	select = HaveList.get_item_text(index)
	desc = ItemDatabase.get_item(select).Description
	ItemDesc.text = desc
	HaveNum.text = str(get_have(select))
