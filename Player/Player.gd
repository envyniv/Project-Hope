extends KinematicBody2D

var moveSpeed = 100
var motion = Vector2()

# movement
func _process(delta):
	motion.x = 0; motion.y = 0
	if Input.is_action_pressed("ui_right"):
		motion.x = moveSpeed
	elif Input.is_action_pressed("ui_left"):
		motion.x = -moveSpeed
	if Input.is_action_pressed("ui_up"):
		motion.y = -moveSpeed
	elif Input.is_action_pressed("ui_down"):
		motion.y = moveSpeed
	motion = move_and_slide(motion)
	
	#if motion.x < 0:
		#set left sprite
	#elif motion.x > 0:
		#set right sprite
	#if motion.y < 0:
		#set up sprite
	#if 
	
	
	
	pass
