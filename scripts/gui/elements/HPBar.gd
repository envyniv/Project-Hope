tool
extends ProgressBar

var hp = 0
var def = 0

onready var icon    = $icon
onready var Current = $icon/Current
onready var Max     = $MAX
onready var valbar  = $ValueBar

export(String, "Health", "Defense", "Mana") var type

export(Color) var lowHealth   = Color(1, 0.16, 0.41, 1)     #ff2869
export(Color) var lowDefense  = Color(0.18, 0.14, 1, 1)     #2f23ff
export(Color) var normHealth  = Color(0.57, 0.95, 0.04, 1)  #92f40b
export(Color) var normDefense = Color(0.43, 0.74, 0.93, 1)  #6dbded
export(Color) var med         = Color(0.96, 0.72, 0.29, 1)  #f5b949
export(Color) var mana        = Color(0.53, 0.13, 1, 1)     #8621ff
export(Resource) var AltCurFont
export(Resource) var AltMaxFont
export(Texture) var icons

var timer=Timer.new()

func _ready() -> void:
  timer.connect("timeout", self, "onUpdValTimerTimeout")
  return

func setup() -> void:
#  hp=FileMan.data.get(target.to_lower())["HP"]
  var atlas = AtlasTexture.new()
  atlas.atlas = icons
  atlas.region.size=Vector2(13,13)
  icon.texture=atlas
  if type == "Defense":
    #change icon
    icon.texture.region.position.x = 13
  elif type == "Mana":
    icon.texture.region.position.x = 26
    valbar.modulate = mana
  if rect_size.y<8:
    #change to small font
    Current.set("custom_fonts/font", AltCurFont)
    Max.set("custom_fonts/font", AltMaxFont)
  return

func _process(_delta):
  if type != "Mana":
    if value<=(max_value/2):
      valbar.modulate=get("med")
    elif value<=(max_value/3):
      valbar.modulate=get("low"+type)
    else:
      valbar.modulate=get("norm"+type)
  valbar.max_value=max_value
  Current.text = str(valbar.value)
  Max.text     = str(valbar.max_value)
  pass

func update_value(n:int) -> void:
  timer.wait_time = 0.125
  timer.autostart = true #timer not added to SceneTree, avoid using start()
  value = n
  valbar.value = n
  return

func onUpdValTimerTimeout() -> void:
  if valbar.value<=value:
    value = valbar.value
    timer.stop()
  else:
    value-=1
  return
