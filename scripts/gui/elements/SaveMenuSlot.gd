extends Control
onready var savename: Node = $SlotContainer/SaveName
onready var location: Node = $SlotContainer/LocationName
onready var playtime: Node = $SlotContainer/Playtime
onready var preview : Node = $SlotContainer/PreviewPanel/TextureRect
onready var texbut  : Node = $SlotContainer/TextureButton

export(Resource) var pointing : Resource setget setup

func getSaveName(savnm: String) -> String:
  if savnm == "":
    return TranslationServer.translate("saveEmpty").to_upper()
  return TranslationServer.translate(savnm).to_upper()

func setup(pointTo) -> void:
  var tex       = ImageTexture.new()
  savename.text = getSaveName(pointTo.name)
  location.text = pointTo.locationName
  if pointTo.playtime < 600: #less than 10m playtime
    playtime.text = str(round(pointTo.playtime/3600),":0",round(pointTo.playtime/60))
  else:
    playtime.text = str(round(pointTo.playtime/3600),":",round(pointTo.playtime/60))

  print(pointTo.preview.is_empty())
  if !pointTo.preview.is_empty() : #if image is blank?
    tex.create_from_image(pointTo.preview)
    preview.get_parent().show()
    preview.texture = tex
  pointing = pointTo
  return


# HACK: this exists because the focused texture doesn't stop displaying when the button is pressed.
func _on_TextureButton_focus_entered():
  texbut.texture_normal = load("res://assets/gui/buttons/Cursor.png")
func _on_TextureButton_focus_exited():
  texbut.texture_normal = load("res://assets/gui/buttons/blank_button.png")
