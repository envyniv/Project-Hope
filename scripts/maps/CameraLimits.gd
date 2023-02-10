class_name CameraLimits extends ReferenceRect

func _ready() -> void:
  SceneManager.registerCameraLimits(self)
  return
