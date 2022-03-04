extends Node
onready var nametag    = $ColorRect2/DiagBox/LabelBGSHD/LabelBG/Label
onready var message    = $ColorRect2/DiagBox/RichTextLabel
onready var anims      = $AnimationPlayer
onready var speak      = $Speak
onready var choicelist = $ColorRect2/MarginContainer/Choices
onready var nextshow   = $ColorRect2/DiagBox/next
onready var timer      = $next_char

var _current_dialogue  : Dictionary    # this will contain the full dialogue
var _cursor            : String = "0_1" # this is a cursor
var _current_node      : Dictionary    # this will indicate which node we are in

var options            : Array = []

var txtspd    = FileMan.settings.txtspd
var diag_path = "res://localization/%s/%s.json"

signal dialogue_request

func _ready() -> void:
  set_process_input(false)
  message.set_text("")
  nametag.set_text("")
  speak.volume_db = linear2db(FileMan.settings.sfxvol)
  #warning-ignore:return_value_discarded
  SceneManager.connect("plsStartDialogue", self, "diagStart")
  return

func loadDiag(what) -> int:
  var diag = FileMan.return_file_as_text(what)
  if !diag:
    OS.alert("errDiagMissingStr" % what, "errDiagMissing")
    return 48
  else:
    _current_dialogue = JSON.parse(diag).result
  return 0

func diagStart(diagname) -> int:
  set_process_input(true)
  #warning-ignore:return_value_discarded
  loadDiag(diag_path % [TranslationServer.get_locale(), diagname])
  anims.play("fade-in")
  _current_node = _current_dialogue[_cursor]
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
  message.set_text(_current_node["dialogue"])
  nametag.set_text(_current_node["speaker"])
  return

func getNext() -> void:
  if "options" in _current_node:
    if _current_node["options"].size()>1:
      for every in  _current_node["options"]:
        var button: Button = Button.new()
        choicelist.add_child(button)
        button.set_text(_current_node["options"][every]["text"])
        #warning-ignore:return_value_discarded
        button.connect(
        "pressed",
        self,
        "_on_Choice_pressed",
        [ #arguments to encase in array
          _current_node["options"][every]["link"]
        ]
        )
      choicelist.get_child(0).grab_focus()
    else:
      _cursor = _current_node["options"]["0"]["link"]
  elif "signalValue" in _current_node:
    emit_signal("dialogue_request", _current_node["signalValue"])
    _cursor = _current_node["link"]
  elif "operator" in _current_node:
    #condition node
    match _current_node["operator"]:
      0:
        #equals
        if get(_current_node["value1"]) == _current_node["value2"]:
          conditionTrueCursorSet()
        else:
          conditionFalseCursorSet()
      1:
        #isn't
        if get(_current_node["value1"]) != _current_node["value2"]:
          conditionTrueCursorSet()
        else:
          conditionFalseCursorSet()
      2:
        #more than
        if get(_current_node["value1"]) > _current_node["value2"]:
          conditionTrueCursorSet()
        else:
          conditionFalseCursorSet()
      3:
        #less than
        if get(_current_node["value1"]) < _current_node["value2"]:
          conditionTrueCursorSet()
        else:
          conditionFalseCursorSet()
      4:
        #more or equals
        if get(_current_node["value1"]) >= _current_node["value2"]:
          conditionTrueCursorSet()
        else:
          conditionFalseCursorSet()
      5:
        #less or equals
        if get(_current_node["value1"]) <= _current_node["value2"]:
          conditionTrueCursorSet()
        else:
          conditionFalseCursorSet()
  elif "type" in _current_node:
    _cursor = _current_node["link"]
    #set node
    match _current_node["type"]:
      0:
        #assign
        set(_current_node["variable"], _current_node["value"])
      1:
        #add
        set(
        _current_node["variable"],
        get(_current_node["variable"]) + _current_node["value"]
        )
      2:
        #subtract
        set(
        _current_node["variable"],
        get(_current_node["variable"]) - _current_node["value"]
        )
      3:
        #multiply
        set(
        _current_node["variable"],
        get(_current_node["variable"]) * _current_node["value"]
        )
      4:
        #divide
        set(
        _current_node["variable"],
        get(_current_node["variable"]) / _current_node["value"]
        )
  else:
    _cursor = _current_node["link"]
  if _cursor == "END":
    diagEnd()
  else:
    _current_node = _current_dialogue[_cursor]
    if "dialogue" in _current_node:
      setText()
      readText()
    else:
      getNext()
  return

func conditionTrueCursorSet() -> void:
  _cursor = _current_node["true"]
  return

func conditionFalseCursorSet() -> void:
  _cursor = _current_node["false"]
  return

func _on_Choice_pressed(select: String) -> void:
  _cursor = select
  for choice in choicelist.get_children():
    choice.disconnect("pressed", self, "_on_Choice_pressed")
    choice.queue_free()
  set_process_input(true)
  getNext()
  return

func _input(_event) -> void:
  var NEXT=Input.is_action_just_pressed("ui_accept")
  if NEXT:
    if (
      message.visible_characters < message.text.length() &&
      message.visible_characters != -1
    ):
      timer.stop()
      message.visible_characters=-1
    else:
      nextshow.show()
      getNext()
  return

func _on_next_char_timeout() -> void:
  if message.visible_characters >= message.text.length():
    message.visible_characters = -1
    timer.stop()
  else:
    match message.text[message.visible_characters]:
      ".":
        timer.wait_time = txtspd*3
      ",":
        timer.wait_time = txtspd*1.5
      "?":
        timer.wait_time = txtspd*2
      _:
        timer.wait_time = txtspd
    message.visible_characters += 1
    speak.pitch_scale=rand_range(0.6, 1)
    speak.play()
  return
