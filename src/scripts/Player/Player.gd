extends KinematicBody2D
#init
class_name Player, "res://scenes/icons/player.png"
var movedir = Vector2.ZERO
var moveSpeed
var battle_mode=true
var canDo = true #used for special actions like attacking and dodging
var inv = []
var party = []
var stats={
	HP = 20,
	maxHP = 20, #1 to 999
	DEF = 10,
	maxDEF = 10, #1 to 499
	MANA = 5,
	maxMANA = 5, #1 to 10
	EVA = 5, #1 to 4; 1 = 10% chance avoid
	LV = 1, #1 to 99
	PRO = 1, #1 to 3x times the XP
	CHR = 0, #0 to 30% chance of inflicting lovestun
	LUC = 0, #0 to 40% chance of crit
	ATK = 3, #1 to 250?
	XP = 0,
	nextXP = 100, #100 to 4900 for LV98?
}
onready var animPlayer=$Sprite/AnimationPlayer
onready var animTree=$Sprite/AnimationPlayer/AnimationTree
onready var animState=animTree.get("parameters/playback")
onready var sprite=$Sprite
signal interact_req()
signal thinking()
signal player_control()
signal no_player_control()

#state
enum {
	MOVE,
	ATKING,
	DODGE,
	THINK,
	STUN,
	DOWN
}

var state
#end_state

func _ready():
#	for i in inv:
#		ItemManager.item_getter(i)
	animTree.active = true
	value_check();
	pass

func value_check():
	#if HP>maxHP add difference to DEF
	if stats.HP > stats.maxHP:
		stats.DEF+=(stats.HP-stats.maxHP);
		stats.HP=stats.maxHP
	if stats.DEF > stats.maxDEF:
		stats.DEF=stats.maxDEF
	#if maxstats are more than expected, bring them back
	if stats.maxHP>999:stats.maxHP=999;
	if stats.maxDEF>499:stats.maxDEF=499;
	if stats.ATK>250:stats.ATK=250;
	if stats.PRO>3:stats.PRO=3;
	if stats.LV>99:stats.LV=99;
	if stats.CHR>30:stats.CHR=30;
	if stats.HP==0:state=DOWN
	pass
	
func after_battle():
	#stats.XP+enemydrop*stats.PRO

	if stats.XP == stats.nextXP:
		stats.LV+=1
		stats.maxHP=int(stats.LV^2/3)
		stats.ATK=int(stats.HP*0.6)
		stats.nextXP=stats.LV*100
	pass

func _unhandled_input(_event):
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var ATTK={
		WEAK = Input.is_action_pressed("ui_accept"),
		PUNCH = Input.is_action_pressed("ui_atkmed"),
		HIGH = Input.is_action_pressed("ui_cancel")
		}
	var SKILL = Input.is_action_just_pressed("ui_select")
	var SPRINT = Input.is_action_pressed("ui_sprint")
	movedir.x = -int(LEFT) + int(RIGHT) #don't move if the left and right keys are pressed
	movedir.y = -int(UP) + int(DOWN)
	if SPRINT:
		moveSpeed=130
	else:
		moveSpeed=80
	if SKILL:
		state=THINK;
		pass
	if (ATTK.WEAK||ATTK.PUNCH||ATTK.HIGH)&&battle_mode==true: state=ATKING
	pass

func _physics_process(_delta):
	animHndlr();
	
	match state:
		MOVE:
			moveState();
		ATKING:
			atkState();
		DODGE:
			dodgeState();
		THINK:
			thinkState();
		STUN:
			stunState();
		DOWN:
			downState();
	
	if movedir!=Vector2.ZERO:
		state = MOVE;
	pass

func moveState(): #movement
	var motion = movedir.normalized() * moveSpeed
	motion = move_and_slide(motion, Vector2(0,0))
	if movedir!=Vector2.ZERO:
		$Interact/Looking.shape.b=move_and_slide(movedir.normalized()*30, Vector2(0,0))
	pass

#animation
func animHndlr():
	if state==THINK:
			animPlayer.play("think")
	elif movedir!=Vector2.ZERO:
		animTree.set("parameters/idle/blend_position", movedir)
		animTree.set("parameters/run/blend_position", movedir)
		animTree.set("parameters/walk/blend_position", movedir)
		if state==MOVE:
			animState.travel("walk")
		if moveSpeed>80:
			animState.travel("run")
			pass
	else:
		animState.travel("idle")
		pass
	
	pass

func atkState(): #attacking
	canDo = false
	animPlayer.play("atk_airborne")
	yield(animPlayer, "animation_finished")
	canDo = true
	pass
	
func thinkState(): #selecting spell
	
	pass
	
func dodgeState(): #dodging
	canDo = false
	pass

func _interact():
	
	pass
	
func _process_damage():
	pass
	
func stunState():
	pass

func downState():
	set_process_unhandled_input(false)
	print("dead")
	pass
