extends Node

onready var view         = $Game/Viewport
onready var diagbox      = $Game/DiagBox
#onready var battlelayout = $Game/BattleStatLayout
onready var cam          = $Game/Viewport/Camera2D
onready var menuitem     = $Game/MenuItemSel
onready var menumember   = $Game/Pause/MenuMember
onready var animplayer   = $AnimationPlayer
onready var pausemenu = $Game/Pause

signal itemSelected

func _ready() -> void:
# warning-ignore:return_value_discarded
  SceneManager.connect("plsChangeLeveliBegYou", self, "change_level")
  FileMan.curtime = OS.get_unix_time()
  SceneManager.change_level_relay(FileMan.data.location)
  SceneManager.start_convo("test")
  menumember.connect("iRequireItems", self, "onItemRequest")
  menuitem.connect("itemusage", self, "onItemSelected")
  menuitem.hide()
  pausemenu.connect("iNeedItems", self, "onItemRequest")
  return

func change_level(level) -> void: # use SceneManager.change_level_relay(levelrelay)
  if view.get_children().size() == 2:
    var current_stage = view.get_child(1)
    current_stage.queue_free()
  view.add_child(load(level).instance())
  return

func onItemRequest(filter="") -> void:
  menuitem.updPlayerInv(filter)
  animplayer.play("menuitem_open")
  return

func onItemSelected(itemFilename : Resource) -> void:
  var type = itemFilename.type
  emit_signal("itemSelected", type, itemFilename.name)
  animplayer.play_backwards("menuitem_open")
  return