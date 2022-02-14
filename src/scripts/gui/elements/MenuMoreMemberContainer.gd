extends Control

onready var nameLabel = $Clickable/NameLabel
onready var xpLabel   = $Clickable/XP
onready var hpbar = $HPBar
onready var defbar = $DEFBar

onready var character = $TextureRect
onready var level = $TextureRect/Level

onready var button = $Clickable

export(String, "kevin", "quinton", "charlie", "bella") var who

signal partymember_selected

func _process(_delta) -> void:
  #i can probably do this some other way that i don't know of yet
  var whodata = FileMan.data.get(who)
  if button.is_hovered() || button.has_focus():
    xpLabel.set("custom_colors/font_color", Color(0, 0, 0, 1))
    nameLabel.set("custom_colors/font_color", Color(0, 0, 0, 1))
  else:
    xpLabel.set("custom_colors/font_color", Color(1, 1, 1, 1))
    nameLabel.set("custom_colors/font_color", Color(1, 1, 1, 1))
  hpbar.update_value(whodata["HP"])
  hpbar.max_value=whodata["maxHP"]
  defbar.update_value(whodata["DEF"])
  defbar.max_value=whodata["maxDEF"]
  xpLabel.text = TranslationServer.translate("statEXP")+": "+str(whodata["EXP"])+" / "+str(whodata["nextEXP"])
  level.text=str(whodata["LVL"])
  return

func _ready() -> void:
  hpbar.setup()
  defbar.setup()
  button.connect("pressed", self, "onButton")
  nameLabel.text=TranslationServer.translate("char"+who)
  
  #redundant setup to avoid region sharing between nodes
  var atlas = AtlasTexture.new()
  atlas.atlas = load("res://assets/gui/menu-party.png")
  atlas.region.size=Vector2(25,34)
  character.texture=atlas
  
  match who:
    "quinton":
      character.texture.region.position.x=25
    "charlie":
      character.texture.region.position.x=75
    "bella":
      character.texture.region.position.x=50
  return

func onButton() -> void:
  emit_signal("partymember_selected", who)
  return
