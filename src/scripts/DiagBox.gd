extends Node
onready var nametag = $ColorRect2/DiagBox/LabelBGSHD/LabelBG/Label
onready var message = $ColorRect2/DiagBox/RichTextLabel
onready var anims = $AnimationPlayer
onready var speak = $Speak
onready var choicelist = $ColorRect2/MarginContainer/Choices
onready var nextshow = $ColorRect2/DiagBox/next
var next : String
onready var timer=$next_char
var json_result

#TODO: add signal emitting compliant with LE-Dialogue-Editor specifications
#TODO: add pacing

func _ready():
  set_process_input(false)
  message.set_text("")
  nametag.set_text("")
  if FileMan.data.sfxvol != null:
    speak.volume_db = linear2db(FileMan.data.sfxvol)
  SceneManager.connect("plsStartDialogue", self, "diag_start")

func diag_start(diagname):
  set_process_input(true)
  anims.play("fade-in")
  var diagpath = "res://dialogue/%s.json" % [diagname]
  var diag = FileMan.return_file_as_text(diagpath)
  if !diag:
    OS.alert("The dialogue named "+diagname+" wasn't found!\nIf you've got nothing to do with this, please report!", "Dialogue file missing")
    return
  else:
    json_result = JSON.parse(diag).result
  get_text()
  read_text();
  SceneManager.convo_on()

func diag_end():
  set_process_input(false)
  message.visible_characters=0
  anims.play_backwards("fade-in")
  message.set_text("")
  nametag.set_text("")
  #emit_signal("diag_ended")
  SceneManager.convo_off()

func read_text():
  timer.wait_time = 0.075
  message.visible_characters = 0
  timer.start()

func get_text():
  if next=="":
    next=json_result["root"]["next"]
  message.bbcode_text = json_result[next]["text"][TranslationServer.get_locale()]
  nametag.text        = json_result[next]["name"]

func _on_Choice_pressed(select: String) -> void:
  next=select
  for i in choicelist.get_children():
    i.queue_free()
  set_process_input(true)
  get_text()
  read_text()

func _input(_event):
  var NEXT=Input.is_action_just_pressed("ui_accept")
  if "choices" in json_result[next]:
    var choices = json_result[next]["choices"]
    for i in choices.size():
      var button: Button = Button.new()
      button.text = choices[i]["text"][TranslationServer.get_locale()]
      button.connect("pressed", self, "_on_Choice_pressed", [choices[i]["next"]])
      choicelist.add_child(button)
    choicelist.get_child(0).set_focus_mode(Control.FOCUS_ALL)
    set_process_input(false)
    choicelist.get_child(0).grab_focus()
  else:
    if NEXT:
      if message.visible_characters!=message.bbcode_text.length() && message.visible_characters!=-1:
        timer.stop()
        message.visible_characters=-1
  #    elif index==json_result.size():
      elif !("next" in json_result[next]):
        nextshow.hide()
        diag_end()
      else:
        nextshow.show()
        get_next()

func get_next():
  next = json_result[next]["next"]
  get_text()
  read_text()

func _on_next_char_timeout():
  var string = message.bbcode_text
  var regex = RegEx.new()
  regex.compile("\\[.*?\\]")
  var string_proc = regex.sub(string, "", true)
  if message.visible_characters >= string_proc.length():
    message.visible_characters = -1
    timer.stop()
    return
  else:
    message.visible_characters += 1
    $Speak.pitch_scale=rand_range(0.6, 1)
    $Speak.play()
