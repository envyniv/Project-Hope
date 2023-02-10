extends Path2D
class_name Path2DRandom

signal RDMREADY

func _ready() -> void:
  emit_signal("RDMREADY")
  for i in 10:
    pass
    # curve.add_point()
  return