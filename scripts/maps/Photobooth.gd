tool
class_name Photobooth extends Interactable

export(String) var localizedName
export(AudioStream) var bgm
export(float) var windStrength
export(Color) var vegetation

export(Resource) var diag

export(NodePath) var musicPlayer
export(NodePath) var anim

var player = null
var _timestamp

func _ready() -> void:
  if anim:
    anim = get_node(anim)
  if musicPlayer:
    musicPlayer = get_node(musicPlayer)
    musicPlayer.stream = bgm
    musicPlayer.play()
  # warning-ignore:return_value_discarded
  SceneManager.connect("ready_player", self, "playerFound")
  return

func _interact(_interactParent : Node) -> void:
  _timestamp = OS.get_unix_time()
  SceneManager.start_convo(diag, self)
  return

func playerFound(p) -> void:
  player = p
  return

func picture() -> void:
  var image = get_viewport().get_texture().get_data()
  var scene = PackedScene.new()
  scene.pack(get_node("../.."))
  FileMan.data.location = scene
  FileMan.data.locationName = localizedName
  image.flip_y()
  FileMan.data.preview  = image
  anim.play("photo")
  collision_layer = collision_layer ^ 4 #disables collision
  FileMan.data.position = player.global_position
  FileMan.data.playtime += ( OS.get_unix_time() - FileMan.curtime )
  FileMan.curtime = OS.get_unix_time()
  FileMan.save_game()
  return
