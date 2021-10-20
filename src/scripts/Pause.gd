extends Control

onready var splitter= $MenuSmall/VBoxContainer

onready var item      = $MenuSmall/VBoxContainer/Items
onready var skill     = $MenuSmall/VBoxContainer/Skills
onready var quit      = $MenuSmall/VBoxContainer/Quit

onready var menusmall = $MenuSmall
onready var menumore  = $MenuMore
onready var menuitem  = $MenuItemSel

onready var whose     = $MenuMore/Whose
onready var onwho     = $MenuMore/OnWho

onready var g         = $GPanel/Label

var whosesel = false
var onwhosel = false
var itemsel = false

func _ready():
  menusmall.show()
  menuitem.hide()
  skill.connect("pressed", self, "_on_skill_pressed")
  item.connect("pressed", self, "_on_item_pressed")
  quit.connect("pressed", self, "_on_quit_pressed")
#  item.set_focus_mode(Control.FOCUS_ALL)
#  item.grab_focus()

func _on_skill_pressed():
  whose.show()
  whosesel=true
  #menusmall
  pass

func _on_item_pressed():
  menusmall.hide()
  menuitem.show()
  get_inv()
  pass

func get_inv():
  for i in FileMan.data.inv:
    menuitem.get_node("ItemList").add_item(i)

func _input(_event):
  var MENU=Input.is_action_just_pressed("ui_end")
  if MENU:
    SceneManager.pEnableInput()
    show()

func _process(_delta):
  g.text = str(FileMan.money) + " G"
