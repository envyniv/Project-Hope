extends Node

onready var view         = $Game/Viewport
onready var diagbox      = $Game/DiagBox
onready var shopui       = $Game/BuyMenu
onready var battlelayout = $Game/BattleStatLayout
#onready var cam          = $Game/Viewport/Camera2D

func _ready():
  #if !SceneChanger.secret==null:
  #  var stage=load(SceneChanger.secret)
  #  view.instance(stage)
  diagbox.diag_start("test")
  battlelayout.hide()
  #var player = $Game/Viewport/Stage/YSort/Player
  #cam.target = player
  #set_cam_limit()

#func set_cam_limit():
  #var map_limits = view.world.get_used_rect()
  #var map_cellsize = view.world.cell_size
  #cam.limit_left = map_limits.position.x * map_cellsize.x
  #cam.limit_right = map_limits.end.x * map_cellsize.x
  #cam.limit_top = map_limits.position.y * map_cellsize.y
  #cam.limit_bottom = map_limits.end.y * map_cellsize.y

func _process(_delta):
#	if true in SaveLoad.switch_stage:
#		change_stage(SaveLoad.switch_stage[true])
    if SaveLoad.inShop:
        shopui.show()

#FIXME: FOR WHATEVER REASON, THE TRANSITION TRIGGERS RIGHT WHEN THE STAGE IS CREATED
#		AND IT ALSO NEVER ENDS.
#		USING A yield() WILL NOT WORK. IT WILL BREAK THE PLAYER'S MOVEMENT, SOMEHOW.
#		I'VE HAD A CHAT WITH THE FELLAS IN GODOT'S DISCORD AND THEY COULDN'T ANSWER IT;
#		BIG THANKS TO KamiGrave AND derkok FOR BEING WILLING TO HELP.
#		IT'S PROBABLY THE GREMLINS' FAULT
#func change_stage(chosenstg):
#    if stage.has(chosenstg)&&view.get_child_count()!=0:
#		SceneChanger.transition_start(0)
#        view.get_child(0).queue_free()
#        view.add_child(stage[chosenstg].instance())
#        SaveLoad.switch_stage={false:null}
#		SceneChanger.transition_end()
#	else:
#		print("hmm... %s not found." % chosenstg)

func _input(_event):
    var MENU=Input.is_action_just_pressed("ui_end")
    if MENU:
        $Game/Control.show()

func _on_DiagBox_diag_started():
    battlelayout.hide()
    SaveLoad.inDialog=true

func _on_DiagBox_diag_ended():
    if true in SaveLoad.inBattle:battlelayout.show()
    SaveLoad.inDialog=false

func _on_QuitTimer_timeout():
    get_tree().quit()
