extends StaticBody2D
export(String) var stage

func can_interact(interactParent : Node) -> bool:
    return interactParent is Player

func _interact(_interactParent : Node) -> void:
  #SaveLoad.switch_stage={true:stage}
  SceneManager.change_scene("game",0)
