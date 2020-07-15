extends KinematicBody2D

#initialize
var moveSpeed = 100
var movedir = Vector2.ZERO
var canDo = true #used for special actions like attacking and dodging
onready var animPlayer=$Sprite/AnimationPlayer
onready var animTree=$Sprite/AnimationPlayer/AnimationTree
onready var animState=animTree.get("parameters/playback")

	
#state machine
enum {
	STILL
	MOVING
	RUNNING
	SPECIAL
	MINIGM
}

var state = STILL

func _physics_process(_delta):
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
	if movedir!=Vector2.ZERO:
		animTree.set("parameters/idle/blend_position", movedir)
		animTree.set("parameters/atk/blend_position", movedir)
		animTree.set("parameters/run/blend_position", movedir)
		animTree.set("parameters/dodg/blend_position", movedir)
		animState.travel("walk")
		pass
	
	pass
