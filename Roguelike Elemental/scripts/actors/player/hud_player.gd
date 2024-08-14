class_name HUDPlayer extends Control

@onready var _hp_bar: TextureProgressBar = get_node("HPBackground/HPBar")
@onready var _special_bar: TextureProgressBar = get_node("SpecialBackground/SpecialBar")

func add_status(status: Status) -> void:
	status.connect("update_hp_max", _update_hp_max)
	status.connect("update_hp_current", _update_hp_current)
	status.connect("update_special_max", _update_special_max)
	status.connect("update_special_current", _update_special_current)
	
	_update_hp_max(status.hp_max)
	_update_hp_current(status.hp_current)
	_update_special_max(status.special_max)
	_update_special_current(status.special_current)

func _update_hp_max(hp: int) -> void:
	_hp_bar.max_value = hp

func _update_hp_current(hp: int) -> void:
	_hp_bar.value = hp

func _update_special_max(special: int) -> void:
	_special_bar.max_value = special

func _update_special_current(special: int) -> void:
	_special_bar.value = special
