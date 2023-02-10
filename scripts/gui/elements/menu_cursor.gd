extends TextureRect

export var menu_parent_path : NodePath
export var cursor_offset : Vector2

onready var menu_parent := get_node(menu_parent_path)

var cursor_index : int = 0

onready var timer = $Timer

func ready() -> void:
  set_process_input(false)
  timer.connect("timeout", self, "onTimerTimeout")
  timer.start()
  return

func onTimerTimeout() -> void:
  if $Sprite.texture.region.x >= 30:
    $Sprite.texture.region.x = 0
  else:
    $Sprite.texture.region.x += 10
  return

func _input(_event) -> void:
  var input := Vector2.ZERO

  if Input.is_action_just_pressed("ui_up"):
    $move.play()
    input.y -= 1
  if Input.is_action_just_pressed("ui_down"):
    $move.play()
    input.y += 1
  if Input.is_action_just_pressed("ui_left"):
    $move.play()
    input.x -= 1
  if Input.is_action_just_pressed("ui_right"):
    $move.play()
    input.x += 1

  if menu_parent is VBoxContainer:
    setCursorFromIndex(cursor_index + input.y)
  elif menu_parent is HBoxContainer:
    setCursorFromIndex(cursor_index + input.x)
  elif menu_parent is GridContainer:
    setCursorFromIndex(cursor_index + input.x + input.y * menu_parent.columns)

  if Input.is_action_just_pressed("ui_accept"):
    $select.play()
    var current_menu_item := getMenuItemAtIndex(cursor_index)

    if current_menu_item is Button:
      set_process_input(false)
      current_menu_item.emit_signal("pressed")
  return

func getMenuItemAtIndex(index : int) -> Control:
  if menu_parent == null:
    return null
  if index >= menu_parent.get_child_count() or index < 0:
    return null
  return menu_parent.get_child(index) as Control

func setCursorFromIndex(index : int) -> void:
  var menu_item := getMenuItemAtIndex(index)
  if menu_item == null:
    return
  var position = menu_item.rect_global_position
  var size = menu_item.rect_size
  rect_global_position = Vector2(position.x, position.y + size.y / 2.0) - (rect_size / 2.0) - cursor_offset
  cursor_index = index
  return
