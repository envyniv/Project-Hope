extends Control

onready var g         = $Label
onready var time      = $Time

func _process(_delta):
  g.text = str(FileMan.data.money) + " G"
  time.text=str(OS.get_time()["hour"],":",OS.get_time()["minute"])
