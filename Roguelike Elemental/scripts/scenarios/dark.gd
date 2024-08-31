class_name Dark extends Scenario

func _setup_enemies() -> void:
	var enemy_number: int = randi_range(_waves_current, _waves_current + 5)
	var bringer_of_death_number: int = enemy_number - 5
	var night_borne_number: int = enemy_number - 10
	var undead_executioner_number: int = enemy_number - 15
	
	_amount_enemies_current = 0
	
	for i: int in enemy_number:
		var enemy_position: Vector2
		
		if i % 2 == 0:
			enemy_position = Vector2(700 + 35 * i, 200)
		else:
			enemy_position = Vector2(-50 - 35 * i, 200)
		
		_add_enemy(_skeleton_scene, enemy_position)
		
		if _waves_current >= 5 and bringer_of_death_number > 0:
			bringer_of_death_number -= 1
			_add_enemy(_bringer_of_death, enemy_position)
		
		if _waves_current >= 10 and night_borne_number > 0:
			night_borne_number -= 1
			_add_enemy(_night_borne, enemy_position)
		
		if _waves_current >= 15 and undead_executioner_number > 0:
			undead_executioner_number -= 1
			_add_enemy(_undead_executioner, enemy_position)
