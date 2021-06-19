extends Node

var head
var prev_coord = Vector2.ZERO
signal player_chdir
var possible = {
  "Kevin" : load("res://scenes/organs/Kevin.tscn"),
  "Quinton" : load("res://scenes/organs/Quinton.tscn"),
}

func _init():
# warning-ignore:return_value_discarded
  SceneManager.connect("target_locked", self, "define_leader")

func define_leader(leader):
  if leader==null:
    return
  else:
    head = leader
#  for i in FileMan.party:
#    var inst = possible[i].instance()
#    if get_child_count() > 0:
#      inst.snakeTail=true
#      inst.position = head.position
#    add_child(inst)

func _physics_process(_delta):
  if head:
    var dir_changed = false
    if prev_coord != head.position:
      prev_coord = head.position
      dir_changed=true
    if dir_changed:
      var curve = Curve2D.new()
      curve.add_point(head.position)
      emit_signal("player_chdir", curve)
