extends Control

onready var nameLabel = $Clickable/NameLabel
onready var xpLabel   = $Clickable/XP
onready var hpbar     = $HPBar
onready var defbar    = $DEFBar

onready var character = $TextureRect
onready var level     = $TextureRect/Level

onready var button    = $Clickable

export(Resource) var pointing

signal partymember_selected

func _process(_delta) -> void:
  if button.is_hovered() || button.has_focus():
    xpLabel.set("custom_colors/font_color", Color(0, 0, 0, 1))
    nameLabel.set("custom_colors/font_color", Color(0, 0, 0, 1))
  else:
    xpLabel.set("custom_colors/font_color", Color(1, 1, 1, 1))
    nameLabel.set("custom_colors/font_color", Color(1, 1, 1, 1))
  return

func _ready() -> void:
  hpbar.setup()
  defbar.setup()
  button.connect("pressed", self, "onButton")
  #redundant setup to avoid region sharing between nodes
  var atlas = AtlasTexture.new()
  atlas.atlas = pointing.inGui
  atlas.region.size=Vector2(24,30)
  character.texture=atlas

  setup()
  return

func onButton() -> void:
  emit_signal("partymember_selected", pointing)
  return

func setup() -> void:
  nameLabel.set_text(pointing.localizedName)
  hpbar.update_value(pointing.health)
  hpbar.max_value   = pointing.max_health
  defbar.update_value(pointing.defense)
  defbar.max_value  = pointing.max_defense
  xpLabel.text      = (
                      TranslationServer.translate("statEXP")+": "+
                      str(pointing.experience)+" / "+ #current XP
                      str(pointing.experience) #maxXP
                      )
  level.text        = str(pointing.level)
  return
