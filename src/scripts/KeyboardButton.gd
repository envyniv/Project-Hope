extends Button

signal cuspressed

func _ready():
  # warning-ignore:return_value_discarded
  connect("pressed", self, "onpressed")

func onpressed():
  emit_signal("cuspressed", text)
