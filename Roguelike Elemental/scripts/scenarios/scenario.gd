class_name Scenario extends Node2D

signal wave_clean
signal scenario_clean

@export var _next_scenario: PackedScene = null

var _waves_current: int = 1
var _amount_enemies_current: int = 0

var _player: Player

@onready var _waves_info: Label = get_node("HUD/WavesInfo")
@onready var _enemies: Node = get_node("Enemies")
@onready var _skeleton_scene: PackedScene = preload(SceneController.skeleton)
@onready var _bringer_of_death: PackedScene = preload(SceneController.bringer_of_death)
@onready var _night_borne: PackedScene = preload(SceneController.night_borne)
@onready var _undead_executioner: PackedScene = preload(SceneController.undead_executioner)

func _ready() -> void:
	_setup_camera()
	_setup_player()
	_setup_enemies()

func add_player(player: Player) -> void:
	_player = player

func _setup_camera() -> void:
	var camera: Camera2D = get_node("Camera2D")
	
	var camera_limit_left: Marker2D = get_node("WorldLimits/CameraLimitLeft")
	var camera_limit_right: Marker2D = get_node("WorldLimits/CameraLimitRight")
	var camera_limit_top: Marker2D = get_node("WorldLimits/CameraLimitTop")
	var camera_limit_bottom: Marker2D = get_node("WorldLimits/CameraLimitBottom")
	
	camera.limit_left = int(camera_limit_left.position.x)
	camera.limit_right = int(camera_limit_right.position.x)
	camera.limit_top = int(camera_limit_top.position.y)
	camera.limit_bottom = int(camera_limit_bottom.position.y)

func _setup_player() -> void:
	var player_spwan: Marker2D = get_node("PlayerSpwan")
	
	_player.position = player_spwan.position
	
	add_child(_player)

func _waves_logic() -> void:
	_amount_enemies_current -= 1
	
	if _amount_enemies_current < 1:
		_waves_current += 1
		
		if _waves_current > 2 and not _next_scenario == null:
			scenario_clean.emit(_next_scenario)
		else:
			_setup_enemies()
		
		wave_clean.emit()
	
	_waves_info.text = "Waves: " + str(_waves_current)

func _add_enemy(enemy: PackedScene, enemy_position: Vector2) -> void:
	var enemy_instantiate: Enemy = enemy.instantiate()
	
	enemy_instantiate.position = enemy_position
	enemy_instantiate.add_player(_player)
	enemy_instantiate.connect("is_dead", _waves_logic)
	
	_enemies.add_child(enemy_instantiate)
	_amount_enemies_current += 1

func _setup_enemies() -> void:
	var enemy_number: int = randi_range(_waves_current, _waves_current + 5)
	_amount_enemies_current = 0
	
	for i: int in enemy_number:
		var enemy_position: Vector2
		
		if i % 2 == 0:
			enemy_position = Vector2(700, 200 + -35 * i)
		else:
			enemy_position = Vector2(-50, 200 + -35 * i)
		
		_add_enemy(_skeleton_scene, enemy_position)
	
	if _waves_current >= 5:
		_add_enemy(_bringer_of_death, Vector2(700, 200))
	
	if _waves_current >= 10:
		_add_enemy(_night_borne, Vector2(-50, 200))
	
	if _waves_current >= 15:
		_add_enemy(_undead_executioner, Vector2(700, 200))
