extends Node
var screen_size = OS.get_screen_size()
var window_size = OS.get_window_size()

func _ready():
  OS.set_window_position(screen_size*0.5 - window_size*0.5) #center window
  $AnimationPlayer.play("boot")
  SceneManager.change_scene("title",3)
  FileMan.replace_binds()
