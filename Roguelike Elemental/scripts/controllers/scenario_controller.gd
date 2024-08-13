class_name ScenarioController extends Node

var _player: Player = preload(SceneController.player).instantiate()

@onready var _scenario: Node = get_node("Scenario")
@onready var _scenario_scene: PackedScene = preload(SceneController.scenario)

func _ready() -> void:
	_update_scenario(_scenario_scene)

func _update_scenario(scenario: PackedScene) -> void:
	var scenario_instantiate: Scenario = scenario.instantiate()
	
	scenario_instantiate.add_player(_player)
	
	for child: Scenario in _scenario.get_children():
		child.queue_free()
	
	_scenario.add_child(scenario_instantiate)
