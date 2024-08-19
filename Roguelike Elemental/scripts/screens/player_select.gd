class_name PlayerSelect extends Control

signal player_selected

var _option_current: ColorRect = null

@onready var _option_01: ColorRect = get_node("HBoxContainer/Option01")
@onready var _option_02: ColorRect = get_node("HBoxContainer/Option02")
@onready var _option_03: ColorRect = get_node("HBoxContainer/Option03")

func _ready() -> void:
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

func _select_logic(option: ColorRect) -> void:
	if option.get_global_rect().has_point(get_global_mouse_position()):
		_option_current = option
	else:
		option.color = Color(0.0, 0.0, 0.0, 0.0)

func _on_button_default_pressed() -> void:
	var player_name_selected: String = _option_current.get_node("TextureRect/PlayerName").text
	
	player_selected.emit(player_name_selected)
