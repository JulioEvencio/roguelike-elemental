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

var special_max: int = 100:
	set(value):
		special_max = value
		update_special_max.emit(special_max)

var special_current: int = 0:
	set(value):
		special_current = value
		
		if special_current > special_max:
			special_current = special_max
		
		update_special_current.emit(special_current)

var special_regeneration: int = 1
var cost_skill_02: int = 5
var cost_skill_03: int = 10
var cost_attack_special: int = 100

var speed: float = 130
var jump_velocity: float = -300.0
var hp_regeneration: int = 0
var damage: int = 1
var damage_bonus: int = 0
var defense: int = 1
var critical_chance: int = 10
var dodge_the_attack: int = 0
var immunity: float = 1.0

var passive_defense: bool = false
var passive_critical: bool = false
var passive_fire: bool = false
var passive_lifesteal: bool = false
var passive_dodge_the_attack: bool = false
var passive_special_regeneration: bool = false
