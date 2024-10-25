class_name ScenarioController extends Node

var _is_show_tutorial: bool = false
var _is_show_skill_select: bool = false
var _is_show_player_select: bool = true
var _is_game_over: bool = false

var _player: Player = null

var _musics: Array[AudioStreamPlayer] = []
var _music_current: int = 0

@onready var _pause_screen: Pause = get_node("HUD/Pause")
@onready var _skill_select: SkillSelect = get_node("HUD/SkillSelect")
@onready var _tutorial_screen: Tutorial = get_node("HUD/Tutorial")
@onready var _game_over_screen: GameOver = get_node("HUD/GameOver")
@onready var _scenario: Node = get_node("Scenario")

@onready var _scenario_scene: PackedScene = preload(SceneController.earth_scenario)

func _ready() -> void:
	for music: AudioStreamPlayer in get_node("Musics").get_children():
		music.connect("finished", _music_logic)
		_musics.push_back(music)
	
	_musics.shuffle()
	_musics[_music_current].play(0.0)

func _physics_process(_delta: float) -> void:
	_toggle_pause()

func _setup_controller() -> void:
	_is_show_player_select = false
	
	var player_select: PlayerSelect = get_node("HUD/PlayerSelect")
	var hud_player: HUDPlayer = get_node("HUD/HUDPlayer")
	
	player_select.queue_free()
	hud_player.add_status(_player.status)
	_skill_select.add_status(_player.status)
	
	_update_scenario(_scenario_scene)
	_show_tutorial()

func _music_logic() -> void:
	_music_current += 1
	
	if _music_current >= 4:
		_music_current = 0
	
	_musics[_music_current].play(0.0)

func _show_tutorial() -> void:
	get_tree().paused = true
	_is_show_tutorial = true
	_pause_screen.visible = false
	_tutorial_screen.visible = true

func _toggle_pause() -> void:
	if Input.is_action_just_pressed("pause") and not _is_show_tutorial and not _is_show_skill_select and not _is_show_player_select and not _is_game_over:
		get_tree().paused = not get_tree().paused
		_pause_screen.visible = get_tree().paused

func _set_next_scenario(next_scenario: PackedScene) -> void:
	_scenario_scene = next_scenario

func _update_scenario(scenario: PackedScene) -> void:
	for child: Scenario in _scenario.get_children():
		child.remove_child(_player)
		child.queue_free()
	
	var scenario_instantiate: Scenario = scenario.instantiate()
	
	scenario_instantiate.add_player(_player)
	scenario_instantiate.connect("wave_clean", _wave_clean)
	scenario_instantiate.connect("scenario_clean", _set_next_scenario)
	
	_scenario.add_child(scenario_instantiate)
	
	_scenario_scene = null

func _wave_clean() -> void:
	_skill_select.visible = true
	_is_show_skill_select = true
	get_tree().paused = true

func _restart() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _change_scene_to_menu_controller() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(SceneController.menu_controller)

func _exit() -> void:
	get_tree().paused = true
	get_tree().quit()

func _game_over() -> void:
	get_tree().paused = true
	_is_game_over = true
	_game_over_screen.visible = true

func _on_pause_resume() -> void:
	_pause_screen.visible = false
	get_tree().paused = false

func _on_pause_tutorial() -> void:
	_show_tutorial()

func _on_pause_main_menu() -> void:
	Transition.start(func(): _change_scene_to_menu_controller())

func _on_pause_exit() -> void:
	Transition.start(func(): _exit())

func _on_player_select_player_selected(player_scene_name: String) -> void:
	_player = load(player_scene_name).instantiate()
	_player.connect("is_dead", _game_over)
	
	Transition.start(func(): _setup_controller())

func _on_game_over_restart() -> void:
	Transition.start(func(): _restart())

func _on_game_over_main_menu() -> void:
	Transition.start(func(): _change_scene_to_menu_controller())

func _on_game_over_exit() -> void:
	Transition.start(func(): _exit())

func _on_tutorial_tutorial_close() -> void:
	_tutorial_screen.visible = false
	_is_show_tutorial = false
	get_tree().paused = false

func _on_skill_select_skill_selected() -> void:
	_skill_select.visible = false
	_is_show_skill_select = false
	get_tree().paused = false
	
	if not _scenario_scene == null:
		Transition.start(func(): _update_scenario(_scenario_scene))
