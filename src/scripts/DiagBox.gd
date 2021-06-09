extends Node

onready var nametag = $ColorRect2/DiagBox/Label
onready var message = $ColorRect2/DiagBox/RichTextLabel
onready var anims = $AnimationPlayer
onready var next_spr = $ColorRect2/DiagBox/Next
onready var speak = $Speak
var index = 1
onready var timer=$next_char
var json_result
signal diag_started()
signal diag_ended()

func _ready():
  set_process_input(false)
  message.set_text("")
  nametag.set_text("")
  next_spr.hide()
  if FileMan.data.sfxvol != null:
      speak.volume_db = linear2db(FileMan.data.sfxvol)

func diag_start(diagname):
    set_process_input(true)
    anims.play("fade-in")
    var diagpath = "res://scripts/diag/%s/%s.json" % [FileMan.data.lang, diagname]
    var diag = FileMan.return_file(diagpath)
    if !diag:
      print("bruh")
    else:
      json_result = JSON.parse(diag.get_as_text()).result
    print_text();
    read_text();
    emit_signal("diag_started")

func diag_end():
  set_process_input(false)
  message.visible_characters=0
  anims.play_backwards("fade-in")
  message.set_text("")
  nametag.set_text("")
  emit_signal("diag_ended")

func read_text():
    timer.wait_time = 0.075
    message.visible_characters = 0
    timer.start()

func print_text():
    nametag.text = json_result[str(index)]["name"]
    message.bbcode_text = json_result[str(index)]["msg"]
    pass

func _input(_event):
    var NEXT=Input.is_action_just_pressed("ui_accept")
    if NEXT:
        if message.visible_characters!=message.bbcode_text.length() && message.visible_characters!=-1:
            timer.stop()
            message.visible_characters=-1
        elif index==json_result.size():
            diag_end()
        else:
            next()

func next():
    if index <= json_result.size():
        index += 1
        print_text();
        read_text();
    pass

func _on_next_char_timeout():
    var string = message.bbcode_text
    var regex = RegEx.new()
    regex.compile("\\[.*?\\]")
    var string_proc = regex.sub(string, "", true)
    if message.visible_characters >= string_proc.length():
        message.visible_characters = -1
        timer.stop()
        if "special" in json_result[str(index)]:
            print("you should choose")
            pass
        return
    else:
        message.visible_characters += 1
        $Speak.pitch_scale=rand_range(0.6, 1)
        $Speak.play()
    pass
