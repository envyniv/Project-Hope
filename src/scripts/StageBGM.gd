extends Node

onready var anims=$AnimationPlayer
onready var player=$AudioStreamPlayer
const BGM = {
	"battle1" : [preload("res://OST/BGM/bits.ogg"), "Battle To Bits"],
	"battle2" : [preload("res://OST/BGM/crazy.ogg"), "About To Get Crazy"],
	"battle3" : [preload("res://OST/BGM/enemy.ogg"), "From The Enemy"],
	"battle4" : [preload("res://OST/BGM/hand.ogg"), "What Has It Come To?"],
	"battle5" : [preload("res://OST/BGM/orchestra.ogg"), "Orchestrating A Fight"],
	"battle6" : [preload("res://OST/BGM/sounds.ogg"), "Sounds Of Battle"],
	"think" : [preload("res://OST/BGM/think.ogg"), "Think, Quick!"],
	"save" : [preload("res://OST/BGM/save.ogg"), "Time To Save"],
	"winter" : [preload("res://OST/BGM/winter.ogg"), "New World"],
	"sweet" : [preload("res://OST/BGM/sweet.ogg"), "Sweet Melody"],
	"start" : [preload("res://OST/BGM/start.ogg"), "Start of a Story"],
	"night" : [preload("res://OST/BGM/night.ogg"), "Prima Luna"],
	"casino" : [preload("res://OST/BGM/casino.ogg"), "Lively Night"],
	"fantasia" : [preload("res://OST/BGM/fantasia.ogg"), "The Rumors Of Fantasia"],
	"wild" : [preload("res://OST/BGM/wild.ogg"), "Lost in the wild"],
	"luck" : [preload("res://OST/BGM/luck.ogg"), "Lucky to see you"],
	"east" : [preload("res://OST/BGM/east.ogg"), "Time to see the East"],
}
func _ready():
	if SaveLoad.data["settings"].has("bgmvol"):
		player.volume_db=linear2db(float(SaveLoad.data["settings"]["bgmvol"]))
		pass
	player.stream = BGM["battle1"][0]
#	stage.text = stagename
#	anims.play("fade-in")
	player.play()
	pass
