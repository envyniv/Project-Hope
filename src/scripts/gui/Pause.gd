extends Control

onready var menusmall = $MenuSmall
onready var menumore  = $MenuMore
onready var menumember = $MenuMember

onready var splitter = $MenuSmall/VBoxContainer

onready var item      = splitter.get_node("Items")
onready var skill     = splitter.get_node("Skills")
onready var quit      = splitter.get_node("Quit")
onready var party     = splitter.get_node("Party")

signal iNeedItems

func _ready() -> void:
  menusmall.hide()
  menumore.hide()
  menumember.hide()

  menumore.set_process_input(false)
  menumember.set_process_input(false)

  skill.connect("pressed", self, "_on_skill_pressed")
  item.connect("pressed", self, "_on_item_pressed")
  quit.connect("pressed", self, "_on_quit_pressed")
  party.connect("pressed", self, "_on_party_pressed")
  menumore.connect("exit_menumore", self, "onMenumoreExit")
  menumember.connect("exit_menumember", self, "onMenuMemberExit")
  return

func _on_party_pressed() -> void:
  # TODO: replace with anim
  set_process_input(false)
  get_tree().call_group("menusmall_buttons", "set_focus_mode", 0)
  menumore.show()
  menumore.set_process_input(true)
  for i in menumore.vbox.get_children():
    if !i.is_connected("partymember_selected", self, "memberInfoMenu"):
      i.connect("partymember_selected", self, "memberInfoMenu")
  menumore.vbox.get_child(0).button.grab_focus()
  return

func memberInfoMenu(pointing) -> void:
  # TODO: replace with anim
  #menumore.hide()
  menumember.show()
  get_tree().call_group("menumore_buttons", "set_focus_mode", 2)
  menumember.grab_focus()
  menumore.set_process_input(false)
  menumember.set_process_input(true)
  menumember.pointing = pointing
  return

func _on_skill_pressed() -> void:
  #whose?
  # TODO: replace with anim
  menumore.show()

  for i in menumore.get_node("VBoxContainer").get_child_count():
    menumore.get_node("VBoxContainer").get_child(i).connect("partymember_selected", self, "memberSkillMenu")
  #what to use?
  #animplay.play("menuskill_open")
  #on who?
  return

func memberSkillMenu(whose: Resource) -> void:
  # TODO: replace with anim
  #menuskill.show()
  menumore.set_process_input(false)
  #menuskill.pointing = whose
  return

func _on_item_pressed() -> void:
  emit_signal("iNeedItems")
  return



func onMenumoreExit() -> void:
  # TODO: replace with anim
  get_tree().call_group("menusmall_buttons", "set_focus_mode", 2)
  menumore.hide()
  party.set_focus_mode(2)
  party.grab_focus()
  set_process_input(true)
  #grab_focus()
  return

func onMenuMemberExit() -> void:
  # TODO: replace with anim
  menumember.hide()
  menumember.set_process_input(false)
  menumore.set_process_input(true)
  get_tree().call_group("menumore_buttons", "set_focus_mode", 0)
  menumore.vbox.get_child(0).button.grab_focus()
  #grab_focus()
  return

"""
func onItemRequest(_filter:String) -> void:
  # _filter is there to avoid error dumping
  # this just connects viewport to menumember

# warning-ignore:return_value_discarded
  #viewport.connect("itemSelected", menumember, "itemReceived")
  return
"""

func _on_quit_pressed() -> void:
  get_tree().quit()
  return
