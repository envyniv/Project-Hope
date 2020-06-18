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

var moveSpeed = 5
var motion = Vector2()
var canDo = true #can the player dodge and attack? idk can they? hahahahhaha funy joke

# movement
func _process(_delta):
	motion.x = 0; motion.y = 0
	get_input()
	anim_handle()
	match state:
		STILL:
			pass
		MOVING:
			pass
		RUNNING:
			pass
		SPECIAL:
			pass
	pass

#animation
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

#if the player is attacking for the thrid time in a short amount of time, then make Spin_Attachment1 and 2 visible and play atk_spin.


#get input and store it in a vector - motion
func get_input():	
	if Input.is_action_pressed("ui_right"):
		motion.x += moveSpeed 	
	elif Input.is_action_pressed("ui_left"):
		motion.x -= moveSpeed
	elif Input.is_action_pressed("ui_up"):
		motion.y -= moveSpeed
	elif Input.is_action_pressed("ui_down"):
		motion.y += moveSpeed
	pass
