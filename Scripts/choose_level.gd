extends Control

## Customowy signal/sygnał do odtwarzania przyciko-bąbli
signal closed

const LEVEL_1 = preload("res://Scenes/level1.tscn")
const LEVEL_2 = preload("res://Scenes/level2.tscn")

@onready var menu: Control = $".."
@onready var grandpa = $"../../.." #ustawia gre ponad menu
@onready var score: Label = $score

@onready var bubble_sprite_skin: Sprite2D = $ReadyUp/Ready/PanelGracz1/TextureRect1
@onready var dolphine_sprite_skin: Sprite2D = $ReadyUp/Ready/PanelGracz2/TextureRect2

@onready var label_status: Label = $ReadyUp/LabelStatus
@onready var ready_up: Control = $ReadyUp
@onready var back_btn = $Back

@onready var lvl1_btn: TextureButton = $"VBoxContainer/1Level"
@onready var lvl2_btn: TextureButton = $"VBoxContainer/2Level"
@onready var lvl3_btn: TextureButton = $"VBoxContainer/3Level"

var bubble_aktualny_skin : int = 0
var bubble_max_skin : int = 1

var dolphine_aktualny_skin : int = 0
var dolphine_max_skin : int = 1

func _ready() -> void:
	back_btn.popped.connect(_on_back_popped)
	# Dla "bezpieczeństwa" (czyt. ktoś kliknie przycisk BACK) dodałem resetowanie się stanu przycisku od wyboru poziomów
	reset_level_buttons_visuals()

func _on_back_popped() -> void:
	# Ukrywa scenę
	visible = false
	
	# Resetujemy wizualia poziomów
	reset_level_buttons_visuals()
	
	back_btn.set_deferred("disabled", false) 
	back_btn.bubble_anim.play("idle")
	back_btn.start_floating()
	
	# Emitujemy sygnał do Main Menu
	closed.emit()

func _update_level_buttons_visuals(selected_btn: TextureButton) -> void:
	var buttons = [lvl1_btn, lvl2_btn, lvl3_btn]
	for btn in buttons:
		if btn == selected_btn:
			btn.modulate = Color(1.5, 1.5, 1.5, 1.0)
		else:
			btn.modulate = Color(0.4, 0.4, 0.4, 1.0)

func reset_level_buttons_visuals() -> void:
	Global.choosedLevel = null
	var buttons = [lvl1_btn, lvl2_btn, lvl3_btn]
	for btn in buttons:
		btn.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_level1_pressed() -> void:
	Global.choosedLevel = LEVEL_1
	_update_level_buttons_visuals(lvl1_btn)
	ready_up.sprawdz_czy_start()

func _on_level2_pressed() -> void:
	Global.choosedLevel = LEVEL_2
	_update_level_buttons_visuals(lvl2_btn)
	ready_up.sprawdz_czy_start()
	
func _on_level3_pressed() -> void:
	#Global.choosedLevel = LEVEL_3
	_update_level_buttons_visuals(lvl3_btn)
	ready_up.sprawdz_czy_start()

func _on_play_pressed() -> void:
	if Global.choosedLevel != null:
		var map = Global.choosedLevel.instantiate()
		grandpa.add_child(map)
		grandpa.move_child(map,0)
		visible = false
		menu.visible = false
		get_tree().paused = false

func game_start() -> void:
	if Global.choosedLevel != null:
		var map = Global.choosedLevel.instantiate()
		grandpa.add_child(map)
		grandpa.move_child(map,0)
		visible = false
		menu.visible = false
		get_tree().paused = false


func _on_reset_score_pressed() -> void:
	Global.save_data.bubble_score = 0
	Global.save_data.dolphin_score = 0
	Global.save_data.save()
	score.text = "Dolphine " + str(Global.save_data.dolphin_score) + " : " + str(Global.save_data.bubble_score) + " Bubble"


func bubble_skin_change():
	Global.bubble_skin = Global.bubble_skins_aaray[bubble_aktualny_skin]
	bubble_sprite_skin.texture = Global.bubble_skins_aaray[bubble_aktualny_skin]

func dolphine_skin_change():
	Global.dolphine_skin = Global.dolphine_skins_aaray[dolphine_aktualny_skin]
	dolphine_sprite_skin.texture = Global.dolphine_skins_aaray[dolphine_aktualny_skin]


func _on_bubble_skin_left_pressed() -> void:
	bubble_aktualny_skin -= 1
	if bubble_aktualny_skin < 0:
		bubble_aktualny_skin = bubble_max_skin
	bubble_skin_change()


func _on_bubble_skin_right_pressed() -> void:
	bubble_aktualny_skin += 1
	if bubble_aktualny_skin > bubble_max_skin:
		bubble_aktualny_skin = 0
	bubble_skin_change()


func _on_dolphine_skin_left_pressed() -> void:
	dolphine_aktualny_skin -= 1
	if dolphine_aktualny_skin < 0:
		dolphine_aktualny_skin = dolphine_max_skin
	dolphine_skin_change()


func _on_dolphine_skin_right_pressed() -> void:
	dolphine_aktualny_skin += 1
	if dolphine_aktualny_skin > dolphine_max_skin:
		dolphine_aktualny_skin = 0
	dolphine_skin_change()
