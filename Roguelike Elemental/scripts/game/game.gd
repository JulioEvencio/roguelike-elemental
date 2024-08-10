class_name Game extends Node

@onready var _scenario: Node = get_node("Scenario")

func _ready() -> void:
	_update_scenario(preload("res://scenes/scenarios/world.tscn"))

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _update_scenario(scenario: PackedScene) -> void:
	for child in _scenario.get_children():
		child.queue_free()
	
	_scenario.add_child(scenario.instantiate())
