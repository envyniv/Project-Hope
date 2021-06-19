extends Control

onready var splitter= $MenuSmall/VBoxContainer

onready var item      = $MenuSmall/VBoxContainer/Items
onready var skill     = $MenuSmall/VBoxContainer/Skills
onready var equip     = $MenuSmall/VBoxContainer/Equip
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
  skill.connect("pressed", self, "_on_skill_pressed")
  item.connect("pressed", self, "_on_item_pressed")
  equip.connect("pressed", self, "_on_equip_pressed")
  quit.connect("pressed", self, "_on_quit_pressed")
  for i in splitter.get_child_count():
    splitter.get_child(i).text = FileMan.returnTranslation(splitter.get_child(i).text)
  whose.text = FileMan.returnTranslation(whose.text)
  onwho.text = FileMan.returnTranslation(onwho.text)
#  item.set_focus_mode(Control.FOCUS_ALL)
#  item.grab_focus()

func _on_skill_pressed():
  whose.show()
  whosesel=true
  #menusmall
  pass

func _on_item_pressed():
  menuitem.show()
  pass

func _input(_event):
  var MENU=Input.is_action_just_pressed("ui_end")
  if MENU:
    SceneManager.pEnableInput()
    show()

func _process(_delta):
  g.text = str(FileMan.money) + " G"

