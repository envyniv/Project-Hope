extends Node
signal clean_done()
const stages={
	'meteora': preload("res://scenes/stage/Meteora.tscn"),
	'battle':preload("res://scenes/stage/Battle-World.tscn"),
	'map':preload("res://scenes/stage/world-map.tscn"),
}


func swap_stage(stage):
	var chosen
	if stages.has(stage):
		chosen=stages.get(stage)
		pass
	SceneChanger.transition(0)
	add_child(chosen.instance())
	pass

func _ready():
	set_player_spawn()
	pass

func set_player_spawn():
	if $Stage/PlayerSpawn:
		$YSort/Player.position=$Stage/PlayerSpawn.position
	pass
