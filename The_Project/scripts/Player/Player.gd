extends KinematicBody2D

#init
var HP = 20
var maxHP = HP
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
	ATK,
	DODGE,
	RUN,
}

var state = null
#end_state

func _ready():
	animTree.active = true
	pass


func _physics_process(_delta):
	inputChk(0);
	animHndlr();
	#moving
	match state:
		MOVE:
			moveState();
		ATK:
			atkState();
		DODGE:
			dodgeState();
			
	if movedir!=Vector2.ZERO:
		state = MOVE;
	pass

#input
func inputChk(deactivate):
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var ATK_LIGHT = Input.is_action_just_pressed("ui_atklight")
	var ATK_MED = Input.is_action_just_pressed("ui_atkmed")
	var ATK_HEAVY = Input.is_action_just_pressed("ui_atkheavy")
	var ATK_GOD = Input.is_action_just_pressed("ui_atkgod")
	var DODGE_KEY = Input.is_action_just_pressed("ui_dodge")
	var RUN_KEY = Input.is_action_pressed("ui_sprint")
	movedir.x = -int(LEFT) + int(RIGHT) #don't move if the left and right keys are pressed
	movedir.y = -int(UP) + int(DOWN)
	if RUN_KEY:
		state=RUN;
	if deactivate:
		#don't give input to the player
		return
	pass


func moveState(): #movement
	var motion = movedir.normalized() * moveSpeed
	motion = move_and_slide(motion, Vector2(0,0))
	if state==RUN:
		speed+=9
	pass


#animation
func animHndlr():
	inputChk(0)
	if movedir!=Vector2.ZERO:
		animTree.set("parameters/idle/blend_position", movedir)
		animTree.set("parameters/run/blend_position", movedir)
		animTree.set("parameters/walk/blend_position", movedir)
		if state==MOVE:
				animState.travel("walk")
		elif state==RUN:
			animState.travel("run")
			#if movedir!=Vector2.ZERO:
				#animState.travel("run_Pose")
				#pass
			pass
	else:
		animState.travel("idle")
		pass
	
	pass

func atkState(): #attacking
	canDo = false
	pass
	
func dodgeState(): #dodging
	
	pass


