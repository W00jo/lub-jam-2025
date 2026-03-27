extends Control

@onready var game = get_tree().root.get_node('Game')
@onready var instr_canvas = get_tree().root.get_node('Game/InstructionLayer')

func _input(_event: InputEvent) -> void:
	const keyboard_mouse_texture = preload("uid://djq73mdtccy1r")
	const gamepad_texture = preload("uid://d1hv85sgt0q7x")

	if game.INPUT_SCHEME == game.INPUT_SCHEMES.KEYBOARD_AND_MOUSE:
		$ColorRect.set_texture(keyboard_mouse_texture)
		$Ok.position.x = -334
	if game.INPUT_SCHEME == game.INPUT_SCHEMES.GAMEPAD:
		$ColorRect.set_texture(gamepad_texture)
		$Ok.position.x = 275

func _on_ok_pressed() -> void:
	get_tree().paused = false
	instr_canvas.queue_free()
