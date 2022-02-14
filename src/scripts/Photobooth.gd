extends StaticBody2D

export (String) var map
var used := false

func _ready():
  SceneManager.stage_ready(map)

func can_interact(interactParent : Node) -> bool:
  return interactParent is Player

func _interact(_interactParent : Node) -> void:
  #TODO: to do this changes are required in "res://scripts/gui/DiagBox.gd"
  #the game now prompts you before saving, but we still need to check if the player replied yes or no.
  #SceneManager.start_convo("save")
  var image = get_viewport().get_texture().get_data()
  if used:
    return
  FileMan.data.location=map
  FileMan.data.preview=image
  $Booth/Curtain/AnimationPlayer.play("photo")
  used = true
  collision_layer = collision_layer ^ 4
  FileMan.data.position=SceneManager.head.position
#  if SceneManager.start_convo("save-quit"):
  FileMan.data.playtime+=(OS.get_unix_time()-FileMan.curtime)

  FileMan.save_game()
