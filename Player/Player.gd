extends KinematicBody2D

var moveSpeed = 100
var motion = Vector2()

# movement
func _process(delta):
	motion.x = 0; motion.y = 0
	
	if Input.is_action_pressed("ui_right"):
		motion.x = moveSpeed
		if motion.x == 0:
			$Sprite/AnimationPlayer.play("idle_d")
		else:
			$Sprite/AnimationPlayer.play("walk_d")
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -moveSpeed
		if motion.x < 0:
			$Sprite/AnimationPlayer.play("idle_a")
		else:
			$Sprite/AnimationPlayer.play("walk_a")
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -moveSpeed
		if motion.y < 0:
			$Sprite/AnimationPlayer.play("idle_w")
		else:
			$Sprite/AnimationPlayer.play("walk_w")
	
	elif Input.is_action_pressed("ui_down"):
		motion.y = moveSpeed
		if motion.y == 0:
			$Sprite/AnimationPlayer.play("idle_s")
		else:
			$Sprite/AnimationPlayer.play("walk_s")
	
	motion = move_and_slide(motion)
	
	
	pass
