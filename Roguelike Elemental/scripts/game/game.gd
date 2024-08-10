class_name Game extends Node

@onready var _scenario: Node = get_node("Scenario")

func _ready() -> void:
	_start_game()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _start_game() -> void:
	var scenario_scene: PackedScene = load("res://scenes/scenarios/world.tscn")
	var player_scene: PackedScene = load("res://scenes/actors/player/player_fire.tscn")
	
	var scenario: Scenario = scenario_scene.instantiate()
	var player: Player = player_scene.instantiate()
	
	scenario.add_player(player)
	
	for child: Scenario in _scenario.get_children():
		child.queue_free()
	
	_scenario.add_child(scenario)
