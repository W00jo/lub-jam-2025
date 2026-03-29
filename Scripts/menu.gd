extends Control

@onready var anim = $AnimationPlayer
@onready var canvas: CanvasLayer = $bubble_flee_splashart
@onready var instruction_layer = get_tree().root.get_node('Game/InstructionLayer')
@onready var instructions = get_tree().root.get_node('Game/InstructionLayer/Instructions')
@onready var shader_canvas = get_tree().root.get_node('Game/ShaderLayer')
@onready var menu = get_tree().root.get_node('Game/MenuLayer')
@onready var platform_ten_splashart: AnimatedSprite2D = $platform_ten_splashart/TextureRect2

func _ready() -> void:
	get_tree().paused = true
	anim.play("splashscreen_fadeout")
	$CenterContainer/VBoxContainer/Play.grab_focus()

func _on_play_pressed() -> void:
	instruction_layer.visible = true
	instructions.get_node('Ok').grab_focus()
	#shader_canvas.visible = true
	menu.queue_free()
	Audio.game_music = preload("res://Assets/Sounds/Banger.mp3")
	Audio.play_music()

func _on_credits_pressed() -> void:
	$Creditsy.visible = true
	$Creditsy.disabled = false
	$Creditsy.grab_focus()
	
func _on_exit_pressed() -> void:
	get_tree().quit()

func remove_splash():
	canvas.queue_free()

func remove_conductors():
	$platform_ten_splashart.queue_free()

func _on_creditsy_pressed() -> void:
	$Creditsy.visible = false
	$Creditsy.disabled = true
	$CenterContainer/VBoxContainer/Credits.grab_focus()
