class_name Player extends CharacterBody2D

const _SPEED: float = 130.0
const _JUMP_VELOCITY: float = -300.0

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var _is_attacking: bool = false
var _is_flip: String = ""

@onready var _animation: AnimationPlayer = get_node("AnimationPlayer")

func _physics_process(_delta: float) -> void:
	if not _is_attacking:
		_move()
		_attack()
	
	_animate()

func _move() -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = _JUMP_VELOCITY
	else:
		velocity.y += _gravity
	
	var direction: float = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * _SPEED
		_is_flip = "" if direction == 1.0 else "_flip"
	else:
		velocity.x = move_toward(velocity.x, 0, _SPEED)
	
	move_and_slide()

func _attack() -> void:
	if Input.is_action_just_pressed("attack"):
		_is_attacking = true

func _animate() -> void:
	if _is_attacking:
		if is_on_floor():
			_animation.play("attack_01" + _is_flip)
		else:
			_animation.play("attack_jump" + _is_flip)
	else:
		if is_on_floor():
			if velocity == Vector2.ZERO:
				_animation.play("idle" + _is_flip)
			else:
				_animation.play("run" + _is_flip)
		else:
			_animation.play("jump" + _is_flip)

func _on_animation_player_animation_finished(anim_name: String) -> void:
	match anim_name:
		"attack_jump":
			_is_attacking = false
		"attack_jump_flip":
			_is_attacking = false
		"attack_01":
			_is_attacking = false
		"attack_01_flip":
			_is_attacking = false
