class_name PlayerMetal extends Player

func _ready() -> void:
	status.passive_lifesteal = true

func _logic_damage_attack_02() -> int:
	return 1 + int(float(status.damage) / 10)

func _logic_damage_attack_03() -> int:
	return 5 + int(float(status.damage) / 10)

func _logic_damage_attack_special() -> int:
	return 20 + int(float(status.damage) / 10)
