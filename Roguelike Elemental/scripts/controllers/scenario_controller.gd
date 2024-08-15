class_name ScenarioController extends Node

var _player: Player = preload(SceneController.player).instantiate()

@onready var _pause_screen: Pause = get_node("HUD/Pause")
@onready var _scenario: Node = get_node("Scenario")
@onready var _scenario_scene: PackedScene = preload(SceneController.scenario)

func _ready() -> void:
	var hud_player: HUDPlayer = get_node("HUD/HUDPlayer")
	
	hud_player.add_status(_player.status)
	
	_update_scenario(_scenario_scene)

func _physics_process(_delta: float) -> void:
	_toggle_pause()

func _toggle_pause() -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		_pause_screen.visible = get_tree().paused

func _update_scenario(scenario: PackedScene) -> void:
	for child: Scenario in _scenario.get_children():
		child.queue_free()
	
	var scenario_instantiate: Scenario = scenario.instantiate()
	
	scenario_instantiate.add_player(_player)
	_scenario.add_child(scenario_instantiate)

func _change_scene_to_menu_controller() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(SceneController.menu_controller)

func _exit() -> void:
	get_tree().quit()

func _on_pause_resume() -> void:
	_pause_screen.visible = false
	get_tree().paused = false

func _on_pause_main_menu() -> void:
	Transition.start(func(): _change_scene_to_menu_controller())

func _on_pause_exit() -> void:
	Transition.start(func(): _exit())
