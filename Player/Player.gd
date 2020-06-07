extends KinematicBody2D

var moveSpeed = 5
var motion = Vector2()

func anim_handle(): #sorry for messing with your code and removing a significant bit because i don't know what the anims are for exactly - but you should probably check if the player *is* moving, rather than if they *aren't* 
	if motion.x == 0 and motion.y == 0:
		$Sprite/AnimationPlayer.play("stop")
	elif motion.x != 0:
		$Sprite/AnimationPlayer.play("walk_s")
	elif motion.y != 0:
		$Sprite/AnimationPlayer.play("walk_s")
		

func get_input():	#get input and store it in a vector - motion
	
	if Input.is_action_pressed("ui_right"):
		motion.x += 1 	
	elif Input.is_action_pressed("ui_left"):
		motion.x += -1
	elif Input.is_action_pressed("ui_up"):
		motion.y += -1
	elif Input.is_action_pressed("ui_down"):
		motion.y += 1
	elif motion.y > 1:
		motion.y = 1
	elif motion.x > 1:
		motion.x = 1
	elif motion.y < -1:
		motion.y = -1
	elif motion.x < -1:
		motion.x = -1		
	
	else:
		motion.x = 0; motion.y = 0
	


# movement
func _process(delta):
	get_input()
	anim_handle()
	var movement = motion * moveSpeed * delta
	var _movementOutput = move_and_collide(movement)


