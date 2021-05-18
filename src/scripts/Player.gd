extends KinematicBody2D
class_name Player
export(String, "UP", "RIGHT", "DOWN", "LEFT") var Facing
var movedir = Vector2.ZERO
var moveSpeed
var canDo = true #used for special actions like attacking and dodging
export var stats = {
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

enum {
    MOVE,
    ATKING,
    DODGE,
    THINK,
    STUN,
    DOWN
}
var state

func _process(_delta):
    SaveLoad.tempdata["Kevin"]=stats
    if SaveLoad.inDialog || SaveLoad.inShop==true:
        set_process_unhandled_input(false)
        moveSpeed=0
    else:
        set_process_unhandled_input(true)

func _ready():
    SceneManager.tactical_lock_on(self)
    value_check()
    if SaveLoad.tempdata.has("Kevin"):
        stats=SaveLoad.tempdata["Kevin"]
    match Facing:
        "UP":
            animPlayer.play("idle_Up")
        "RIGHT":
            animPlayer.play("idle_Right")
        "DOWN":
            animPlayer.play("idle_Down")
        "LEFT":
            animPlayer.play("idle_Left")
    animTree.active = true
    #emit_signal("player_control", true)

func value_check():
    #if HP>maxHP add difference to DEF
    if stats.HP > stats.maxHP:
        stats.DEF += (stats.HP-stats.maxHP);
        stats.HP = stats.maxHP

    if stats.DEF > stats.maxDEF:
        stats.DEF = stats.maxDEF

    if stats.maxHP > 999:
        stats.maxHP=999;
    if stats.maxDEF > 499:
        stats.maxDEF=499;
    if stats.ATK > 250:
        stats.ATK=250;
    if stats.PRO > 3:
        stats.PRO=3;
    if stats.LV > 99:
        stats.LV=99;
    if stats.CHR > 30:
        stats.CHR=30;
    if stats.HP == 0:
        state=DOWN

func after_battle():
    #stats.XP+enemydrop*stats.PRO
    if stats.XP == stats.nextXP:
        stats.LV+=1
        stats.maxHP=int(stats.LV^2/3)
        stats.ATK=int(stats.HP*0.6)
        stats.nextXP=stats.LV*100

func _unhandled_input(_event):
    var UP = Input.is_action_pressed("ui_up")
    var DOWN = Input.is_action_pressed("ui_down")
    var RIGHT = Input.is_action_pressed("ui_right")
    var LEFT = Input.is_action_pressed("ui_left")
    if true in SaveLoad.inBattle:
        var ATTK={
            WEAK = Input.is_action_pressed("ui_accept"),
            PUNCH = Input.is_action_pressed("atkmed"),
            HIGH = Input.is_action_pressed("ui_cancel")
            }
        var SKILL = Input.is_action_just_pressed("ui_select")
        if SKILL:
            state=THINK;
        if (ATTK.WEAK||ATTK.PUNCH||ATTK.HIGH):
            state=ATKING

    var SPRINT = Input.is_action_pressed("sprint")
    movedir.x = -int(LEFT) + int(RIGHT) #don't move if the left and right keys are pressed
    movedir.y = -int(UP) + int(DOWN)
    if SPRINT:
        moveSpeed=130
    else:
        moveSpeed=80

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
        state = MOVE

func moveState(): #movement
    var motion = movedir.normalized() * moveSpeed
    motion = move_and_slide(motion, Vector2(0,0))
    if movedir!=Vector2.ZERO:
        var compare=Vector2.DOWN
        var difference=compare.angle_to(motion)
        $Interact.rotation_degrees=rad2deg(difference)

func animHndlr():
    if state == THINK:
            animPlayer.play("think")
    elif movedir != Vector2.ZERO:
        animTree.set("parameters/idle/blend_position", movedir)
        animTree.set("parameters/run/blend_position", movedir)
        animTree.set("parameters/walk/blend_position", movedir)
        if state == MOVE:
            animState.travel("walk")
        if moveSpeed > 80:
            animState.travel("run")
            if movedir==Vector2.ZERO:
                animState.travel("run_Pose")
    else:
        animState.travel("idle")

func atkState(): #attacking
    canDo = false
    animPlayer.play("atk_airborne")
    yield(animPlayer, "animation_finished")
    canDo = true

func thinkState(): #selecting spell
    pass

func dodgeState(): #dodging
    canDo = false

func stunState():
    pass

func downState():
    pass
