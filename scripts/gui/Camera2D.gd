extends Camera2D
var previous_follow   := []
var follow            = null

var _duration         = 0.0
var _period_in_ms     = 0.0
var _amplitude        = 0.0
var _timer            = 0.0
var _last_shook_timer = 0
var _previous_x       = 0.0
var _previous_y       = 0.0
var _last_offset      = Vector2(0, 0)

func _ready() -> void:
# warning-ignore:return_value_discarded
  SceneManager.connect("camera_returned", self, "followPrevious")
  # warning-ignore:return_value_discarded
  SceneManager.connect("target_locked", self, "startFollowing")
  # warning-ignore:return_value_discarded
  SceneManager.connect("register_camera_limits", self, "setCameraLimits")
  # warning-ignore:return_value_discarded
  SceneManager.connect("shake_camera", self, "shake")
  return

func reduce_zoom() -> void:
  zoom = Vector2(1, 1)
  return

func amplify() -> void:
  zoom = Vector2(0.5, 0.5)
  return

func followPrevious() -> void:
  var _temp = previous_follow.pop_back()
  if _temp.is_instance_valid():
    follow = _temp
  return

func startFollowing(target) -> void:
  previous_follow.push_back(follow)
  follow = target
  return

func _physics_process(_delta) -> void:
  if follow:
    position = follow.global_position
  return

# Shake with decreasing intensity while there's time remaining.
func _process(delta) -> void:
  # Only shake when there's shake time remaining.
  if _timer == 0:
    return
  # Only shake on certain frames.
  _last_shook_timer = _last_shook_timer + delta
  # Be mathematically correct in the face of lag; usually only happens once.
  while _last_shook_timer >= _period_in_ms:
    _last_shook_timer = _last_shook_timer - _period_in_ms
    # Lerp between [amplitude] and 0.0 intensity based on remaining shake time.
    var intensity = _amplitude * (1 - ((_duration - _timer) / _duration))
    # Noise calculation logic from http://jonny.morrill.me/blog/view/14
    var new_x = rand_range(-1.0, 1.0)
    var x_component = intensity * (_previous_x + (delta * (new_x - _previous_x)))
    var new_y = rand_range(-1.0, 1.0)
    var y_component = intensity * (_previous_y + (delta * (new_y - _previous_y)))
    _previous_x = new_x
    _previous_y = new_y
    # Track how much we've moved the offset, as opposed to other effects.
    var new_offset = Vector2(x_component, y_component)
    set_offset(get_offset() - _last_offset + new_offset)
    _last_offset = new_offset
  # Reset the offset when we're done shaking.
  _timer = _timer - delta
  if _timer <= 0:
    _timer = 0
    set_offset(get_offset() - _last_offset)
  return

# Kick off a new screenshake effect.
func shake(duration, frequency, amplitude) -> void:
  # Initialize variables.
  _duration = duration
  _timer = duration
  _period_in_ms = 1.0 / frequency
  _amplitude = amplitude
  _previous_x = rand_range(-1.0, 1.0)
  _previous_y = rand_range(-1.0, 1.0)
  # Reset previous offset, if any.
  set_offset(get_offset() - _last_offset)
  _last_offset = Vector2(0, 0)
  return

func setCameraLimits(topleft : Vector2, bottomright : Vector2) -> void:
  #warning-ignore:NARROWING_CONVERSION
  limit_top    = topleft.y
  # warning-ignore:NARROWING_CONVERSION
  limit_left   = topleft.x
  # warning-ignore:NARROWING_CONVERSION
  limit_right  = bottomright.x
  # warning-ignore:NARROWING_CONVERSION
  limit_bottom = bottomright.y
  return
