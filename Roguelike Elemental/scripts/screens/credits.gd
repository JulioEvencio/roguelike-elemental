class_name Credits extends Menu

func _on_back_pressed() -> void:
	update_scene.emit(MenuController.Types.MAIN_MENU)
