extends Node
onready var exit=$ColorRect/TextureRect
onready var buttons=$ColorRect/ScrollContainer/Divider/Buttons

func _ready() -> void:
  exit.connect("pressed", self, "_but_pre")
  for i in buttons.get_children().size():
    buttons.get_child(i).setup()
  return

func _but_pre() -> void:
  FileMan.dump2sets()
  #player.stop()
  #player.stream=load("res://sounds/fx/settings_end.ogg")
  #player.play()
  #yield(player, "finished")
  SceneManager.change_scene("settings",0)
  return
