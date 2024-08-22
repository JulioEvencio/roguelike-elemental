class_name Status extends RefCounted

signal update_hp_max
signal update_hp_current
signal update_special_max
signal update_special_current

var hp_max: int = 10:
	set(value):
		hp_max = value
		update_hp_max.emit(hp_max)

var hp_current: int = hp_max:
	set(value):
		hp_current = value
		
		if hp_current > hp_max:
			hp_current = hp_max
		elif hp_current < 0:
			hp_current = 0
		
		update_hp_current.emit(hp_current)

var special_max: int = 60:
	set(value):
		special_max = value
		update_special_max.emit(special_max)

var special_current: int = 0:
	set(value):
		special_current = value
		
		if special_current > special_max:
			special_current = special_max
		
		update_special_current.emit(special_current)

var speed: float = 130
var jump_velocity: float = -300.0
var hp_regeneration: int = 0
var damage: int = 1
var defense: int = 1
var critical_damage: int = 10
var critical_chance: int = 0
var reflect_damage: int = 0
var dodge_the_attack: int = 0
var immunity: float = 1.0

var passive_defense: bool = false
var passive_immunity: bool = false
var passive_fire: bool = false
var passive_time: bool = false
var passive_lifesteal: bool = false
var passive_attack_speed: bool = false
var passive_control_immunity: bool = false
