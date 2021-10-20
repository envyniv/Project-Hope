extends Node

func _ready():
  $AnimationPlayer.play("boot")
  SceneManager.change_scene("title",3)
