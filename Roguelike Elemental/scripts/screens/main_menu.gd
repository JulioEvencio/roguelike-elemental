class_name MainMenu extends Menu

func _on_start_pressed() -> void:
	update_scene.emit(MenuController.Types.PLAY)

func _on_settings_pressed() -> void:
	update_scene.emit(MenuController.Types.SETTINGS)

func _on_credits_pressed() -> void:
	update_scene.emit(MenuController.Types.CREDITS)

func _on_exit_pressed() -> void:
	update_scene.emit(MenuController.Types.EXIT)
