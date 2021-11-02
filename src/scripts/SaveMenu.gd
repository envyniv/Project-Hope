extends Control

onready var vbox:=$"Panel/VBoxContainer"
onready var slot1:=$"Panel/VBoxContainer/Slot1"
onready var slot2:=$"Panel/VBoxContainer/Slot2"
onready var slot3:=$"Panel/VBoxContainer/Slot3"

func _ready():
  var details = FileMan.return_saves_details()
  $Player.volume_db=linear2db(FileMan.settings.bgmvol)
  for i in vbox.get_children().size():
    vbox.get_child(i).setup("Empty", "", 0, null, FileMan.get("path%s" % (i+1)))
  $Player.play()


  for i in details: #func setup(namesave, savelocation, amountTime, screenshot):
    get("slot"+i).setup(details[i]["name"], details[i]["location"], details[i]["playtime"], details[i]["preview"], FileMan.get("path%s" % i))

  return

