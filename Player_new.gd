extends KinematicBody2D

#initialize
var right = Input.is_action_pressed("ui_right")
var left = Input.is_action_pressed("ui_left")
var up = Input.is_action_pressed("ui_up")
var down = Input.is_action_pressed("ui_down")
var speed = 100
var velocity = Vector2()

#get input
func get_input():
	if right:
		velocity.x += 1
	if left:
		velocity.x -= 1
	if down:
		velocity.y += 1
	if up:
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	pass
	
#state machine
enum {
	STILL
	MOVING
	RUNNING
	SPECIAL
}

var state = STILL

# movement
func _process(delta):
	get_input()
	move_and_collide(velocity * delta)
	pass

func anim_handle(): #'you should probably check if the player *is* moving, rather than if they *aren't*' -gotimo2
# 
	pass
