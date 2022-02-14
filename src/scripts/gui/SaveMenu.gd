extends Control

onready var vbox:=$"Panel/VBoxContainer"
onready var slot1:=$"Panel/VBoxContainer/Slot1"
onready var slot2:=$"Panel/VBoxContainer/Slot2"
onready var slot3:=$"Panel/VBoxContainer/Slot3"

func _ready():
  slot1.get_node("TextureButton").focus_neighbour_bottom = NodePath("../../Slot2/TextureButton") #get_path_to(slot2.get_node("TextureButton"))
  slot2.get_node("TextureButton").focus_neighbour_top    = NodePath("../../Slot1/TextureButton") #get_path_to(slot1.get_node("TextureButton"))
  slot2.get_node("TextureButton").focus_neighbour_bottom = NodePath("../../Slot3/TextureButton") #get_path_to(slot3.get_node("TextureButton"))
  slot3.get_node("TextureButton").focus_neighbour_top    = NodePath("../../Slot2/TextureButton") #get_path_to(slot2.get_node("TextureButton"))
  slot1.get_node("TextureButton").grab_focus()

  var details = FileMan.return_saves_details()
  $Player.volume_db=linear2db(FileMan.settings.bgmvol)
  for i in vbox.get_children().size():
    vbox.get_child(i).setup(TranslationServer.translate("saveEmpty"), "", 0, null, FileMan.get("path%s" % (i+1)))
  $Player.play()
  for i in details: #func setup(namesave, savelocation, amountTime, screenshot):
    get("slot"+i).setup(details[i]["name"], details[i]["location"], details[i]["playtime"], details[i]["preview"], FileMan.get("path%s" % i))

  return

