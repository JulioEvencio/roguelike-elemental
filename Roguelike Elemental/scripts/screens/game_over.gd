class_name GameOver extends Control

signal restart
signal main_menu
signal exit

func _on_restart_pressed() -> void:
	restart.emit()

func _on_main_menu_pressed() -> void:
	main_menu.emit()

func _on_exit_pressed() -> void:
	exit.emit()
