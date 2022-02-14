extends Control

onready var namelabel = $"Panel/Name"
onready var keyboardgrid = $"Panel/Keyboard"
onready var KBSwitchButton = $Panel/Button
var p = false

func _ready():
  set_process_unhandled_input(false)
  KBSwitchButton.setup()
  for i in keyboardgrid.get_children().size()-3:
    keyboardgrid.get_child(i).connect("cuspressed", self, "type")
#  keyboardgrid.get_node("Button29").connect("pressed", self, "insSpace")
  keyboardgrid.get_node("Button27").connect("pressed", self, "insBck")
  keyboardgrid.get_node("Button28").connect("pressed", self, "OK")
  keyboardgrid.get_child(0).set_focus_mode(Control.FOCUS_ALL)
  keyboardgrid.get_child(0).grab_focus()
  keyboardgrid.get_node("Button28").hide()
  return

func type(cuspressed):
  if namelabel.text.length()<15 :
    namelabel.text+=cuspressed
    keyboardgrid.get_node("Button28").show()
  return

#func insSpace():
#  namelabel.text+=" "

func insBck():
  namelabel.text = namelabel.text.substr(0, namelabel.text.length()-1)
  if namelabel.text.length()==0:
    keyboardgrid.get_node("Button28").hide()

func OK():
  if !("ENVY/NIVAL" in namelabel.text):
    FileMan.data.name=namelabel.text
  #elif "DEBUG" in namelabel.text:
  #  #the funky
  else: #TODO: obfuscate
    FileMan.data.name="[HELLO, THERE.]"
    FileMan.data.kevin["-.-. --- -- ...--"]="[COULD YOU BE THE ONE LOOKING FOR THIS?]"
  SceneManager.change_scene("game")

func _input(_event):
  if Input.is_action_just_pressed("ui_focus_next"):
    for i in keyboardgrid.get_children().size()-3:
      keyboardgrid.get_child(i).disabled=!p
      keyboardgrid.get_child(i).flat=!p
    set_process_unhandled_input(!p)
    p=!p

func _unhandled_input(event):
  if event is InputEventKey:
    if event.pressed:
      if (event.scancode<=90 && event.scancode>=65) || event.scancode==47:
        type(OS.get_scancode_string(event.scancode))
#      elif (event.scancode == 32):
#        insSpace()
      elif (event.scancode == KEY_BACKSPACE):
        insBck()
      elif (event.scancode == KEY_ENTER):
        OK()
