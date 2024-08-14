class_name Pause extends Control

signal resume
signal main_menu
signal exit

func _on_resume_pressed() -> void:
	resume.emit()

func _on_main_menu_pressed() -> void:
	main_menu.emit()

func _on_exit_pressed() -> void:
	exit.emit()
