extends NinePatchRect

export(Resource) var pointing setget set_ref

#TODO: un-hardcode all this bullshit
onready var character = $VBoxContainer/TextureRect
onready var level = $VBoxContainer/TextureRect/Level
onready var hpbar = $VBoxContainer/TextureRect/HPBar
onready var defbar = $VBoxContainer/TextureRect/DEFBar
onready var nameLabel = $VBoxContainer/TextureRect/Name
onready var xpLabel = $VBoxContainer/TextureRect/XP

onready var Helm = $VBoxContainer/HBoxContainer/Equip/Buttons/Helm
onready var Armor = $VBoxContainer/HBoxContainer/Equip/Buttons/Armor
onready var Charm = $VBoxContainer/HBoxContainer/Equip/Buttons/Charm

onready var xMANA =$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/xMANA
onready var EVA   = $VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/EVA
#onready var DEF=$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/DEF
onready var ATK   =$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/ATK
onready var LUC   =$VBoxContainer/HBoxContainer/PanelStats/Aligner/Values/LUC

signal exit_menumember
signal iRequireItems

func set_ref(val) -> void:
  #so i can avoid to call setup()
  pointing = val
  setup()
  return

func _ready() -> void:
  hpbar.setup()
  defbar.setup()
  Helm.connect("pressed", self, "helmPressed")
  Armor.connect("pressed", self, "armorPressed")
  Charm.connect("pressed", self, "charmPressed")
  return

func setup() -> void:
  nameLabel.set_text(pointing.localizedName)

  var atlas               = AtlasTexture.new()
  atlas.atlas             = pointing.inGui
  atlas.region.size       = Vector2(24,30)
  atlas.region.position.x = 24
  character.texture       = atlas

  hpbar.update_value( pointing.health )
  hpbar.max_value   = pointing.max_health
  defbar.update_value(pointing.defense)
  defbar.max_value  = pointing.max_defense
  xpLabel.text      = (
                      TranslationServer.translate("statEXP")+": "+
                      str(pointing.experience)+" / "+ #current XP
                      str(pointing.experience) #maxXP
                      )
  level.text        = str(pointing.level)

  xMANA.text = str(pointing.max_mana)
  #DEF.text   = str(pointing.defense)
  ATK.text   = str(pointing.strength)
  LUC.text   = str(pointing.luck)
  EVA.text   = str(pointing.speed)
  return

func _input(_event : InputEvent) -> void:
  if Input.is_action_pressed("ui_cancel"):
    emit_signal("exit_menumember")
  return

func itemReceived(type : String, item : Resource) -> void:
  disconnect("itemSelected", self, "itemReceived")
  pointing.set(type, item)

  return

func helmPressed() -> void:
  emit_signal("iRequireItems", "HELM")
  return

func armorPressed() -> void:
  emit_signal("iRequireItems", "EQUIP")
  return

func charmPressed() -> void:
  emit_signal("iRequireItems", "ACCESSORY")
  return
