class_name PlayerGround extends Player

func _ready() -> void:
	status.passive_defense = true

func _logic_damage_attack_02() -> int:
	return 3 + int(float(status.damage) / 10)

func _logic_damage_attack_03() -> int:
	return 8 + int(float(status.damage) / 5)

func _logic_damage_attack_special() -> int:
	return 15 + int(float(status.damage) / 2)
