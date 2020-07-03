extends KinematicBody2D

#initialize
var right = Input.is_action_pressed("ui_right")
var left = Input.is_action_pressed("ui_left")
var up = Input.is_action_pressed("ui_up")
var down = Input.is_action_pressed("ui_down")
var moveSpeed = 100
var motion = Vector2()
var canDo = true #used for special actions like attacking and dodging

#get input
func get_input():
	if right:
		motion.x += moveSpeed
	if left:
		motion.x -= moveSpeed
	if down:
		motion.y += moveSpeed
	if up:
		motion.y -= moveSpeed
	motion = motion.normalized() * moveSpeed
	pass
	
#state machine
enum {
	STILL
	MOVING
	RUNNING
	SPECIAL
}

var state = STILL

# movement
func _process(delta):
	get_input()
	move_and_collide(motion * delta)
	anim_handle()
	motion.x = 0; motion.y = 0
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

func anim_handle(): #'you should probably check if the player *is* moving, rather than if they *aren't*' -gotimo2
# 
	pass
