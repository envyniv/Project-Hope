extends Camera2D
onready var topLeft = get_node("../World/Stage/CameraLimits/BottomRight")
onready var bottomRight = get_node("../World/Stage/CameraLimits/BottomRight")
var target = null

func _physics_process(delta):
	if target:
		position = target.position
	pass

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_right = bottomRight.position.y
	limit_bottom = bottomRight.position.x
pass
