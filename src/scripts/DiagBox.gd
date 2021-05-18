extends Node

onready var nametag = $ColorRect2/DiagBox/Label
onready var message = $ColorRect2/DiagBox/RichTextLabel
onready var anims = $AnimationPlayer
onready var next_spr = $ColorRect2/DiagBox/Next
onready var speak = $Speak
var file = File.new()
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
    if "sfxvol" in SaveLoad.data["settings"]:
        speak.volume_db = linear2db(float(SaveLoad.data["settings"]["sfxvol"]))

func diag_start(diagname):
    set_process_input(true)
    anims.play("fade-in")
    var diagpath = "res://scripts/diag/%s/%s.json" % [SaveLoad.data["settings"]["lang"], diagname]
    if file.file_exists(diagpath):
        file.open(diagpath, file.READ)
        var json = file.get_as_text()
        json_result = JSON.parse(json).result
        print_text();
        read_text();
        emit_signal("diag_started")
        file.close()
    else:
        nametag.set_text("System")
        message.set_text("ERROR: DIALOGUE %s MISSING; \nISSUE IMMEDIATELY" % [diagname])

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
