tool
extends PlayerFollower
class_name NPC

var met_player := 0 #number of times NPC has been interacted with

#export(bool) var isEnemy setget _setEnemy
var isEnemy := false
#export(bool) var joinsParty setget _setPartyMem
var joinsParty := false

var associatedDialogue
export var partyDialogue: Resource
#export(bool) var walksAround
var walks

#how far away the enemy can sense you
# TODO: maybe inversely proportional to EVA on player?
#export(float) var perceptionRange
var perceptionRange : float
#how far away the enemy can spot you (they have to be looking at you)
#export(float) var eyesight
var eyesight : float

#export(float, 0.0, 30.5) var wanderRange
var wanderRange
#export(bool) var ltdFourDir
var ltdFourDir

onready var flashTimer = null


func _set(prop: String, val) -> bool:
  match prop:
    "Enemy":
      isEnemy = val

    "walksAround":
      walks = val
    _:
      return false
  property_list_changed_notify()
  return true

func _get(prop: String):
  match prop:
    "Enemy":
      return isEnemy
    "walksAround":
      return walks
  return null


func _get_property_list() -> Array:
  var properties = []
  properties.append({
    "name":"associatedDialogue",
    "type" : typeof(Resource),
    "hint" : PROPERTY_HINT_RESOURCE_TYPE,
    "hint_string" : ""
  })

  if (lifeform != null):
    properties.append({
      "name" : "Enemy",
      "type" : TYPE_BOOL
    })
    if !isEnemy:
      properties.append({
        "name" : "joinsParty",
        "type" : TYPE_BOOL
      })

  properties.append({
    "name" : "walksAround",
    "type" : TYPE_BOOL
  })
  if walks:
    properties.append({
      "name" : "wanderRange",
      "type" : TYPE_REAL
    })
    properties.append({
      "name" : "ltdFourDir",
      "type" : TYPE_BOOL
    })
    if isEnemy:
      properties.append({
        "name" : "perceptionRange",
        "type" : TYPE_REAL
      })
      properties.append({
        "name" : "eyesight",
        "type" : TYPE_REAL
      })
  return properties

func setup() -> void:  #npc specific
  position # TODO: construct path to follow based on position and wanderRange
  return

func _ready() -> void:
  flashTimer = Timer.new()
  add_child(flashTimer)
  flashTimer.wait_time = 0.05
  flashTimer.connect("timeout", self, "onFlashTimeout")
  return

func can_interact(interactParent : Node) -> bool:
  if (interactParent is Player):
    flash()
    return true
  return false

func flash() -> void:
  sprite.material.set_shader_param("flash_modifier", 1)
  flashTimer.start()
  return

func onFlashTimeout() -> void:
  sprite.material.set_shader_param(
    "flash_modifier",
    flashValue()
    )
  return

func flashValue():
    if sprite.material.get_shader_param("flash_modifier")<=0:
      return 0
    else:
      return (sprite.material.get_shader_param("flash_modifier")-0.05)

func _interact(_interactParent : Node) -> void:
  if associatedDialogue:
    SceneManager.start_convo(associatedDialogue, self)
    pass
  if (isEnemy && !walks):
    # TODO: start battle
    pass
  elif (joinsParty):
    if (lifeform in FileMan.data.partyRes):
      SceneManager.start_convo(partyDialogue, self, "party_leave")
    FileMan.add_party(lifeform)
    SceneManager.start_convo(partyDialogue, self)
    collision_layer = collision_layer ^ 4
    hide()
  return
