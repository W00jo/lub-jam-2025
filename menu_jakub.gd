extends Control

@onready var anim = $AnimationPlayer
@onready var canvas: CanvasLayer = $bubble_flee_splashart
@onready var instruction_layer = get_tree().root.get_node('Game/InstructionLayer')
@onready var instructions = get_tree().root.get_node('Game/InstructionLayer/Instructions')
@onready var shader_canvas = get_tree().root.get_node('Game/ShaderLayer')
@onready var menu = get_tree().root.get_node('Game/MenuLayer')
@onready var platform_ten_splashart: AnimatedSprite2D = $platform_ten_splashart/TextureRect2
@onready var credits: AnimatedSprite2D = $Creditsy/credits
@onready var choose_level: Control = $choose_level

@onready var play_btn = $Play
@onready var credits_btn = $Credits
@onready var exit_btn = $Exit

func _ready() -> void:
	get_tree().paused = true
	anim.play("splashscreen_fadeout")
	
	play_btn.popped.connect(_on_play_popped)
	credits_btn.popped.connect(_on_credits_popped)
	exit_btn.popped.connect(_on_exit_popped)
	
	choose_level.closed.connect(_on_choose_level_closed)
	
func _on_play_popped() -> void:
	choose_level.visible = true
	choose_level.score.text = "Dolphine " + str(Global.save_data.dolphin_score) + " : " + str(Global.save_data.bubble_score) + " Bubble"

func _on_choose_level_closed() -> void:
	choose_level.visible = false
	
	play_btn.disabled = false
	play_btn.bubble_anim.play("idle")
	play_btn.start_floating()

func _on_credits_popped() -> void:
	$Creditsy.visible = true
	$Creditsy.disabled = false
	$Creditsy.grab_focus()
	credits.play("Credits_start")
	
func _on_exit_popped() -> void:
	get_tree().quit()

func remove_splash():
	canvas.queue_free()

func remove_conductors():
	$platform_ten_splashart.queue_free()

func _on_creditsy_pressed() -> void:
	credits_btn.grab_focus()
	
	credits.play("Credits_end")
	await get_tree().create_timer(0.5).timeout
	$Creditsy.visible = false
	$Creditsy.disabled = true
	
	credits_btn.disabled = false
	credits_btn.bubble_anim.play("idle")
	credits_btn.start_floating()
