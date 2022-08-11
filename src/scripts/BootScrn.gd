extends Node

func _ready():
  $AnimationPlayer.play("boot")
  SceneManager.change_scene("title",5)
  FileMan.replace_binds()
