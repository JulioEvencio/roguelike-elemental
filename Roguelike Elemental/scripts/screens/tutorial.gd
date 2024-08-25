class_name Tutorial extends Control

signal tutorial_close

func _on_start_pressed() -> void:
	tutorial_close.emit()
