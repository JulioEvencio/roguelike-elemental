class_name Pause extends Control

signal resume
signal tutorial
signal main_menu
signal exit

func _on_resume_pressed() -> void:
	resume.emit()

func _on_tutorial_pressed() -> void:
	tutorial.emit()

func _on_main_menu_pressed() -> void:
	main_menu.emit()

func _on_exit_pressed() -> void:
	exit.emit()
