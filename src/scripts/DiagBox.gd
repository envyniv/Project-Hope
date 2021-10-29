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
  speak.volume_db = linear2db(FileMan.settings.sfxvol)
  #warning-ignore:return_value_discarded
  SceneManager.connect("plsStartDialogue", self, "diag_start")

func diag_start(diagname):
  set_process_input(true)
  anims.play("fade-in")
  var diagpath = "res://dialogue/%s.json" % [diagname]
  var diag = FileMan.return_file_as_text(diagpath)
  if !diag:
    OS.alert("The dialogue named "+diagname+" wasn't found!\nIf you've got nothing to do with this, please report!", "Dialogue file missing")
    return 48
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

func read_text() -> void:
  timer.wait_time = 0.050
  message.visible_characters = 0
  timer.start()
  return

func get_text() -> void:
  if next=="":
    next=json_result["root"]["next"]
  message.bbcode_text = json_result[next]["text"][TranslationServer.get_locale()]
  nametag.text        = json_result[next]["name"]
  return

func get_next() -> void:
  next = json_result[next]["next"]
  get_text()
  read_text()
  return

func _on_Choice_pressed(select: String) -> void:
  next=select
  for i in choicelist.get_children():
    i.queue_free()
  set_process_input(true)
  get_text()
  read_text()
  return

func _input(_event) -> void:
  var NEXT=Input.is_action_just_pressed("ui_accept")                                # obligatory needed buttons declaration
  if NEXT:                                                                          # when NEXT is pressed
    if (message.visible_characters!=message.bbcode_text.length() && message.visible_characters!=-1):
      timer.stop()
      message.visible_characters=-1
    elif "choices" in json_result[next]:                                              # if there are multiple dialogue branches ------------------
      var choices = json_result[next]["choices"]                                    #   get them
      for i in choices.size():                                                      #   for each one
        var button: Button = Button.new()                                           #     create a button
        button.text = choices[i]["text"][TranslationServer.get_locale()]            #     give it text
        #warning-ignore:return_value_discarded
        button.connect("pressed", self, "_on_Choice_pressed", [choices[i]["next"]]) #     make sure we can actually use it
        choicelist.add_child(button)                                                #     add it to the list
      choicelist.get_child(0).set_focus_mode(Control.FOCUS_ALL)                     #   the first button, focus it.
      set_process_input(false)                                                      #   don't let the text box eat up inputs
      choicelist.get_child(0).grab_focus()                                          #    (see line 84)
    elif !("next" in json_result[next]):
      nextshow.hide()
      diag_end()
    else:
      nextshow.show()
      get_next()
  return

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

func _emit_dialogue_signal(signals: Dictionary) -> void:
  for key in signals:
    if !(signals[key] is Dictionary):
      if signals[key] == null:
        emit_signal(key)
        continue
      emit_signal(key, signals[key])
      continue

    var multi_values_signal: Dictionary = signals[key]
    for type in multi_values_signal:
      var value = _convert_value_to_type(type, multi_values_signal[type])
      emit_signal(key, value)

func _convert_value_to_type(type: String, value):
  match type:
    "Vector2":
      return Vector2(value["x"], value["y"])
  return value
