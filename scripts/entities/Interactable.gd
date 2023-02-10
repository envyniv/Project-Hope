extends StaticBody2D
class_name Interactable

onready var flashTimer = null
onready var sprite     = $Sprite

func _ready() -> void:
  flashTimer=Timer.new()
  add_child(flashTimer)
  flashTimer.wait_time=0.05

  flashTimer.connect("timeout", self, "onFlashTimeout")
  return

func can_interact(interactParent : Node) -> bool:
  if (interactParent is Player):
    flash()
    return true
  return false


func _interact(_interactParent : Node) -> void:
  #To Replace in any object
  return

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
#  originally pulsed, but i couldn't quickly figure out a way to stop it from
#  pulsing when player wasn't close, so i just gave up
    #return 1
    return 0
  else:
   return (sprite.material.get_shader_param("flash_modifier")-0.05)
