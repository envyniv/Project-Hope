extends KinematicBody2D
#init
class_name Player, "res://scenes/icons/player.png"
var HP = 20
var maxHP = HP
var movedir = Vector2.ZERO
var moveSpeed = 0
var canDo = true #used for special actions like attacking and dodging
var inv = []
onready var animPlayer=$Sprite/AnimationPlayer
onready var animTree=$Sprite/AnimationPlayer/AnimationTree
onready var animState=animTree.get("parameters/playback")
onready var sprite= $Sprite
signal interact_req()
signal thinking()

#state
enum {
	MOVE,
	ATK,
	DODGE,
	RUN,
	THINK,
}

var state = null
#end_state

func _ready():
	for i in inv:
		ItemManager.item_getter(i)
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
		RUN:
			runState();
		THINK:
			thinkState();
	if movedir!=Vector2.ZERO:
		state = MOVE;
	pass

#input
func inputChk(deactivate):
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var WEAK = Input.is_action_just_pressed("ui_accept")
	var PUNCH = Input.is_action_just_pressed("ui_atkmed")
	var HIGH = Input.is_action_just_pressed("ui_cancel")
	var SKILL = Input.is_action_just_pressed("ui_select")
	var SPRINT = Input.is_action_pressed("ui_sprint")
	movedir.x = -int(LEFT) + int(RIGHT) #don't move if the left and right keys are pressed
	movedir.y = -int(UP) + int(DOWN)
	if SPRINT:
		state=RUN;
		moveSpeed=130
	else:
		moveSpeed=80;
		pass
	if SKILL:
		state=THINK;
		pass
	#TODO: replace this terribleness with a code that makes the looking
	#      collision shape point towards the movement vector
	if LEFT:
		$Interact/Looking.rotation_degrees=90
	if RIGHT:
		$Interact/Looking.rotation_degrees=-90
	if UP:
		$Interact/Looking.rotation_degrees=180
	if DOWN:
		$Interact/Looking.rotation_degrees=0
	if DOWN && RIGHT:
		$Interact/Looking.rotation_degrees=-45
	if DOWN && LEFT:
		$Interact/Looking.rotation_degrees=45
	if UP && RIGHT:
		$Interact/Looking.rotation_degrees=-135
	if UP && LEFT:
		$Interact/Looking.rotation_degrees=135
	# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		
	if deactivate:
		return #if you don't want input
	pass


func moveState(): #movement
	var motion = movedir.normalized() * moveSpeed
	motion = move_and_slide(motion, Vector2(0,0))
	pass

func runState():
	moveState();
	pass

#animation
func animHndlr():
	inputChk(0)
	if state==THINK:
			animPlayer.play("think")
	elif movedir!=Vector2.ZERO:
		animTree.set("parameters/idle/blend_position", movedir)
		animTree.set("parameters/run/blend_position", movedir)
		animTree.set("parameters/walk/blend_position", movedir)
		if state==MOVE:
			animState.travel("walk")
		elif state==RUN:
			animState.travel("run")
			pass
	else:
		animState.travel("idle")
		pass
	
	pass

func atkState(): #attacking
	canDo = false
	#animations should not be played here
	#however, checking is fine
	yield( animPlayer, "animation_finished" )
	canDo = true
	pass
	
func thinkState(): #selecting spell
	#move the camera to the right.
	pass
	
func dodgeState(): #dodging
	canDo = false
	pass

func _interact():
	#if WEAK: emit_signal("interact_req")
	pass
	
func _process_damage():
	pass

