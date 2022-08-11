extends Resource
class_name Lifeform

export(Texture) var overworld
export(Texture) var battle
export(Texture) var inGui
export(Texture) var StatBox

export(String) var localizedName

export(Array, Resource) var canUseSkills

export(Resource) var growthStats

# equipped items - not implemented in save files so i can reuse assets better :)
export(Resource) var EQUIP
export(Resource) var ACCESSORY
export(Resource) var HELM

signal health_changed(new_health, old_health)
signal health_depleted

signal mana_changed(new_mana, old_mana)
signal mana_depleted

var modifiers = {}

var health : int
var mana : int setget set_mana
var defense : int
export(int) var max_health setget set_max_health
export(int) var max_mana setget set_max_mana
export(int) var strength
export(int) var max_defense setget set_max_defense
export(int) var speed
export(int) var luck
var is_alive : bool
export(int) var experience setget _set_experience
var level: int = 1

func full_heal() -> void:
  health  = max_health
  mana    = max_mana
  defense = max_defense
  return

func set_max_health(value) -> void:
  max_health = max(0, value)
  health = max_health
  return

func set_max_mana(value) -> void:
  max_mana = max(0, value)
  mana = max_mana
  return

func set_max_defense(value) -> void:
  max_defense = max(0, value)
  defense = max_defense
  return

func take_damage(hit) -> void:
  var old_health = health
  health -= hit.damage
  #warning-ignore: NARROWING_CONVERSION
  health = max(0, health)
  emit_signal("health_changed", health, old_health)
  if health == 0:
    emit_signal("health_depleted")
  return

func set_mana(value) -> void:
  var old_mana = mana
  #warning-ignore: NARROWING_CONVERSION
  mana = max(0, value)
  emit_signal("mana_changed", mana, old_mana)
  if mana == 0:
    emit_signal("mana_depleted")
  return

func heal(amount) -> void:
  var old_health = health
  health += amount
  #warning-ignore: NARROWING_CONVERSION
  health = max(health, max_health)
  emit_signal("health_changed", health, old_health)
  return

func add_modifier(id, modifier) -> void:
  modifiers[id] = modifier
  return

func remove_modifier(id) -> void:
  modifiers.erase(id)
  return

func _set_experience(value) -> void:
  experience = max(0, value)
  return
