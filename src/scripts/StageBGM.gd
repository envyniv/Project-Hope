extends Node

onready var anims=$AnimationPlayer
onready var player=$AudioStreamPlayer
const musfolder = "res://sounds/music/%s.ogg"
var BGM = {
    "battle1" :  [load(musfolder % "bits"),      "Battle To Bits"],
    "battle2" :  [load(musfolder % "crazy"),     "About To Get Crazy"],
    "battle3" :  [load(musfolder % "enemy"),     "From The Enemy"],
    "battle4" :  [load(musfolder % "hand"),      "What Has It Come To?"],
    "battle5" :  [load(musfolder % "orchestra"), "Orchestrating A Fight"],
    "battle6" :  [load(musfolder % "sounds"),    "Sounds Of Battle"],
    "save" :     [load(musfolder % "save"),      "Time To Save"],
    "winter" :   [load(musfolder % "winter"),    "New World"],
    "sweet" :    [load(musfolder % "sweet"),     "Sweet Melody"],
    "start" :    [load(musfolder % "start"),     "Start of a Story"],
    "night" :    [load(musfolder % "night"),     "Prima Luna"],
    "casino" :   [load(musfolder % "casino"),    "Lively Night"],
    "fantasia" : [load(musfolder % "fantasia"),  "The Rumors Of Fantasia"],
    "wild" :     [load(musfolder % "wild"),      "Lost in the wild"],
    "luck" :     [load(musfolder % "luck"),      "Lucky to see you"],
    "east" :     [load(musfolder % "east"),      "Time to see the East"],
}
func _ready():
  player.volume_db=linear2db(FileMan.data.bgmvol)
  play_anim()
  $Timer.connect("timeout", self, "stop_anim")

# TODO: implement this
func play_anim():
  player.stream = BGM["save"][0]
  #stage.text = stagename
  anims.play("fade-in")
  player.play()
  $Timer.start()

func stop_anim():
  $Timer.stop()
  anims.play_backwards("fade-in")
  pass
