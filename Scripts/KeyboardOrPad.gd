extends Node

enum INPUT_SCHEMES { KEYBOARD_AND_MOUSE, GAMEPAD }
static var INPUT_SCHEME: INPUT_SCHEMES = INPUT_SCHEMES.GAMEPAD

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion and event.relative) or (event is InputEventMouseButton and event.pressed):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		INPUT_SCHEME = INPUT_SCHEMES.KEYBOARD_AND_MOUSE
		
	if (event is InputEventJoypadMotion and event.axis) or (event is InputEventJoypadButton and event.pressed):
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		INPUT_SCHEME = INPUT_SCHEMES.GAMEPAD
