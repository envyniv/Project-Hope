#TODO: implement speed change, following Dialogue Manager's implementation

extends Node
onready var namelabel     = $ColorRect2/DiagBox/LabelBGSHD
onready var nametag       = $ColorRect2/DiagBox/LabelBGSHD/LabelBG/Label
onready var message       = $ColorRect2/DiagBox/RichTextLabel
onready var anims         = $AnimationPlayer
onready var speak         = $Speak
onready var choicelist    = $ColorRect2/GPanel/Choices
onready var choicepanel   = $ColorRect2/GPanel
onready var nextshow      = $ColorRect2/DiagBox/next
onready var diagbox       = $ColorRect2/DiagBox
onready var timer         = $next_char
onready var cursor        = $ColorRect2/GPanel/Cursor

var _cur_diag: DialogueResource
var _cur_line: Dictionary
var txtspd   = FileMan.settings.txtspd
var pause

export(Texture) var noSpeaker
export(Texture) var normal
signal option_picked

func _ready() -> void:
  choicepanel.hide()
  set_process_input(false)
  cursor.set_process_input(false)
  message.set_text("")
  nametag.set_text("")
  speak.volume_db = linear2db(FileMan.settings.sfxvol)
  #warning-ignore:return_value_discarded
  SceneManager.connect("startDialogue", self, "diagStart")
  timer.connect("timeout", self, "_on_next_char_timeout")
  return

func diagStart(dialogue: Resource, requester: Node, startOverride: String) -> void:
  if !(dialogue is DialogueResource):
    print("Wrong resource provided as dialogue.")
    return
  DialogueManager.game_states = [requester]
  _cur_diag = dialogue
  if startOverride.empty():
    _cur_line = yield(dialogue.get_next_dialogue_line("start"), "completed")
  else:
    _cur_line = yield(dialogue.get_next_dialogue_line(startOverride), "completed")
  anims.play("fade-in")
  readText()
  set_process_input(true)
  SceneManager.pDisableInput()
  return

func readText() -> void:
  if not _cur_line:
    diagEnd()
    return
  message.set_text(_cur_line.dialogue)
  nametag.set_text(_cur_line.character)
  if (_cur_line.character == ""):
    diagbox.texture = noSpeaker
    namelabel.hide()
  else:
    diagbox.texture = normal
    namelabel.show()
  timer.wait_time = txtspd
  message.visible_characters = 0
  timer.start()
  return

func getNext() -> void:
  _cur_line = yield(
    DialogueManager.get_next_dialogue_line(
      _cur_line.next_id,
      _cur_diag
      ),
    "completed"
    )
  readText()
  print(_cur_line)
  #if "pauses" in _cur_line:
  #  print("PAUSES: ", _cur_line.pauses)
  #if "speeds" in _cur_line:
  #  print("SPEEDS: ", _cur_line.speeds)
  return

func _input(_event) -> void:
  var NEXT = Input.is_action_just_pressed("ui_accept")

  if NEXT:
    if !(_cur_line.responses.empty()): #if responses
      set_process_input(false)
      for every in  _cur_line.responses.size():
        var button: Button = Button.new()
        choicelist.add_child(button)
        button.align = 2 #align text to the right
        button.set_text(_cur_line.responses[every].prompt)
        #warning-ignore:return_value_discarded
        button.connect(
        "pressed", self, "_on_Choice_pressed",
        [_cur_line.responses[every].next_id, every]
        )
        choicepanel.show()
        cursor.set_process_input(true)
      return
    getNext()

  return

func _on_Choice_pressed(select: String, option_number: int) -> void:
  choicepanel.hide()
  emit_signal("option_picked", option_number)
  for choice in choicelist.get_children():
    choice.disconnect("pressed", self, "_on_Choice_pressed")
    choice.queue_free()
  _cur_line = yield(
    DialogueManager.get_next_dialogue_line(
      select,
      _cur_diag
      ),
    "completed"
    )
  readText()
  set_process_input(true)
  return

func diagEnd() -> void:
  set_process_input(false)
  message.visible_characters=0
  anims.play_backwards("fade-in")
  message.set_text("")
  nametag.set_text("")
  #emit_signal("diag_ended")
  SceneManager.pEnableInput()
  return

func _on_next_char_timeout() -> void:
  if message.visible_characters >= message.text.length():
    message.visible_characters = -1
    timer.stop()
    # TODO:
    #if ("time" in _cur_line && _cur_line.time == "auto"):
    #  getNext()
  else:
    message.visible_characters += 1
    speak.pitch_scale = rand_range(0.6, 1)
    speak.play()
    if message.visible_characters in _cur_line.pauses:
      timer.wait_time = txtspd+(_cur_line.pauses[message.visible_characters])
    #if message.visible_characters in _cur_line.speeds:
    #  timer.wait_time = txtspd+(_cur_line.speeds[message.visible_characters])

  return
