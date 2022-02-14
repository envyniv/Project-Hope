extends Node
onready var nametag = $ColorRect2/DiagBox/LabelBGSHD/LabelBG/Label
onready var message = $ColorRect2/DiagBox/RichTextLabel
onready var anims = $AnimationPlayer
onready var speak = $Speak
onready var choicelist = $ColorRect2/MarginContainer/Choices
onready var nextshow = $ColorRect2/DiagBox/next
var next : String
onready var timer=$next_char
var _current_dialogue

var txtspd=FileMan.settings.txtspd
var diag_path = "res://scripts/dialogue/%s.json"

#TODO: add signal emitting compliant with LE-Dialogue-Editor specifications
#TODO: add pacing

func _ready():
  set_process_input(false)
  message.set_text("")
  nametag.set_text("")
  speak.volume_db = linear2db(FileMan.settings.sfxvol)
  #warning-ignore:return_value_discarded
  SceneManager.connect("plsStartDialogue", self, "diag_start")

func loadDiag(what) -> int:
  var diag = FileMan.return_file_as_text(what)
  if !diag:
    OS.alert("errDiagMissingStr" % what, "errDiagMissing")
    return 48
  else:
    _current_dialogue = JSON.parse(diag).result
  return 0

func diag_start(diagname) -> int:
  set_process_input(true)
  loadDiag(diag_path % [diagname])
  anims.play("fade-in")
  getNext()
  SceneManager.convo_on()
  return 0

func diagEnd() -> void:
  set_process_input(false)
  message.visible_characters=0
  anims.play_backwards("fade-in")
  message.set_text("")
  nametag.set_text("")
  #emit_signal("diag_ended")
  SceneManager.convo_off()
  return

func readText() -> void:
  timer.wait_time = txtspd
  message.visible_characters = 0
  timer.start()
  return

func setText() -> void:
  if next == "":
    next = _current_dialogue["root"]["next"]
  elif !("next" in _current_dialogue[next]):
    diagEnd()
  # elif "choices" in _current_dialogue[next]:
  #   for i in _current_dialogue[next]["choices"]:
  #     print(i)
  #     var button: Button = Button.new()                                           #     create a button
  #     button.text = i["text"][TranslationServer.get_locale()]            #     give it text
  # #warning-ignore:return_value_discarded
  #     button.connect("pressed", self, "_on_Choice_pressed", [i["next"]]) #     make sure we can actually use it
  #     choicelist.add_child(button)
  else:
    next = _current_dialogue[next]["next"]
    message.text = _current_dialogue[next]["text"][TranslationServer.get_locale()]
    nametag.text        = _current_dialogue[next]["name"]
  return

func getNext() -> void:
  setText()
  readText()
  return

func _on_Choice_pressed(select: String) -> void:
  next = select
  for i in choicelist.get_children():
    i.queue_free()
  set_process_input(true)
  getNext()
  return

func _input(_event) -> void:
  var NEXT=Input.is_action_just_pressed("ui_accept")
  if NEXT:
    if (message.visible_characters < message.text.length() && message.visible_characters > -1):
      timer.stop()
      message.visible_characters=-1
    else:
      nextshow.show()
      getNext()
  return

func _on_next_char_timeout():
  if message.visible_characters >= message.text.length():
    message.visible_characters = -1
    timer.stop()
    return
  else:
    message.visible_characters += 1
    $Speak.pitch_scale=rand_range(0.6, 1)
    $Speak.play()
