tool
extends NinePatchRect

export(Resource) var pointing setget set_ref

# all this bullshit is to avoid something breaking whenever i move nodes around

export(NodePath) var character
export(NodePath) var level
export(NodePath) var hpbar
export(NodePath) var defbar
export(NodePath) var nameLabel
export(NodePath) var xpLabel

export(NodePath) var Helm
export(NodePath) var Armor
export(NodePath) var Charm

export(NodePath) var xMANA
export(NodePath) var EVA
export(NodePath) var ATK
export(NodePath) var LUC

signal exit_menumember
signal iRequireItems

func set_ref(val) -> void:
  #so i can avoid to call setup()
  pointing = val
  setup()
  return

func _ready() -> void:
  grabNodes()
  hpbar.setup()
  defbar.setup()
  Helm.connect("pressed", self, "helmPressed")
  Armor.connect("pressed", self, "armorPressed")
  Charm.connect("pressed", self, "charmPressed")
  return

func grabNodes() -> void:
  character = get_node(character)
  level = get_node(level)
  hpbar = get_node(hpbar)
  defbar = get_node(defbar)
  nameLabel = get_node(nameLabel)
  xpLabel = get_node(xpLabel)

  Helm = get_node(Helm)
  Armor = get_node(Armor)
  Charm = get_node(Charm)

  xMANA = get_node(xMANA)
  EVA = get_node(EVA)
  ATK = get_node(ATK)
  LUC = get_node(LUC)
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
