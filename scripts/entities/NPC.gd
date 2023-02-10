tool
class_name NPC extends CurveFollower

var met_player := 0 #number of times NPC has been interacted with

var isEnemy := false

var associatedDialogue
var walks

#how far away an enemy can sense you/walk to
var perception : float

onready var flashTimer = null

func primePath() -> void: #give indications to the path
  return

func _set(property: String, val) -> bool:
  match property:
    "Enemy":
      isEnemy = val
    "walksAlong":
      walks = val
    _:
      return false
  property_list_changed_notify()
  return true

func _get(prop: String):
  match prop:
    "Enemy":
      return isEnemy
    "walksAlong":
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
  if lifeform: # if we have battle sprites and we're not gonna join the team
    properties.append({
      "name" : "Enemy",
      "type" : TYPE_BOOL
    })
  if isEnemy:
    properties.append({
      "name" : "perceptionRange",
      "type" : TYPE_REAL
    })
  properties.append({
    "name" : "walksAlongPath",
    "type" : TYPE_NODE_PATH
  })
  return properties

func _ready() -> void:
  if walks:
    walks = get_node(walks)
    curvefollow = walks.curve
#    walks.connect("ready", self, "primePath")

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
  return


# TODO:
# - method that makes npc move towards the party lead when joining the team, like the cardStack in Party.gd
