extends Position2D
export(String) var location setget set_loc
func set_loc(value):
	$Location/Label.text=value
	$Warp.stage=str(value.to_lower())
	pass
