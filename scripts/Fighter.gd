extends KinematicBody2D

class_name Fighter

export(Resource) var lifeform

onready var sprite = $Sprite

var stats = lifeform.stats

var target_global_position : Vector2

func _ready() -> void:
	sprite.texture = lifeform.battle

func is_able_to_play() -> bool:
	"""
	Returns true if the battler can perform an action
	Currently it only checks that the battler is alive,
	but we should use this method later to check its current status as well
	"""
	return stats.health > 0

func take_damage(_hit) -> void:
	# stats.take_damage(hit)
	#
	# # prevent playing both stagger and death animation if health <= 0
	# if stats.health > 0:
	# 	skin.play_stagger()
	return

func _on_health_depleted() -> void:
	# selectable = false
	# yield(skin.play_death(), "completed")
	return
