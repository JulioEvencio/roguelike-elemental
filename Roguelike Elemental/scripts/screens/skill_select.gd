class_name SkillSelect extends Control

signal skill_selected

var _option_current: ColorRect = null
var _status: Status = null

var _skills_options: Array[Dictionary] = [
	{
		"name": "immunity",
		"description": "$_SKILL_IMMUNITY"
	},
	{
		"name": "critical_chance",
		"description": "$_SKILL_CRITICAL_CHANCE"
	},
	{
		"name": "defense",
		"description": "$_SKILL_DEFENSE"
	},
	{
		"name": "damage",
		"description": "$_SKILL_DAMAGE"
	},
	{
		"name": "hp_regeneration",
		"description": "$_SKILL_HP_REGENERATION"
	},
	{
		"name": "speed",
		"description": "$_SKILL_SPEED"
	},
	{
		"name": "jump_velocity",
		"description": "$_SKILL_JUMP_VELOCITY"
	},
	{
		"name": "special_regeneration",
		"description": "$_SKILL_SPECIAL_REGENERATION"
	},
	{
		"name": "hp_max",
		"description": "$_SKILL_HP_MAX"
	}
]

@onready var _option_01: ColorRect = get_node("HBoxContainer/Option01")
@onready var _option_02: ColorRect = get_node("HBoxContainer/Option02")
@onready var _option_03: ColorRect = get_node("HBoxContainer/Option03")

func _ready() -> void:
	_reset_scene()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("click_left"):
		_select_logic(_option_01)
		_select_logic(_option_02)
		_select_logic(_option_03)
		
		_option_current.color = Color.GREEN_YELLOW

func add_status(status: Status) -> void:
	_status = status

func _reset_scene() -> void:
	_setup_skills_options()
	
	_option_01.color = Color(0.0, 0.0, 0.0, 0.0)
	_option_02.color = Color(0.0, 0.0, 0.0, 0.0)
	_option_03.color = Color(0.0, 0.0, 0.0, 0.0)
	
	_option_current = _option_01
	_option_current.color = Color.GREEN_YELLOW

func _setup_skills_options() -> void:
	_skills_options.shuffle()
	
	var skill_01: int = randi() % _skills_options.size()
	var skill_02: int = randi() % _skills_options.size()
	var skill_03: int = randi() % _skills_options.size()
	
	while skill_02 == skill_01:
		skill_02 = randi() % _skills_options.size()
	
	while skill_03 == skill_01 or skill_03 == skill_02:
		skill_03 = randi() % _skills_options.size()
	
	_set_option(_option_01, _skills_options[skill_01])
	_set_option(_option_02, _skills_options[skill_02])
	_set_option(_option_03, _skills_options[skill_03])

func _set_option(slot: ColorRect, option: Dictionary) -> void:
	slot.get_node("Card/Info").text = option.description

func _select_logic(option: ColorRect) -> void:
	if option.get_global_rect().has_point(get_global_mouse_position()):
		_option_current = option
	else:
		option.color = Color(0.0, 0.0, 0.0, 0.0)

func _on_choose_pressed() -> void:
	var skill_description_selected: String = _option_current.get_node("Card/Info").text
	
	for i: int in _skills_options.size():
		if skill_description_selected == _skills_options[i].description:
			match _skills_options[i].name:
				"immunity":
					_status.immunity += 0.1
				"critical_chance":
					_status.critical_chance += 1
				"defense":
					_status.defense += 1
				"damage":
					_status.damage += 1
				"hp_regeneration":
					_status.hp_regeneration += 1
				"speed":
					_status.speed += 5
				"jump_velocity":
					_status.jump_velocity -= 5
				"special_regeneration":
					_status.special_regeneration += 1
				"hp_max":
					_status.hp_max += 5
					_status.hp_current += 5
	
	skill_selected.emit()
	
	_reset_scene()
