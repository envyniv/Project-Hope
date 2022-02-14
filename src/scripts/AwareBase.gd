extends KinematicBody2D
class_name AwareBase
enum look { UP, RIGHT, DOWN, LEFT }
export (look) var facing

var movedir:= Vector2.ZERO
var moveSpeed:int = 65 #TODO: resolve having to manually type 65 moveSpeed in all movement altering functions' else statements
var motion


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
var nextXP = get_next_xp(LV + 1)  # 10 to 10098

enum { MOVE, ATKING, DODGE, THINK, STUN, KO, TAIL }
var state

func calc_damage() -> void:
  HP-=1
  FileMan.update_values(self)
  return

func camera_stop_follow() -> void:
  SceneManager.tactical_lock_on(null)
  return

func enable_input() -> void:
  set_process_unhandled_input(true)
  return

func disable_input() -> void:
  set_process_unhandled_input(false)
  return

func disable_interaction() -> void:
  $Interact/Looking.disabled = true
  $InteractUI.hide()
  $Interact.hide()
  return

func get_next_xp(level) -> float:
  return round(level*level + level * 3)#level^2 + level*3, for whoever doesn't understand level*level

func value_check() -> void:
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

func after_battle() -> void:
  #XP+enemydrop*PRO
  if XP >= nextXP:
    levelUp()
  return

func levelUp() -> void:
  LV += 1
#maxHP=int(LV^2/3)
#ATK=int(HP*0.6)
#nextXP=LV*100
  return

func rollbackDEF(amount):
  print(DEF)
  var after = DEF - amount
  for i in amount:
    yield(get_tree().create_timer(1.5), "timeout")
    DEF -= 1
    FileMan.update_values(self)
  if DEF <= after:
    return

func heal(amount) -> void:
  HP += amount
  return

func toughen(amount) -> void:
  DEF += amount
  return

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
  if movedir != Vector2.ZERO:
    state = MOVE

func moveState():  #movement
  motion = movedir.normalized() * moveSpeed
# warning-ignore:return_value_discarded
  move_and_slide(motion, Vector2(0, 0))
  if movedir != Vector2.ZERO:
    var compare = Vector2.DOWN
    var difference = compare.angle_to(motion)
    $Interact.rotation_degrees = rad2deg(difference)

func atkState():  #attacking
  pass

func thinkState():  #selecting spell
  pass

func dodgeState():  #dodging
  canDo = false

func stunState():
  pass

func downState():
  pass
