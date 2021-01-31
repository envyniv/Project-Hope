extends Control

onready var ShopPanel=$PanelShop
onready var AvailableList=$PanelShop/BuyList
onready var GNum=$PanelShop/MoneyCount
onready var ItemDesc=$PanelInv/Description
onready var InvPanel=$PanelInv
onready var HaveList=$PanelInv/ItemList
onready var HaveNum=$PanelInv/YouHave/Num

func _ready():
	
	pass

func _process(_delta):
	GNum.text=SaveLoad.money


func _on_BuyList_item_selected(index):
	ItemDesc.text=index
	pass
