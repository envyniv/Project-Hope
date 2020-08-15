extends Camera2D

var target = null

func _physics_process(delta):
	if target:
		position = target.position
	pass
