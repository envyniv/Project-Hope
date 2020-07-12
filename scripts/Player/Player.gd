extends KinematicBody2D

#initialize
var moveSpeed = 100
var movedir = Vector2()
var canDo = true #used for special actions like attacking and dodging
var facing = "down"

	
#state machine
enum {
	STILL
	MOVING
	RUNNING
	SPECIAL
	MINIGM
}

var state = STILL

func _physics_process(delta):
	input_check();
	movement();
	anim_handler();
	pass

#input
func input_check():
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	movedir.x = -int(LEFT) + int(RIGHT) #made so that when pressing u&d or l&r the player won't have a stroke.
	movedir.y = -int(UP) + int(DOWN)
	pass


# movement
func movement():
	var motion = movedir.normalized() * moveSpeed
	move_and_slide(motion, Vector2(0,0))
	pass

func anim_handler(): #'you should probably check if the player *is* moving, rather than if they *aren't*' -gotimo2
	
	#facing helper
	match movedir:
		Vector2(-1,0):
			facing = "linearLeft"
		Vector2(1,0):
			facing = "linearRight"
		Vector2(0,-1):
			facing = "linearUp"
		Vector2(0,1):
			facing = "linearDown"
		Vector2(1,1):
			facing = "diagRightDown"
		Vector2(-1,-1):
			facing = "diagLeftUp"
		Vector2(1,-1):
			facing = "diagRightUp"
		Vector2(-1,1):
			facing = "diagLeftDown"
			
	pass
