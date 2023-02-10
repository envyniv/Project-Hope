tool
class_name VesselBase extends KinematicBody2D

var sprintHoldTime: float

var lifeform: Soul

# the AnimationTreePlayer node that will be used
var anim_tree

var sprite

# the AudioStreamPlayer that will be used
var voicebox

# a variable to quickly access the animation state, is set in `_ready`
var anim_state

var movedir  := Vector2.ZERO
var move_spd : float
var walk     = 65
var sprint   = 135
var boost    = 165
var motion

# State machine
enum { MOVE, IDLE, SPRINT, EMOTE }
var state: int

# PARTY MANAGEMENT STUFF =================================


# Array of entities following this one.
export(Array, Resource) var party := []

# Respectively what this entity is following;
var following: Node = null

# And what it is being followed by
var follower: Node = null

# what scene followers of this entity should use as a base.
export(PackedScene) var followerScene

signal moving

# This method adds `whomst`, a `Lifeform` Resource, to your party.
# It then calls for the whole party to stack, in order to hide removal and reinstancing of nodes
func addToParty(whomst: Soul) -> void:
  party.append(whomst)
  stack()
  dealParty()
  return

# Stack party members as if in a deck of cards
func stack() -> void:
  if following:
    movedir = following.position - position
  if follower:
    follower.stack()
  return

# Dealing party members like cards
func dealParty() -> int:
  yield(get_tree(), "idle_frame")
  scrapHand()
  # this establishes who every party member follows
  var previous = self
  for entity in party:
    var followerInstance = followerScene.instance()
    get_parent().add_child(followerInstance) #add sibling
    followerInstance.lifeform = entity
    if previous != null:
      #warning-ignore:RETURN_VALUE_DISCARDED
      previous.connect("moving", followerInstance, "targetAdd")
    else:
      #warning-ignore:RETURN_VALUE_DISCARDED
      connect("moving", followerInstance, "targetAdd")
    previous = followerInstance
  return 0

# Scrapping a hand of cards
func scrapHand() -> void:
  if follower:
    follower.scrap()
  return

func scrap() -> void:
  if follower:
    follower.scrap()
  queue_free()
  return

func joinParty(party_leader: Node) -> void:
  party_leader.addToParty([lifeform].append_array(party))
  following = party_leader
  stack()
  return

func kickFromParty(whomst: Soul) -> void:
  if whomst in party:
    party.erase(whomst)
    stack()
    dealParty()
  return

# PARTY MANAGEMENT STUFF END =============================

"""
func _physics_process(_delta):
  if movedir != Vector2.ZERO:
    #if moveSpeed > 65:
    #  state = SPRINT
    #else:
      state = MOVE
  else:
    state = IDLE
"""

func moveState():
  motion = movedir.normalized() * move_spd
# warning-ignore:return_value_discarded
  move_and_slide(motion, Vector2.ZERO)

func _set(prop: String, val) -> bool:
  match prop:
    "EntityResource":
      lifeform = val
    "AnimationTree":
      anim_tree = val
    "Sprite":
      sprite = val
    "AudioStreamPlayer":
      voicebox = val
    "SprintHoldTime":
      sprintHoldTime = val
    # "Party":
    #   party = val
    _:
      return false
  property_list_changed_notify()
  return true

func _get(prop: String):
  match prop:
    "EntityResource":
      return lifeform
    "AnimationTree":
      return anim_tree
    "Sprite":
      return sprite
    "AudioStreamPlayer":
      return voicebox
    "SprintHoldTime":
      return sprintHoldTime
    # "Party":
    #   return party
  return null

func _get_property_list() -> Array:
  var properties := []
  properties.append({
    "name": "Basic Vessel Properties",
    "type": TYPE_NIL,
    "usage": PROPERTY_USAGE_CATEGORY#,
#    "hint_tooltip":"Properties common to all entities"
  })
  # properties.append({
  #   "name":"Party",
  #   "type": TYPE_ARRAY,
  #   "hint": PROPERTY_HINT_RESOURCE_TYPE,
  #   "hint_string": "Resource"
  # })
  properties.append({
    "name": "EntityResource",
    "type" : typeof(Resource),
    "hint" : PROPERTY_HINT_RESOURCE_TYPE,
    "hint_string" : ""
  })
  properties.append({
    "name": "AnimationTree",
    "type" : TYPE_NODE_PATH
  })
  properties.append({
    "name": "Sprite",
    "type" : TYPE_NODE_PATH
  })
  properties.append({
    "name": "AudioStreamPlayer",
    "type" : TYPE_NODE_PATH
  })
  properties.append({
    "name": "SprintHoldTime",
    "type": TYPE_REAL
  })
  return properties

func spriteSetup() -> bool:
  if sprite:
    sprite = get_node(sprite)
  else:
    return true
  if lifeform:
    sprite.centered = false
    sprite.texture = lifeform.overworld
    return false
  return true

func animSetup() -> bool:
  anim_tree = get_node(anim_tree)
  if anim_tree:
    anim_state = anim_tree.get("parameters/StateMachine/playback")
  return false

func _ready() -> void:
  # avoid the editor imploding
  if Engine.editor_hint:
    return
  # get all the nodes ready
  voicebox = get_node_or_null(voicebox)
  animSetup()
  if spriteSetup():
    print("Something went wrong with the sprite set-up process.")
  dealParty()
  return

func sprintState() -> void: #slingshot sprinting
  yield(get_tree().create_timer(sprintHoldTime), "timeout")
  if !(Input.is_action_pressed("sprint") && movedir == Vector2.ZERO):
    return
  move_spd = boost
  voicebox.play()
  state = MOVE
  return

func animHndlr() -> void:
  if movedir != Vector2.ZERO:
    anim_tree.set("parameters/TimeScale/scale", move_spd/walk)
    anim_tree.set("parameters/StateMachine/walk/blend_position", movedir)
    anim_tree.set("parameters/StateMachine/crouch/blend_position", movedir)
    anim_state.travel("walk")
    if move_spd > walk:
      anim_tree.set("parameters/StateMachine/run/blend_position", movedir)
      anim_state.travel("run")
  else:
    if move_spd > sprint:
      anim_state.travel("crouch")
    else:
      anim_state.travel("walk")
    anim_tree.set("parameters/TimeScale/scale", 0)
  return

func _physics_process(_delta) -> void:
  if (anim_state && state != EMOTE):
    animHndlr()
  match state:
    IDLE:
      return
    MOVE:
      moveState()
    SPRINT:
      sprintState()
  return

# function relays, mostly for dialogue scripting

func borrowCamera() -> void:
  SceneManager.borrowCamera(self)
  return

func returnCamera() -> void:
  SceneManager.returnCamera()
  return

# makes playing animations painless. Mainly for dialogue scripting
func animate(name: String) -> void:
  var anim_player = get_node(anim_tree.anim_player)
  if anim_player.has_animation(name):
    var _tmp = state
    state = EMOTE
    anim_player.play(name)
    yield(anim_player, "animation_finished")
    state = _tmp
  return
