extends KinematicBody2D

#initialize

#state machine
enum {
	STILL
	MOVING
	RUNNING
	SPECIAL
}

var state = STILL
var moveSpeed = 100
var motion = Vector2()

# movement
func _process(delta):
	motion.x = 0; motion.y = 0

	if Input.is_action_pressed("ui_right"):
		motion.x = moveSpeed
	elif Input.is_action_pressed("ui_left"):
		motion.x = -moveSpeed
	elif Input.is_action_pressed("ui_up"):
		motion.y = -moveSpeed
	elif Input.is_action_pressed("ui_down"):
		motion.y = moveSpeed
	motion = move_and_slide(motion)

	pass

func anim_handle(): #'you should probably check if the player *is* moving, rather than if they *aren't*' -gotimo2
	if motion.x == 0 and motion.y == 0:
		$Sprite/AnimationPlayer.play("idle")
		
		#needs to be expanded
		
	elif motion.x != 0:
		if motion.x < 0:
			$Sprite/AnimationPlayer.play("walk_a")
		if motion.x > 0:
			$Sprite/AnimationPlayer.play("walk_d")
	elif motion.y != 0:
		if motion.y < 0:
			$Sprite/AnimationPlayer.play("walk_w")
		if motion.y > 0:
			$Sprite/AnimationPlayer.play("walk_s")
	pass
