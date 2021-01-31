extends Node
class_name StageBGM, "res://scenes/icons/sound.png"
onready var anims=$AnimationPlayer
onready var player=$AudioStreamPlayer
#const BGM = {
#	"battle1" : [preload("res://assets/OST/BGM/bits.ogg"), "Battle To Bits"],
#	"battle2" : [preload("res://assets/OST/BGM/crazy.ogg"), "About To Get Crazy"],
#	"battle3" : [preload("res://assets/OST/BGM/enemy.ogg"), "From The Enemy"],
#	"battle4" : [preload("res://assets/OST/BGM/hand.ogg"), "What Has It Come To?"],
#	"battle5" : [preload("res://assets/OST/BGM/orchestra.ogg"), "Orchestrating A Fight"],
#	"battle6" : [preload("res://assets/OST/BGM/sounds.ogg"), "Sounds Of Battle"],
#	"think" : [preload("res://assets/OST/NGM/think.ogg"), "Think, Quick!"],
#	"save" : [preload("res://assets/OST/BGM/save.ogg"), "Time To Save"],
#	"winter" : [preload("res://assets/OST/BGM/winter.ogg"), "New World"],
#	"sweet" : [preload("res://assets/OST/BGM/sweet.ogg"), "Sweet Melody"],
#	"start" : [preload("res://assets/OST/BGM/start.ogg"), "Start of a Story"],
#	"night" : [preload("res://assets/OST/BGM/night.ogg"), "Prima Luna"],
#	"casino" : [preload("res://assets/OST/BGM/casino.ogg"), "Lively Night"],
#	"fantasia" : [preload("res://assets/OST/BGM/fantasia.ogg"), "The Rumors Of Fantasia"],
#	"wild" : [preload("res://assets/OST/BGM/casino.ogg"), "Lost in the wild"],
#	"luck" : [preload("res://assets/OST/BGM/casino.ogg"), "Lucky to see you"],
#	"east" : [preload("res://assets/OST/BGM/casino.ogg"), "Time to see the East"],
#}
#onready var stage=$Stage
#onready var stagename=get_node("../Viewport/World/Stage/StageName").text
func _ready():
	if SaveLoad.data["settings"].has("bgmvol"):
		player.volume_db=linear2db(float(SaveLoad.data["settings"]["bgmvol"]))
		pass
	else:
		#volume 100%
		pass
#	player.stream = battle1
#	stage.text = stagename
#	anims.play("fade-in")
#	player.play()
	pass
