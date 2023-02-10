tool
class_name SpriteAutoOffset extends Sprite

enum ALIGN {
  TOP,
  BOTTOM,
  LEFT,
  RIGHT
 }

export(ALIGN) var align = 1

func _ready() -> void:
  centered = false
  connect("texture_changed", self, "setup")
  setup()
  return
  
func setup() -> void:
  match align:
    ALIGN.BOTTOM:
      offset.y = -texture.get_height()
      if centered:
        offset.y /= 2
      else:
        offset.x = -(texture.get_width()/hframes)/2
        
  return
