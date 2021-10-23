tool
extends KinematicBody2D
class_name Player
enum look { UP, RIGHT, DOWN, LEFT }
export (look) var facing

var movedir:= Vector2.ZERO
var moveSpeed:int = 65 #TODO: resolve having to manually type 65 moveSpeed in all movement altering functions' else statements
var motion

var curvefollow
var followindex = 0
var followpoints
export (bool) var snakeTail
export (int, 1, 50) var follower

var canDo = true  #used for special actions like attacking and dodging

export (int) var maxHP:= 20  #1 to 999
var HP = maxHP
export (int) var maxDEF = 10  #1 to 499
var DEF = maxDEF
export (int) var maxMANA = 5  #1 to 10
var MANA = maxMANA
export (int) var EVA = 5  #1 to 4; 1 = 10% chance avoid
var LV = 1  #1 to 99
var PRO = 1  #1 to 3x times the XP
var CHR = 0  #0 to 30% chance of inflicting lovestun
var LUC = 0  #0 to 40% chance of crit
export (int) var ATK = 3  #1 to 250?
var XP = 0
var nextXP = get_next_xp(LV + 1)  # 100 to 4900 for LV98?
onready var animPlayer = $Sprite/AnimationPlayer
onready var animTree =   $Sprite/AnimationPlayer/AnimationTree
onready var animState =  animTree.get("parameters/playback")
onready var sprite =     $Sprite
onready var hitbox =     $HitBox
onready var damagebox =  $DamageBox

enum { MOVE, ATKING, DODGE, THINK, STUN, KO, TAIL }
var state


func _ready():
  #  disable_input()
  value_check()
  match facing:
    look.UP:
      animPlayer.play("idle_Up")
    look.RIGHT:
      animPlayer.play("idle_Right")
    look.DOWN:
      animPlayer.play("idle_Down")
    look.LEFT:
      animPlayer.play("idle_Left")
  animTree.active = true
  #emit_signal("player_control", true)
  if snakeTail:
    disable_interaction()
    disable_input()
    $Collision.disabled = true
    #warning-ignore:return_value_discarded
    SceneManager.connect("player_chdir", self, "add_snake_queue")
    #get_parent().connect("player_run", self, "add_snake_queue")
  else:
    SceneManager.tactical_lock_on(self)
    # warning-ignore:return_value_discarded
    SceneManager.connect("convo_y", self, "disable_input")
    # warning-ignore:return_value_discarded
    SceneManager.connect("convo_n", self, "enable_input")
    # warning-ignore:return_value_discarded
    SceneManager.connect("fighting", self, "enable_input")
    # warning-ignore:return_value_discarded
    SceneManager.connect("fighting_over", self, "disable_input")
    # warning-ignore:return_value_discarded
    SceneManager.connect("vending", self, "disable_input")
    # warning-ignore:return_value_discarded
    SceneManager.connect("left_vending", self, "enable_input")
    # warning-ignore:return_value_discarded
    SceneManager.connect("pDisable", self, "disable_input")
    # warning-ignore:return_value_discarded
    SceneManager.connect("pEnable", self, "enable_input")
    # warning-ignore:return_value_discarded
    hitbox.connect("area_entered", self, "on_hitbox")

func calc_damage():
  HP-=1
  FileMan.update_values(self)

func on_hitbox(area):
  if area.get_parent() != hitbox.get_parent():
    calc_damage()
  pass

func _exit_tree():
  if !snakeTail:
    camera_stop_follow()

func camera_stop_follow():
  SceneManager.tactical_lock_on(null)

func enable_input():
  set_process_unhandled_input(true)

func disable_input():
  set_process_unhandled_input(false)

func disable_interaction():
  $Interact/Looking.disabled = true
  $InteractUI.hide()
  $Interact.hide()

func get_next_xp(level):
  return round(pow(level, 1.85)) + level * 0.75

func value_check():
  #if HP>maxHP add difference to DEF
  #FIXME? should def from hp items be temporary?
  if HP > maxHP:
    var dif = HP - maxHP
    DEF += dif
    HP = maxHP
    rollbackDEF(dif)
  if DEF > maxDEF:
    DEF = maxDEF

  if maxHP > 999:
    maxHP = 999
  if maxDEF > 499:
    maxDEF = 499
  if ATK > 250:
    ATK = 250
  if PRO > 3:
    PRO = 3
  if LV > 99:
    LV = 99
  if CHR > 30:
    CHR = 30
  if HP <= 0:
    state = KO

func after_battle():
  #XP+enemydrop*PRO
  if XP >= nextXP:
    levelUp()

func levelUp():
  LV += 1
#maxHP=int(LV^2/3)
#ATK=int(HP*0.6)
#nextXP=LV*100

func rollbackDEF(amount):
  print(DEF)
  var after = DEF - amount
  for i in amount:
    yield(get_tree().create_timer(1.5), "timeout")
    DEF -= 1
    FileMan.update_values(self)
  if DEF <= after:
    return

func heal(amount):
  HP += amount

func toughen(amount):
  DEF += amount

func _unhandled_input(_event):
  var UP = Input.is_action_pressed("ui_up")
  var DOWN = Input.is_action_pressed("ui_down")
  var RIGHT = Input.is_action_pressed("ui_right")
  var LEFT = Input.is_action_pressed("ui_left")
  #if true in FileMan.inBattle:
  #    var ATTK={
  #        WEAK = Input.is_action_pressed("ui_accept"),
  #        PUNCH = Input.is_action_pressed("atkmed"),
  #        HIGH = Input.is_action_pressed("ui_cancel")
  #        }
  #    var SKILL = Input.is_action_just_pressed("ui_select")
  #    if SKILL:
  #        state=THINK;
  #    if (ATTK.WEAK||ATTK.PUNCH||ATTK.HIGH):
  #        state=ATKING

  var SPRINT = Input.is_action_pressed("sprint")
  movedir.x = -int(LEFT) + int(RIGHT)  #don't move if the left and right keys are pressed
  movedir.y = -int(UP) + int(DOWN)
  if SPRINT:
    moveSpeed = 130
  else:
    moveSpeed = 65

func _physics_process(_delta):
  animHndlr()
  if snakeTail:
    snakeState()
  else:
    match state:
      MOVE:
        moveState()
      ATKING:
        atkState()
      DODGE:
        dodgeState()
      THINK:
        thinkState()
      STUN:
        stunState()
      KO:
        downState()
  if movedir != Vector2.ZERO:
    state = MOVE

func snakeState():
  if !curvefollow:
    return
  followpoints = curvefollow.get_baked_points()
  var target = followpoints[followindex]
  if position.distance_to(target) < 16 * follower:
    followindex += 1
    if followindex >= followpoints.size():
      followindex = 0
      curvefollow = null
      movedir = Vector2.ZERO
    target = followpoints[followindex]
  else: # this else was put to stop the walking animation from playing every frame, but causes janky motion
    movedir = target - position
    var multiplier = position.distance_to(target)
    motion = movedir.normalized() * multiplier * 6 / follower
    motion = move_and_slide(motion, Vector2(0, 0))
  if position.distance_to(target) > 17 * follower:
    moveSpeed = 130
  else:
    moveSpeed = 65


func add_snake_queue(curve):
  curvefollow = curve

func moveState():  #movement
  motion = movedir.normalized() * moveSpeed
  move_and_slide(motion, Vector2(0, 0))
  if movedir != Vector2.ZERO:
    var compare = Vector2.DOWN
    var difference = compare.angle_to(motion)
    $Interact.rotation_degrees = rad2deg(difference)

func animHndlr():
  animTree.set("parameters/run_Pose/blend_position", movedir)
  animTree.set("parameters/idle/blend_position", movedir)
  animTree.set("parameters/walk/blend_position", movedir)
  if state == THINK:
    animPlayer.play("think")
  elif state == STUN:
    print("player stunned")
  elif movedir != Vector2.ZERO:
    animState.travel("walk")
  else:
    animState.travel("idle")
    if moveSpeed > 65:
      animState.travel("run_Pose")

func atkState():  #attacking
  canDo = false
  animPlayer.play("atk_airborne")
  yield(animPlayer, "animation_finished")
  canDo = true

func thinkState():  #selecting spell
  pass

func dodgeState():  #dodging
  canDo = false

func stunState():
  pass

func downState():
  pass
