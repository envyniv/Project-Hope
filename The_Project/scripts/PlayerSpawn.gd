extends Position2D
onready var player=get_node("../../YSort/Player")
onready var playeranims=get_node("../../YSort/Player/Sprite/AnimationPlayer")
export(String) var FACING

func _ready():
	if player:
		print(player, playeranims)
		match FACING:
			"UP":
				playeranims.play("idle_Up")
			"RIGHT":
				playeranims.play("idle_Right")
			"LEFT":
				playeranims.play("idle_Left")
			"DOWN":
				playeranims.play("idle_Down")
		pass
	pass
