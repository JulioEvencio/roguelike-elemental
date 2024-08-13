class_name MenuController extends Node

enum Types {
	PLAY,
	MAIN_MENU,
	SETTINGS,
	CREDITS,
	EXIT
}

@onready var _screen: Node = get_node("Screen")
@onready var _main_menu_scene: PackedScene = preload(SceneController.main_menu)

func _ready() -> void:
	_update_screen(_main_menu_scene)

func _play() -> void:
	get_tree().change_scene_to_file(SceneController.scenario_controller)

func _update_screen(screen: PackedScene) -> void:
	for child: Menu in _screen.get_children():
		child.queue_free()
	
	var screen_instantiate: Menu = screen.instantiate()
	
	screen_instantiate.connect("update_scene", _update_scene)
	_screen.add_child(screen_instantiate)

func _exit() -> void:
	get_tree().quit()

func _update_scene(type: MenuController.Types) -> void:
	match type:
		MenuController.Types.PLAY:
			Transition.start(func(): _play())
		MenuController.Types.MAIN_MENU:
			Transition.start(func(): _update_screen(_main_menu_scene))
		MenuController.Types.SETTINGS:
			Transition.start(func(): _update_screen(null))
		MenuController.Types.CREDITS:
			Transition.start(func(): _update_screen(null))
		MenuController.Types.EXIT:
			Transition.start(func(): _exit())
