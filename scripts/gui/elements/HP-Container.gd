tool

extends Control

onready var def   = $Container/DEFBar
onready var hp    = $Container/HPBar
onready var mana  = $Container/MANABar

onready var chara = $Character

onready var ownr  = $Container

export(Resource) var pointing

func _ready() -> void:
  #warning-ignore:return_value_discarded
  pointing.connect("health_changed", self, "update_stats_shown")
  hp.setup()
  def.setup()
  mana.setup()
  setup()
  return

func update_stats_shown() -> void:
  hp.valbar.value   = pointing.health
  def.valbar.value  = pointing.defense
  mana.valbar.value = pointing.mana
  return

func setup() -> void:
  ownr.texture      = pointing.StatBox
  var atlas         = AtlasTexture.new()
  atlas.atlas       = pointing.inGui
  atlas.region.size = Vector2(24,30)
  chara.texture     = atlas
  return
