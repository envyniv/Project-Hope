extends Camera2D
onready var topLeft = get_node("../World/Stage/CameraLimits/TopLeft")
onready var bottomRight = get_node("../World/Stage/CameraLimits/BottomRight")
var target = null

func _physics_process(delta):
	if target:
		position = target.position
	if get_node("../World/Stage/ZoomOUT"):
		var zoomout=get_node("../World/Stage/ZoomOUT")
		var player2zoom = stepify(target.position.distance_to(zoomout.position)/1000,0.01);
		var distance = player2zoom
		var step = 0.1
		#store player2zoom in distance, then check if player2zoom is smaller than distance
		#if it's smaller by a step, re-store, and increment zoom by a step
		if player2zoom < distance:
			distance = player2zoom
			zoom + step
pass

func _ready():
	if bottomRight&&topLeft:
		limit_top = topLeft.position.y
		limit_left = topLeft.position.x
		limit_right = bottomRight.position.x
		limit_bottom = bottomRight.position.y
pass

func _zoom():
	if Input.is_action_just_released('wheel_down'):
		$Camera2D.zoom.x += 0.25
		$Camera2D.zoom.y += 0.25
	if Input.is_action_just_released('wheel_up') and $Camera2D.zoom.x > 1 and $Camera2D.zoom.y > 1:
		$Camera2D.zoom.x -= 0.25
		$Camera2D.zoom.y -= 0.25
	pass
