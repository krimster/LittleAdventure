extends CharacterBody2D

var _input_direction: Vector2 = Vector2.ZERO
var _facing_direction: String = "Down"
var _animation_to_play: String

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150
const ACCELERATE = 15


func _physics_process(delta: float) -> void:
	# get input
	_input_direction = Input.get_vector("Left", "Right", "Up", "Down")

	# update velocity
	velocity = velocity.lerp(_input_direction * SPEED, ACCELERATE * delta)

	move_and_slide()

	# figure out the animation to play based on speed
	if velocity.length() > 20:
		_animation_to_play = "Run_" + get_direction_name()
	else:
		_animation_to_play = "Idle_" + get_direction_name()

	animated_sprite_2d.play(_animation_to_play)
	# print(_animation_to_play)


func get_direction_name() -> String:
	if _input_direction == Vector2.ZERO:
		return _facing_direction

	if _input_direction.y > 0:
		_facing_direction = "Down"
	elif _input_direction.y < 0:
		_facing_direction = "Up"
	else:
		if _input_direction.x > 0:
			_facing_direction = "Right"
		elif _input_direction.x < 0:
			_facing_direction = "Left"
	return _facing_direction
