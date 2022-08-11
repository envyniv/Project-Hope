extends Node

onready var anims  = $AnimationPlayer
onready var player = $AudioStreamPlayer
# const musfolder = "res://sounds/music/%s.ogg"
var BGM = {}

func _ready():
  # warning-ignore:return_value_discarded
  SceneManager.connect("ready_stage", self, "play_anim")
# warning-ignore:return_value_discarded
  $Timer.connect("timeout", self, "stop_anim")

func play_anim(map: Resource) -> void:
  $ColorRect/Stage.text = map.localizedName
  $ColorRect/Music.text = map.bgmName
  player.stream = map.bgm
  anims.play("fade-in")
  player.play()
  $Timer.start()
  return

func stop_anim() -> void:
  $Timer.stop()
  anims.play_backwards("fade-in")
  return
