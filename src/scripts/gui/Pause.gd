extends Control

onready var splitter= $MenuSmall/VBoxContainer

onready var item      = $MenuSmall/VBoxContainer/Items
onready var skill     = $MenuSmall/VBoxContainer/Skills
onready var quit      = $MenuSmall/VBoxContainer/Quit
onready var party     = $MenuSmall/VBoxContainer/Party

onready var menusmall = $MenuSmall
onready var menumore  = $MenuMore
onready var menumember = $MenuMember
#onready var menuskill = $MenuSkill

onready var viewport = get_node("../..")

onready var animplay  = $AnimationPlayer

var vis = false

signal iNeedItems

func _ready() -> void:
  menusmall.hide()
  menumore.hide()
  menumember.hide()
  skill.connect("pressed", self, "_on_skill_pressed")
  item.connect("pressed", self, "_on_item_pressed")
  quit.connect("pressed", self, "_on_quit_pressed")
  party.connect("pressed", self, "_on_party_pressed")
  menumore.connect("exit_menumore", self, "onMenumoreExit")
  menumember.connect("exit_menumember", self, "onMenuMemberExit")
  
  menumember.connect("iRequireItems",self,"onItemRequest") # connects viewports receiving items to menumember
  hide()
#  item.set_focus_mode(Control.FOCUS_ALL)
#  item.grab_focus()
  return

func _on_party_pressed() -> void:
  menusmall.release_focus()
  animplay.play("menumore_open")
  for i in menumore.get_node("VBoxContainer").get_child_count():
    menumore.get_node("VBoxContainer").get_child(i).connect("partymember_selected", self, "memberInfoMenu")
  return

func memberInfoMenu(whose) -> void:
  animplay.play("menumember_open")
  menumore.set_process_input(false)
  menumember.who=whose
  return

func _on_skill_pressed() -> void:
  #whose?
  animplay.play("menumore_open")
  for i in menumore.get_node("VBoxContainer").get_child_count():
    menumore.get_node("VBoxContainer").get_child(i).connect("partymember_selected", self, "memberSkillMenu")
  #what?
  #animplay.play("menuskill_open")
  #on who?
  return

func memberSkillMenu(whose) -> void:
  #TODO:
  animplay.play("menuskill_open")
  menumore.set_process_input(false)
 # menuskill.who=whose
  return

func _on_item_pressed() -> void:
  emit_signal("iNeedItems")
  #emit_signal(item)
  #menumore.grab_focus()
  #menuitem.show()
  return

func _input(_event) -> void:
  var MENU = Input.is_action_pressed("ui_end")
  if MENU:
    if vis==true:
      hide()
      animplay.play_backwards("menusmall_open")
      SceneManager.pEnableInput()
      $MenuSmall/VBoxContainer/Items.grab_focus()
      vis=false
    else:
      show()
      animplay.play("menusmall_open")
      SceneManager.pDisableInput()
      vis=true
  return

func onMenumoreExit() -> void:
  animplay.play_backwards("menumore_open")
  #grab_focus()
  return
  
func onMenuMemberExit() -> void:
  animplay.play_backwards("menumember_open")
  menumember.release_focus()
  menumember.set_process_input(false)
  menumore.set_process_input(true)
  #grab_focus()
  return

func onItemRequest(_filter:String) -> void:
  # _filter is there to avoid error dumping
  # this just connects viewport to menumember
  
# warning-ignore:return_value_discarded
  viewport.connect("itemSelected", menumember, "itemReceived")
  return
