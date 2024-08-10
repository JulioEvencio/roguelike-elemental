class_name Player extends CharacterBody2D

const _SPEED: float = 130.0
const _JUMP_VELOCITY: float = -300.0

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var _is_attacking: bool = false

@onready var _sprite: Sprite2D = get_node("Sprite2D")
@onready var _animation: AnimationPlayer = get_node("AnimationPlayer")

func _physics_process(_delta: float) -> void:
	if not _is_attacking:
		_move()
	
	_animate()
	_attack()

func _move() -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = _JUMP_VELOCITY
	else:
		velocity.y += _gravity
	
	var direction: float = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * _SPEED
		
		_sprite.flip_h = not direction == 1.0
	else:
		velocity.x = move_toward(velocity.x, 0, _SPEED)
	
	move_and_slide()

func _animate() -> void:
	if _is_attacking:
		if is_on_floor():
			_animation.play("attack_01")
		else:
			_animation.play("attack_jump")
	else:
		if is_on_floor():
			if velocity == Vector2.ZERO:
				_animation.play("idle")
			else:
				_animation.play("run")
		else:
			_animation.play("jump")

func _attack() -> void:
	if Input.is_action_just_pressed("attack") and not _is_attacking:
		_is_attacking = true

func _on_animation_player_animation_finished(anim_name: String) -> void:
	match anim_name:
		"attack_jump":
			_is_attacking = false
		"attack_01":
			_is_attacking = false
