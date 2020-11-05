extends Node
class_name CameraLimits, "res://scenes/icons/photo.png"
onready var topleftspr=$TopLeft/Sprite;
onready var bottomrightspr=$BottomRight/Sprite;

func _ready():
	topleftspr.hide();
	bottomrightspr.hide();
	pass 
