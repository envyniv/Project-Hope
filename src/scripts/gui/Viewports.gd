extends Node

onready var view         = $Game/Viewport
onready var diagbox      = $Game/DiagBox
#onready var battlelayout = $Game/BattleStatLayout
onready var cam          = $Game/Viewport/Camera2D
onready var menuitem     = $Game/MenuItemSel
onready var animplayer   = $AnimationPlayer
onready var pausemenu = $Game/Pause

var focused = false

signal itemSelected

func _ready() -> void:
  # warning-ignore:return_value_discarded
  SceneManager.connect("change_stage", self, "swap_stage")
  FileMan.curtime = OS.get_unix_time()
  SceneManager.swap_stage(FileMan.data.location)
  menuitem.connect("itemusage", self, "onItemSelected")
  menuitem.hide()

  # when selectiong items to use in the overworld
  pausemenu.connect("iNeedItems", self, "onItemRequest")
  # when selecting equipments
  pausemenu.menumember.connect("iRequireItems", self, "onItemRequest")
  return

func swap_stage(level : PackedScene) -> void:
  for child in view.get_children():
    if !(child is Camera2D):
      child.queue_free()
  view.add_child(level.instance())
  return

func onItemRequest(filter="") -> void:
  menuitem.updPlayerInv(filter)
  menuitem.show()
  return

func onItemSelected(itemFilename : Resource) -> void:
  connect("itemSelected", pausemenu.menumember, "itemReceived")
  var type = itemFilename.type
  emit_signal("itemSelected", type, itemFilename.name)
  menuitem.show()
  disconnect("itemSelected", pausemenu.menumember, "itemReceived")
  return

func _input(_event) -> void:
  var MENU = Input.is_action_pressed("ui_end")
  var BACK = Input.is_action_pressed("ui_cancel")
  if MENU && !focused:
    focused = pausemenu.menusmall
    pausemenu.show()
    # TODO: replace with anim
    SceneManager.pDisableInput()
    focused.show()
    pausemenu.item.grab_focus()
    #set_process_input(false)
  if BACK:
    match focused:
      pausemenu.menusmall:
        # TODO: replace with anim
        pausemenu.hide()
        SceneManager.pEnableInput()
    #$MenuSmall/VBoxContainer/Items.grab_focus()
  return
