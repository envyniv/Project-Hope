extends KinematicBody2D

#init
var moveSpeed = 75
var movedir = Vector2.ZERO
var canDo = true #used for special actions like attacking and dodging
onready var animPlayer=$Sprite/AnimationPlayer
onready var animTree=$Sprite/AnimationPlayer/AnimationTree
onready var animState=animTree.get("parameters/playback")
#end_init
	
#state
enum {
	MOVE,
	RUN,
	ATK,
	DODGE,
}

var state = null
#end_state

func _ready():
	animTree.active = true
	pass


func _physics_process(_delta):
	inputChk();
	animHndlr();
	#moving
	match state:
		MOVE:
			moveState();
		RUN:
			runState();
		ATK:
			atkState();
		DODGE:
			dodgeState();
			
	if movedir!=Vector2.ZERO:
		state=MOVE;
	pass

#input
func inputChk():
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var ATTACK = Input.is_action_just_pressed("ui_attack")
	movedir.x = -int(LEFT) + int(RIGHT) #don't move if the left and right keys are pressed
	movedir.y = -int(UP) + int(DOWN)
	pass



#func moving():
#	var motion = movedir.normalized() * moveSpeed
#	move_and_slide(motion, Vector2(0,0))
#	pass

#animation
func animHndlr():
	if movedir!=Vector2.ZERO:
		animTree.set("parameters/idle/blend_position", movedir)
		animTree.set("parameters/atk/blend_position", movedir)
		animTree.set("parameters/run/blend_position", movedir)
		animTree.set("parameters/dodg/blend_position", movedir)
		animTree.set("parameters/walk/blend_position", movedir)
		animState.travel("walk")
		pass
	else:
		animState.travel("idle")
		pass
	
	pass
	
func atkState(): #attacking
	
	pass

func runState(): #running
	
	pass
	
func dodgeState(): #dodging
	
	pass
	
func moveState(): #movement
	var motion = movedir.normalized() * moveSpeed
	move_and_slide(motion, Vector2(0,0))
	
	
	
	pass
