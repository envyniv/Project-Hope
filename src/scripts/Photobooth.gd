extends StaticBody2D

# TODO: FINISH THIS
export (String) var map
var used := false

func _ready():
  SceneManager.stage_ready(map)

func can_interact(interactParent : Node) -> bool:
  return interactParent is Player

func _interact(_interactParent : Node) -> void:
  if used:
    return
  FileMan.data.location=map
  $Booth/Curtain/AnimationPlayer.play("photo")
  used = true
  collision_layer = collision_layer ^ 4

  FileMan.save_game()
  print("save")
