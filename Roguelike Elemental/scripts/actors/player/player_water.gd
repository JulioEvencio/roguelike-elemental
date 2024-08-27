class_name PlayerWater extends Player

func _ready() -> void:
	status.passive_special_regeneration = true

func _logic_damage_attack_02() -> int:
	return 3 + int(float(status.damage) / 10)

func _logic_damage_attack_03() -> int:
	return 10 + int(float(status.damage) / 10)

func _logic_damage_attack_special() -> int:
	return 15 + int(float(status.damage) / 3)
