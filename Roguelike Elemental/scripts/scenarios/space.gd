class_name Space extends Scenario

func _setup_enemies() -> void:
	var enemy_number: int = randi_range(_waves_current, _waves_current + 5)
	
	_amount_enemies_current = 0
	
	for i: int in enemy_number:
		var enemy_position: Vector2
		
		if i % 2 == 0:
			enemy_position = Vector2(700 + 35 * i, 200)
		else:
			enemy_position = Vector2(-50 - 35 * i, 200)
		
		_add_enemy(_night_borne, enemy_position)
		
		if _waves_current >= 5 and i > 3:
			_add_enemy(_skeleton_scene, enemy_position)
	
	if _waves_current >= 9:
		_add_enemy(_undead_executioner, Vector2(700 + 35, 200))
	
	if _waves_current == 10:
		_add_enemy(_undead_executioner, Vector2(-50 - 35, 200))
