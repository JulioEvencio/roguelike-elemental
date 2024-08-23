class_name PlayerSelect extends Control

signal player_selected

var _option_current: ColorRect = null

var _player_options: Array[Dictionary] = [
	{
		"icon": SceneController.player_fire_avatar,
		"name": "Ignis",
		"description": "Fire Attack",
		"scene": SceneController.player_fire
	},
	{
		"icon": SceneController.player_water_avatar,
		"name": "Aqua",
		"description": "Water Attack",
		"scene": SceneController.player_water
	},
	{
		"icon": SceneController.player_wind_avatar,
		"name": "Ventuso",
		"description": "Wind Attack",
		"scene": SceneController.player_wind
	},
	{
		"icon": SceneController.player_metal_avatar,
		"name": "Metalia",
		"description": "Metal Attack",
		"scene": SceneController.player_metal
	}
]

@onready var _option_01: ColorRect = get_node("HBoxContainer/Option01")
@onready var _option_02: ColorRect = get_node("HBoxContainer/Option02")
@onready var _option_03: ColorRect = get_node("HBoxContainer/Option03")

func _ready() -> void:
	_setup_player_options()
	
	_option_01.color = Color(0.0, 0.0, 0.0, 0.0)
	_option_02.color = Color(0.0, 0.0, 0.0, 0.0)
	_option_03.color = Color(0.0, 0.0, 0.0, 0.0)
	
	_option_current = _option_01
	_option_current.color = Color.GREEN_YELLOW

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("click_left"):
		_select_logic(_option_01)
		_select_logic(_option_02)
		_select_logic(_option_03)
		
		_option_current.color = Color.GREEN_YELLOW

func _setup_player_options() -> void:
	_player_options.shuffle()
	
	while _player_options.size() > 3:
		var index_remove: int = randi() % _player_options.size()
		
		_player_options.remove_at(index_remove)
	
	_set_option(_option_01, _player_options[0])
	_set_option(_option_02, _player_options[1])
	_set_option(_option_03, _player_options[2])

func _set_option(slot: ColorRect, option: Dictionary) -> void:
	slot.get_node("TextureRect/Avatar").texture = load(option.icon)
	slot.get_node("TextureRect/PlayerName").text = option.name
	slot.get_node("TextureRect/Description").text = option.description

func _select_logic(option: ColorRect) -> void:
	if option.get_global_rect().has_point(get_global_mouse_position()):
		_option_current = option
	else:
		option.color = Color(0.0, 0.0, 0.0, 0.0)

func _on_choose_pressed() -> void:
	var player_name_selected: String = _option_current.get_node("TextureRect/PlayerName").text
	var player_scene_name: String
	
	for i: int in _player_options.size():
		if player_name_selected == _player_options[i].name:
			player_scene_name = _player_options[i].scene
			break
	
	player_selected.emit(player_scene_name)
