class_name Settings extends Menu

static var _music_value: float = 0.5
static var _sfx_value: float = 0.5

@onready var _music_value_label: Label = get_node("Filter/ConfigContainer/MusicContainer/MusicValue")
@onready var _music_slider: HSlider = get_node("Filter/ConfigContainer/MusicVolume")

@onready var _sfx_value_label: Label = get_node("Filter/ConfigContainer/SFXContainer2/SFXValue")
@onready var _sfx_slider: HSlider = get_node("Filter/ConfigContainer/SFXVolume")

func _ready() -> void:
	var language_button: OptionButton = get_node("Filter/ConfigContainer/LanguageButton")
	var index: int
	
	match TranslationServer.get_locale().substr(0, 2):
		"pt":
			index = 1
		"es":
			index = 2
		_:
			index = 0
	
	language_button.select(index)
	
	_on_music_volume_value_changed(Settings._music_value)
	_on_sfx_volume_value_changed(Settings._sfx_value)

static func update_music_volume() -> void:
	if Settings._music_value == 0.0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("music"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("music"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), linear_to_db(Settings._music_value))

static func update_sfx_volume() -> void:
	if Settings._sfx_value == 0.0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("sfx"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("sfx"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(Settings._sfx_value))

func _on_language_button_item_selected(index: int) -> void:
	var language: String
	
	match index:
		1:
			language = "pt"
		2:
			language = "es"
		_:
			language = "en"
	
	TranslationServer.set_locale(language)

func _on_music_volume_value_changed(value: float) -> void:
	_music_value_label.text = str(value * 100) + "%"
	_music_slider.value = value
	
	Settings._music_value = value
	Settings.update_music_volume()

func _on_sfx_volume_value_changed(value: float) -> void:
	_sfx_value_label.text = str(value * 100) + "%"
	_sfx_slider.value = value
	
	Settings._sfx_value = value
	Settings.update_sfx_volume()

func _on_back_pressed() -> void:
	update_scene.emit(MenuController.Types.MAIN_MENU)
