extends YSort
class_name Party

export(PackedScene) var playerScene
export(PackedScene) var followerScene
# snake overseer variables
"""
var curvefollow = Curve2D.new()
var prev_coord = Vector2.ZERO
var prev_dir
"""
func _ready() -> void:
  #warning-ignore:RETURN_VALUE_DISCARDED
  FileMan.connect("party_updated", self, "clean_party")
  update_party()
  return

func clean_party() -> void:
  if get_child_count():
    FileMan.data.position = get_child(0).global_position #get party pos
    update_party()
  return

func update_party() -> int:
  yield(get_tree(), "idle_frame")
  for every in get_children():
    every.queue_free()
  var p = playerScene.instance()
  add_child(p)
  p.lifeform = FileMan.data.lead
  var _prec = null # this will establish what each other member has to follow
  for Lifeform in FileMan.data.partyRes:
    var f = followerScene.instance()
    add_child(f)
    f.lifeform = Lifeform
    if _prec != null:
      #warning-ignore:RETURN_VALUE_DISCARDED
      _prec.connect("moving", f, "targetSet")
    else:
      #warning-ignore:RETURN_VALUE_DISCARDED
      p.connect("moving", f, "targetSet")
    _prec = f
    f.setup()
  position = FileMan.data.position
  SceneManager.party_ready(self)
  return 0
