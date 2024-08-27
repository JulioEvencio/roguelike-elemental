class_name PlayerCrystal extends Player

func _ready() -> void:
	status.passive_critical = true

func _logic_damage_attack_02() -> int:
	return 2 + int(float(status.damage) / 10)

func _logic_damage_attack_03() -> int:
	return 3 + int(float(status.damage) / 10)

func _logic_damage_attack_special() -> int:
	return 10 + int(float(status.damage) / 50)
