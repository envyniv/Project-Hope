extends Node

onready var anims=$AnimationPlayer
onready var player=$AudioStreamPlayer
const musfolder = "res://sounds/music/%s.ogg"
var BGM = {
    "battle1" :  [load(musfolder % "bits"), "Battle To Bits"],
    "battle2" :  [load(musfolder % "crazy"), "About To Get Crazy"],
    "battle3" :  [load(musfolder % "enemy"), "From The Enemy"],
    "battle4" :  [load(musfolder % "hand"), "What Has It Come To?"],
    "battle5" :  [load(musfolder % "orchestra"), "Orchestrating A Fight"],
    "battle6" :  [load(musfolder % "sounds"), "Sounds Of Battle"],
    "think" :    [load(musfolder % "think"), "Think, Quick!"],
    "save" :     [load(musfolder % "save"), "Time To Save"],
    "winter" :   [load(musfolder % "winter"), "New World"],
    "sweet" :    [load(musfolder % "sweet"), "Sweet Melody"],
    "start" :    [load(musfolder % "start"), "Start of a Story"],
    "night" :    [load(musfolder % "night"), "Prima Luna"],
    "casino" :   [load(musfolder % "casino"), "Lively Night"],
    "fantasia" : [load(musfolder % "fantasia"), "The Rumors Of Fantasia"],
    "wild" :     [load(musfolder % "wild"), "Lost in the wild"],
    "luck" :     [load(musfolder % "luck"), "Lucky to see you"],
    "east" :     [load(musfolder % "east"), "Time to see the East"],
}
func _ready():
  if SaveLoad.data["settings"].has("bgmvol"):
    player.volume_db=linear2db(float(SaveLoad.data["settings"]["bgmvol"]))
  play_anim()

# TODO: implement this
func play_anim():
  player.stream = BGM["battle1"][0]
  #stage.text = stagename
  anims.play("fade-in")
  player.play()
