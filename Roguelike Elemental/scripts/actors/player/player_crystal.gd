class_name PlayerCrystal extends Player

func _ready() -> void:
	status.passive_critical = true

func _logic_damage_attack_02() -> int:
	return 2

func _logic_damage_attack_03() -> int:
	return 10

func _logic_damage_attack_special() -> int:
	return 20
