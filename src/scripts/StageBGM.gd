extends Node

onready var anims=$AnimationPlayer
onready var player=$AudioStreamPlayer
const BGM = {
	"battle1" : [preload("res://sounds/music/bits.ogg"), "Battle To Bits"],
	"battle2" : [preload("res://sounds/music/crazy.ogg"), "About To Get Crazy"],
	"battle3" : [preload("res://sounds/music/enemy.ogg"), "From The Enemy"],
	"battle4" : [preload("res://sounds/music/hand.ogg"), "What Has It Come To?"],
	"battle5" : [preload("res://sounds/music/orchestra.ogg"), "Orchestrating A Fight"],
	"battle6" : [preload("res://sounds/music/sounds.ogg"), "Sounds Of Battle"],
	"think" : [preload("res://sounds/music/think.ogg"), "Think, Quick!"],
	"save" : [preload("res://sounds/music/save.ogg"), "Time To Save"],
	"winter" : [preload("res://sounds/music/winter.ogg"), "New World"],
	"sweet" : [preload("res://sounds/music/sweet.ogg"), "Sweet Melody"],
	"start" : [preload("res://sounds/music/start.ogg"), "Start of a Story"],
	"night" : [preload("res://sounds/music/night.ogg"), "Prima Luna"],
	"casino" : [preload("res://sounds/music/casino.ogg"), "Lively Night"],
	"fantasia" : [preload("res://sounds/music/fantasia.ogg"), "The Rumors Of Fantasia"],
	"wild" : [preload("res://sounds/music/wild.ogg"), "Lost in the wild"],
	"luck" : [preload("res://sounds/music/luck.ogg"), "Lucky to see you"],
	"east" : [preload("res://sounds/music/east.ogg"), "Time to see the East"],
}
func _ready():
	if SaveLoad.data["settings"].has("bgmvol"):
		player.volume_db=linear2db(float(SaveLoad.data["settings"]["bgmvol"]))

# TODO: implement this
func play_anim():
	#player.stream = BGM["battle1"][0]
#	stage.text = stagename
	#anims.play("fade-in")
	#player.play()
	pass
