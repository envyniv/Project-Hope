extends KinematicBody2D

#init
var movedir = Vector2.ZERO
var speed = 4
var moveSpeed = speed*20
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
		state = MOVE;
	pass

#input
func inputChk():
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var ATTACK = Input.is_action_just_pressed("ui_attack") #so it is only done once
	var DODGE = Input.is_action_just_pressed("ui_dodge")
	var RUN = Input.is_action_pressed("ui_sprint")
	movedir.x = -int(LEFT) + int(RIGHT) #don't move if the left and right keys are pressed
	movedir.y = -int(UP) + int(DOWN)
	pass


func moveState(): #movement
	var motion = movedir.normalized() * moveSpeed
	motion = move_and_slide(motion, Vector2(0,0))
	if RUN: state=RUN;
	pass


#animation
func animHndlr():
	if movedir!=Vector2.ZERO:
		animTree.set("parameters/idle/blend_position", movedir)
		animTree.set("parameters/atk/blend_position", movedir)
		animTree.set("parameters/run/blend_position", movedir)
		animTree.set("parameters/dodg/blend_position", movedir)
		animTree.set("parameters/walk/blend_position", movedir)
		match state:
			MOVE:
				animState.travel("walk")
			RUN:
				animState.travel("run")
			ATK:
				animState.travel("walk")
			DODGE:
				animState.travel("dodge")
		
	else:
		animState.travel("idle")
		pass
	
	pass

func atkState(): #attacking
	
	pass
	
func runState(): #running
	speed = 6;
	pass
	
func dodgeState(): #dodging
	
	pass


