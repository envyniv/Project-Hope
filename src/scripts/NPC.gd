extends PlayerFollower
class_name NPC

#export(bool) var isEnemy
#export(String) var enemyResource

export(String) var associatedDialogue
export(bool) var walksAround

export(float) var perceptionRange
export(float) var eyesight

export(float, 0.0, 30.5) var wanderRange
export(bool) var ltdFourDirections

func setup() -> void:  #npc specific
  #SceneManager.connect("player_chdir", self, "add_snake_queue")
  position #first point in any curve
    #random curve, go back to first
  return

func can_interact(interactParent : Node) -> bool:
  return interactParent is Player

func _interact(_interactParent : Node) -> void:
  if associatedDialogue!="":
    SceneManager.start_convo(associatedDialogue)
  #if isEnemy:
    #SceneManager.change_level_relay("battle")
    #SceneManager.battle_started()
  #  pass
