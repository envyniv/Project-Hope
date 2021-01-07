extends Position2D
#onready var location=$Location/Label.text
export(String) var location setget set_loc
func set_loc(location):
	$Location/Label.text=location
	$Warp.stage=str(location)
	pass
