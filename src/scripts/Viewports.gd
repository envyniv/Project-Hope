extends Node

onready var view = $HBoxContainer/Game/Viewport
onready var diagbox = $HBoxContainer/Game/DiagBox
onready var shopui = $HBoxContainer/Game/BuyMenu
onready var battlelayout = $HBoxContainer/Game/BattleStatLayout
onready var hpkev = $HBoxContainer/Game/BattleStatLayout/HPKevin
onready var hpquin = $HBoxContainer/Game/BattleStatLayout/HPQuinton
onready var hpcharlie = $HBoxContainer/Game/BattleStatLayout/HPCharlie
onready var hpbella = $HBoxContainer/Game/BattleStatLayout/HPBella
onready var statusmin = $HBoxContainer/Game/StatusMinimal

const stage={
	"meteora":preload("res://scenes/stage/Meteora.tscn"),
	"battle":preload("res://scenes/stage/Battle-World.tscn"),
	"map":preload("res://scenes/stage/world-map.tscn"),

	"utopia":"",
	"fantasia":"",
	"tyche":"",
	"koine":"",
	"eirene":"",
	"xenos":"",
	"oneiros":"",
	"kassandra":"",
	"basileus":"",
	"philomela":"",
	"erimos":"",
	"hypnos":"",
	"nyx":"",
}

func _ready():
	diagbox.diag_start("test")
	statusmin.get_node("Party1").hide()
	statusmin.get_node("Party2").hide()
	statusmin.get_node("Party3").hide()
	battlelayout.hide()
	if !SaveLoad.data.has("location"):
		change_stage("meteora")

func _process(_delta):
	set_status()
	if true in SaveLoad.switch_stage:
		change_stage(SaveLoad.switch_stage[true])
	if SaveLoad.inShop:
		shopui.show()

func set_status():
	if SaveLoad.tempdata.has("Kevin"):
		var kevindata=SaveLoad.tempdata["Kevin"]
		hpkev.hp.max_value=kevindata["maxHP"]
		hpkev.def.max_value=kevindata["maxDEF"]
		hpkev.hp.value=kevindata["HP"]
		hpkev.def.value=kevindata["DEF"]
		hpkev.mana.value=kevindata["MANA"]
		hpkev.mana.max_value=kevindata["maxMANA"]

		statusmin.hp.value=kevindata["HP"]
		statusmin.hp.max_value=kevindata["maxHP"]
		statusmin.def.value=kevindata["DEF"]
		statusmin.def.max_value=kevindata["maxDEF"]
	match SaveLoad.party.size():
		1:
			statusmin.get_node("Party1").show()
		2:
			statusmin.get_node("Party1").show()
			statusmin.get_node("Party2").show()
		3:
			statusmin.get_node("Party1").show()
			statusmin.get_node("Party2").show()
			statusmin.get_node("Party3").show()

#FIXME: FOR WHATEVER REASON, THE TRANSITION TRIGGERS RIGHT WHEN THE STAGE IS CREATED
#		AND IT ALSO NEVER ENDS.
#		USING A yield() WILL NOT WORK. IT WILL BREAK THE PLAYER'S MOVEMENT, SOMEHOW.
#		I'VE HAD A CHAT WITH THE FELLAS IN GODOT'S DISCORD AND THEY COULDN'T ANSWER IT;
#		BIG THANKS TO KamiGrave AND derkok FOR BEING WILLING TO HELP.
#		IT'S PROBABLY THE GREMLINS' FAULT
func change_stage(chosenstg):
	if stage.has(chosenstg)&&view.get_child_count()!=0:
#		SceneChanger.transition_start(0)
		view.get_child(0).queue_free()
		view.add_child(stage[chosenstg].instance())
		SaveLoad.switch_stage={false:null}
#		SceneChanger.transition_end()
	else:
		print("hmm... %s not found." % chosenstg)

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
	SaveLoad.inDialog=true

func _on_DiagBox_diag_ended():
	diagbox.set_process_input(false)
	if SaveLoad.inBattle==true:battlelayout.show()
	else: statusmin.show()
	SaveLoad.inDialog=false

func _on_QuitTimer_timeout():
	get_tree().quit()
