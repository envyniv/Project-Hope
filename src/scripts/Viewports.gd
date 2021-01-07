extends Node

onready var world = $HBoxContainer/Game/Viewport/World
onready var stage = $HBoxContainer/Game/Viewport/World/Stage/YSort
onready var camera = $HBoxContainer/Game/Viewport/Camera2D
onready var diagbox = $HBoxContainer/Game/DiagBox
onready var player = $HBoxContainer/Game/Viewport/World/YSort/Player
onready var audioplay=$AudioPlayer
onready var battlelayout=$"HBoxContainer/Game/Battle-Stat-Layout"
onready var hpkev=$"HBoxContainer/Game/Battle-Stat-Layout/HP-Kevin/"
onready var hpquin=$"HBoxContainer/Game/Battle-Stat-Layout/HP-Quinton"
onready var hpcharlie=$"HBoxContainer/Game/Battle-Stat-Layout/HP-Charlie"
onready var hpbella=$"HBoxContainer/Game/Battle-Stat-Layout/HP-Bella"
onready var statusmin=$HBoxContainer/Game/StatusMinimal

func _ready():
	camera.target = player
	#get how many photobooths there are and assign an id to all of them
	diagbox.diag_start("test")
	statusmin.get_node("Party1").hide()
	statusmin.get_node("Party2").hide()
	statusmin.get_node("Party3").hide()
	battlelayout.hide()
	pass
	
func _process(_delta):
	hpkev.hp.max_value=player.stats.maxHP
	hpkev.def.max_value=player.stats.maxDEF
	hpkev.hp.value=player.stats.HP
	hpkev.def.value=player.stats.DEF
	hpkev.mana.value=player.stats.MANA
	hpkev.mana.max_value=player.stats.maxMANA
	
	statusmin.hp.value=player.stats.HP
	statusmin.hp.max_value=player.stats.maxHP
	statusmin.def.value=player.stats.DEF
	statusmin.def.max_value=player.stats.maxDEF
	match player.party.size():
		1:
			statusmin.get_node("Party1").show()
		2:
			statusmin.get_node("Party1").show()
			statusmin.get_node("Party2").show()
		3:
			statusmin.get_node("Party1").show()
			statusmin.get_node("Party2").show()
			statusmin.get_node("Party3").show()


func _input(_event):
	var QUIT=Input.is_action_pressed("ui_end")
	var quit_wait=$QuitTimer
	if QUIT:
		$QuitLabel.show()
		quit_wait.start()
		
	else: 
		$QuitLabel.hide()
		quit_wait.stop()

func _on_DiagBox_diag_started():
	diagbox.set_process_input(true)
	battlelayout.hide()
	statusmin.hide()
	player.set_process_unhandled_input(false)
func _on_DiagBox_diag_ended():
	diagbox.set_process_input(false)
	player.set_process_unhandled_input(true)
	if player.battle_mode==true:battlelayout.show()
	else: statusmin.show()

func _on_QuitTimer_timeout():
	audioplay.set_stream("res://assets/OST/fx/byebye.wav")
	audioplay.play()
	yield(audioplay.play(),"finished")
	get_tree().quit()
	pass # Replace with function body.
