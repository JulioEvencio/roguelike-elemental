class_name MainMenu extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_settings_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	pass

func _on_exit_pressed() -> void:
	get_tree().quit()
