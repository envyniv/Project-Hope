extends Node

var entitylist={
"kevin":load("res://scenes/Player.tscn"),
"dummy":load("res://scenes/dummy.tscn")
}


func _enter_tree():
    $YSort.add_child(entitylist[SaveLoad.inBattle[true]].instance())
    print_tree()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
