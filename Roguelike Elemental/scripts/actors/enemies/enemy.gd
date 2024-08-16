class_name Enemy extends CharacterBody2D

var _player: Player = null
var _flip: String = ""
var _is_attacking: bool = false

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var _speed: float = 30.0
@export var _damage: int = 1

@onready var _animation: AnimationPlayer = get_node("AnimationPlayer")
@onready var _raycast: RayCast2D = get_node("RayCast2D")

func _physics_process(_delta: float) -> void:
	_attack()
	
	if not _is_attacking:
		_move()
	
	_animate()

func add_player(player: Player) -> void:
	_player = player

func _attack() -> void:
	if _raycast.is_colliding():
		_is_attacking = true

func _move() -> void:
	if not is_on_floor():
		velocity.y += _gravity
	
	var direction: Vector2 = Vector2(1, 0) if global_position.x < _player.global_position.x else Vector2(-1, 0)
	
	if direction.x:
		velocity.x = direction.x * _speed
		
		_flip = "" if direction.x > 0 else "_flip"
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
	
	move_and_slide()

func _animate() -> void:
	if _is_attacking:
		_animation.play("attack" + _flip)
	elif velocity == Vector2.ZERO:
		_animation.play("idle" + _flip)
	else:
		_animation.play("run" + _flip)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"attack":
			_is_attacking = false
		"attack_flip":
			_is_attacking = false

func _on_attack_area_body_entered(player: Player) -> void:
	player.take_damage(_damage)
