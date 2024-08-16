class_name Enemy extends CharacterBody2D

signal is_dead

var _player: Player = null
var _flip: String = ""
var _is_attacking: bool = false
var _is_hit: bool = false
var _is_dead: bool = false

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var _hp: int = 1
@export var _speed: float = 30.0
@export var _damage: int = 1

@onready var _animation: AnimationPlayer = get_node("AnimationPlayer")
@onready var _raycast: RayCast2D = get_node("RayCast2D")

func _physics_process(_delta: float) -> void:
	if not _is_dead and not _is_hit:
		_attack()
	
		if not _is_attacking:
			_move()
	
	_animate()

func add_player(player: Player) -> void:
	_player = player

func take_damage(damage: int) -> void:
	if not _is_dead and not _is_hit:
		_hp -= damage
		_is_hit = true
		_is_attacking = false

func _attack() -> void:
	if _raycast.is_colliding():
		_is_attacking = true

func _move() -> void:
	if not is_on_floor():
		velocity.y += _gravity
	
	var direction: Vector2 = Vector2.ZERO
	
	direction.x = 1 if global_position.x < _player.get_heart().global_position.x else -1
	
	if direction.x:
		velocity.x = direction.x * _speed
		
		_flip = "" if direction.x > 0 else "_flip"
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
	
	move_and_slide()

func _animate() -> void:
	if _is_dead:
		_animation.play("death" + _flip)
	elif _is_hit:
		_animation.play("hit" + _flip)
	elif _is_attacking:
		_animation.play("attack" + _flip)
	elif velocity == Vector2.ZERO:
		_animation.play("idle" + _flip)
	else:
		_animation.play("run" + _flip)

func _hit_logic() -> void:
	if _hp < 1:
		_is_dead = true
		
		# disable collision layer 3 - mode binary
		# collision layers and masks: https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html
		collision_layer &= ~0b0100
	
	_is_hit = false

func _dead_logic() -> void:
	is_dead.emit()
	queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack" or anim_name == "attack_flip":
		_is_attacking = false
	elif anim_name == "hit" or anim_name == "hit_flip":
		_hit_logic()
	elif anim_name == "death" or anim_name == "death_flip":
		_dead_logic()

func _on_attack_area_body_entered(player: Player) -> void:
	player.take_damage(_damage)
