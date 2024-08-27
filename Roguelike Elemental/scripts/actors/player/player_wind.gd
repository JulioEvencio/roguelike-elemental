class_name PlayerWind extends Player

func _ready() -> void:
	status.passive_dodge_the_attack = true

func _logic_damage_attack_02() -> int:
	return status.damage + int(float(status.damage) / 10)

func _logic_damage_attack_03() -> int:
	return status.damage + int(float(status.damage) / 3)

func _logic_damage_attack_special() -> int:
	return status.damage + int(float(status.damage) / 10)
