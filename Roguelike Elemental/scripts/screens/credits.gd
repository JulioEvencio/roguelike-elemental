class_name Credits extends Menu

signal update_scene

func _on_back_pressed() -> void:
	update_scene.emit(MenuController.Types.MAIN_MENU)
