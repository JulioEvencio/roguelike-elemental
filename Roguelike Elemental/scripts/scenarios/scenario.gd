class_name Scenario extends Node2D

var _player: Player

func _ready() -> void:
	_setup_camera()
	_setup_player()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _setup_camera() -> void:
	var camera: Camera2D = get_node("Camera2D")
	var camera_limit_left: Marker2D = get_node("WorldLimits/CameraLimitLeft")
	var camera_limit_right: Marker2D = get_node("WorldLimits/CameraLimitRight")
	var camera_limit_top: Marker2D = get_node("WorldLimits/CameraLimitTop")
	var camera_limit_bottom: Marker2D = get_node("WorldLimits/CameraLimitBottom")
	
	camera.limit_left = int(camera_limit_left.position.x)
	camera.limit_right = int(camera_limit_right.position.x)
	camera.limit_top = int(camera_limit_top.position.y)
	camera.limit_bottom = int(camera_limit_bottom.position.y)

func _setup_player() -> void:
	var player_spwan: Marker2D = get_node("PlayerSpwan")
	
	_player.position = player_spwan.position
	
	add_child(_player)

func add_player(player: Player) -> void:
	_player = player
