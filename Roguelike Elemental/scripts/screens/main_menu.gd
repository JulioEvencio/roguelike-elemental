class_name MainMenu extends Control

func _play() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _settings() -> void:
	pass

func _credits() -> void:
	pass

func _exit() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	Transition.start(func(): _play())

func _on_settings_pressed() -> void:
	Transition.start(func(): _settings())

func _on_credits_pressed() -> void:
	Transition.start(func(): _credits())

func _on_exit_pressed() -> void:
	Transition.start(func(): _exit())
