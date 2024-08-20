class_name Player extends CharacterBody2D

var status: Status = Status.new()

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var _attack_type: String = "attack_01"
var _is_attacking: bool = false
var _is_flip: String = ""
var _is_hit: bool = false
var _is_immune: bool = false

@onready var _sprite: Sprite2D = get_node("Sprite2D")
@onready var _animation: AnimationPlayer = get_node("AnimationPlayer")
@onready var _heart: Marker2D = get_node("Heart")
@onready var _immune_timer: Timer = get_node("ImmuneTimer")

func _physics_process(_delta: float) -> void:
	if not _is_attacking and not _is_hit:
		_move()
		_attack()
	
	_animate()

func get_heart() -> Marker2D:
	return _heart

func take_damage(damage: int) -> void:
	if not _is_hit and not _is_immune:
		status.hp_current -= damage
		
		_is_attacking = false
		_is_hit = true

func _move() -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = status.jump_velocity
	else:
		velocity.y += _gravity
	
	var direction: float = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * status.speed
		_is_flip = "" if direction == 1.0 else "_flip"
	else:
		velocity.x = move_toward(velocity.x, 0, status.speed)
	
	move_and_slide()

func _attack() -> void:
	if Input.is_action_just_pressed("attack"):
		var up_arrow: bool = false
		var down_arrow: bool = false
		
		if Input.is_action_pressed("up_arrow"):
			up_arrow = true
		
		if Input.is_action_pressed("down_arrow"):
			down_arrow = true
		
		if up_arrow and down_arrow:
			_attack_type = "attack_special"
		elif up_arrow:
			_attack_type = "attack_03"
		elif down_arrow:
			_attack_type = "attack_02"
		else:
			_attack_type = "attack_01"
		
		_is_attacking = true

func _animate() -> void:
	if _is_hit:
		_animation.play("hit" + _is_flip)
	elif _is_attacking:
		if is_on_floor():
			_animation.play(_attack_type + _is_flip)
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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_jump" or anim_name == "attack_jump_flip" or anim_name == _attack_type or anim_name == _attack_type + "_flip":
		_is_attacking = false
	elif anim_name == "hit" or anim_name == "hit_flip":
		_is_immune = true
		_is_hit = false
		_sprite.modulate.a = 0.5
		_immune_timer.wait_time = status.immunity
		_immune_timer.start()

func _on_special_timer_timeout() -> void:
	status.special_current += 1

func _on_attack_area_body_entered(enemy: Enemy) -> void:
	enemy.take_damage(status.damage)

func _on_immune_timer_timeout() -> void:
	_is_immune = false
	_sprite.modulate.a = 1.0
