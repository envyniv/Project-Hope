extends Button

export(String,
  "ui_up",
  "ui_down",
  "ui_left",
  "ui_right",
  "ui_cancel",
  "ui_select",
  "ui_accept",
  "ui_end",
  "sprint",
  "defend",
  "ui_focus_next"
  ) var action

func setup() -> void:
  set_process_unhandled_key_input(false)
  display_current_key()
  return

func _toggled(button_pressed) -> void:
  set_process_unhandled_key_input(button_pressed)
  if button_pressed:
    text = "..."
    release_focus()
  else:
    display_current_key()
  return


func _unhandled_key_input(event) -> void:
  # Note that you can use the _input callback instead, especially if
  # you want to work with gamepads.
  if event is InputEventKey:
    remap_action_to(event)
  pressed = false
  return


func remap_action_to(event) -> void:
  InputMap.action_erase_events(action)
  InputMap.action_add_event(action, event)
  text = str(event.as_text())
  FileMan.settings.controls["keyboard"][action]=event.scancode
  #controls={"keyboard":{"ui_up":16777232}}  ????
  return

func display_current_key() -> void:
  var current_key = InputMap.get_action_list(action)[0].as_text()
  text = str(current_key)
  return
