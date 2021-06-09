extends Node

onready var view         = $Game/Viewport
onready var diagbox      = $Game/DiagBox
onready var shopui       = $Game/BuyMenu
onready var battlelayout = $Game/BattleStatLayout
onready var cam          = $Game/Viewport/Camera2D

func _ready():
  battlelayout.hide()
  SceneManager.connect("fighting", self, "show_battle_gui")
  SceneManager.connect("fighting_over", self, "hide_battle_gui")
  #SceneManager.connect("fighting", self, "show_battle_gui")
  #SceneManager.connect("fighting_over", self, "hide_battle_gui")
  #diagbox.diag_start("test")

func set_cam_limit():
  var map_limits = view.world.get_used_rect()
  var map_cellsize = view.world.cell_size
  cam.limit_left = map_limits.position.x * map_cellsize.x
  cam.limit_right = map_limits.end.x * map_cellsize.x
  cam.limit_top = map_limits.position.y * map_cellsize.y
  cam.limit_bottom = map_limits.end.y * map_cellsize.y

func show_battle_gui():
  battlelayout.show()

func hide_battle_gui():
  battlelayout.hide()

func _input(_event):
    var MENU=Input.is_action_just_pressed("ui_end")
    if MENU:
        $Game/Control.show()
