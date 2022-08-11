tool
extends Interactable

export(Resource) var mapDefinition setget checktype
export(Resource) var diag

var player = null
var _timestamp

onready var anim = $Sprite/Curtain/AnimationPlayer

func _ready() -> void:
  # warning-ignore:return_value_discarded
  SceneManager.connect("target_locked", self, "findPlayer")
  SceneManager.stage_ready(mapDefinition)
  return

func _interact(_interactParent : Node) -> void:
  _timestamp = OS.get_unix_time()
  SceneManager.start_convo(diag, self)
  return

func findPlayer(party : Party) -> void:
  for member in party.get_children():
    if (member is Player):
      player = member
  return

func checktype(given:Resource) -> void:
  if given is MapDefinition:
    mapDefinition = given
  else:
    print("Invalid resource provided.")
  return

func picture() -> void:
  var image = get_viewport().get_texture().get_data()
  var scene = PackedScene.new()
  scene.pack(get_node("../.."))
  FileMan.data.location = scene
  FileMan.data.locationName = mapDefinition.localizedName
  image.flip_y()
  FileMan.data.preview  = image
  anim.play("photo")
  collision_layer = collision_layer ^ 4 #disables collision
  FileMan.data.position = player.global_position
  FileMan.data.playtime += ( OS.get_unix_time() - FileMan.curtime )
  FileMan.curtime = OS.get_unix_time()
  FileMan.save_game()
  return
