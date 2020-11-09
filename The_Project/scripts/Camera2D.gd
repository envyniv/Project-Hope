extends Camera2D
onready var topLeft = get_node("../World/Stage/CameraLimits/TopLeft")
onready var bottomRight = get_node("../World/Stage/CameraLimits/BottomRight")
var target = null

var _duration = 0.0
var _period_in_ms = 0.0
var _amplitude = 0.0
var _timer = 0.0
var _last_shook_timer = 0
var _previous_x = 0.0
var _previous_y = 0.0
var _last_offset = Vector2(0, 0)

# Shake with decreasing intensity while there's time remaining.
func _process(delta):
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

# Kick off a new screenshake effect.
func shake(duration, frequency, amplitude):
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

func _physics_process(delta):
	if target:
		position = target.position
	if get_node("../World/Stage/ZoomOUT"):
		var zoomout=get_node("../World/Stage/ZoomOUT")
		var player2zoom = stepify(target.position.distance_to(zoomout.position)/1000,0.01);
		var distance = player2zoom
		var step = 0.1
		#store player2zoom in distance, then check if player2zoom is smaller than distance
		#if it's smaller by a step, re-store, and increment zoom by a step
		if player2zoom < distance:
			distance = player2zoom
			zoom += step
pass

func _ready():
	set_process(true)
	if bottomRight&&topLeft:
		limit_top = topLeft.position.y
		limit_left = topLeft.position.x
		limit_right = bottomRight.position.x
		limit_bottom = bottomRight.position.y
pass

func playerThink():
	position.x+=30
	pass


