class_name Bat extends CharacterBody2D

const _SPEED = 30.0

var _player: Player
var _damage: int = 1

@onready var _navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
@onready var _sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var _collision_attack: CollisionShape2D = get_node("AttackArea2D/CollisionShape2D")

func _physics_process(_delta: float) -> void:
	_move()

func add_player(player: Player) -> void:
	_player = player

func _move() -> void:
	_navigation_agent.target_position = _player.get_heart().global_position
	
	if _navigation_agent.distance_to_target() > 10:
		var direction: Vector2 = (_navigation_agent.get_next_path_position() - global_position).normalized()
		
		if direction:
			velocity = direction * _SPEED
			
			_sprite.flip_h = direction.x < 0
		else:
			velocity.x = move_toward(velocity.x, 0, _SPEED)
			velocity.y = move_toward(velocity.y, 0, _SPEED)
		
		move_and_slide()

func _reset_atack() -> void:
	_collision_attack.disabled = not _collision_attack.disabled

func _on_attack_area_2d_body_entered(player: Player) -> void:
	call_deferred("_reset_atack")
	player.take_damage(_damage)

func _on_attack_area_2d_body_exited(_body: Player) -> void:
	call_deferred("_reset_atack")
