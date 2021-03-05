extends Button

enum actions {
	ui_up,
	ui_down,
	ui_left,
	ui_right,
	ui_cancel,
	ui_select,
	ui_accept,
	ui_end,
	sprint,
	atkmed
}

export(actions) var action

func _ready():
	assert(InputMap.has_action(action))
	set_process_unhandled_key_input(false)
	display_current_key()


func _toggled(button_pressed):
	set_process_unhandled_key_input(button_pressed)
	if button_pressed:
		text = "..."
		release_focus()
	else:
		display_current_key()


func _unhandled_key_input(event):
	# Note that you can use the _input callback instead, especially if
	# you want to work with gamepads.
	remap_action_to(event)
	pressed = false


func remap_action_to(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	text = str(event.as_text())


func display_current_key():
	var current_key = InputMap.get_action_list(action)[0].as_text()
	text = str(current_key)
