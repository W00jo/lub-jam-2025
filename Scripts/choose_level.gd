extends Control

signal closed

const LEVEL_1 = preload("uid://dycaivlgy07q")
const LEVEL_2 = preload("uid://b8cumjm4mkugu")

@onready var menu: Control = $".."

@onready var grandpa = $"../../.." #ustawia gre ponad menu
@onready var score: Label = $score

@onready var bubble_sprite_skin: Sprite2D = $ReadyUp/Ready/PanelGracz1/TextureRect1
@onready var dolphine_sprite_skin: Sprite2D = $ReadyUp/Ready/PanelGracz2/TextureRect2

@onready var label_status: Label = $ReadyUp/LabelStatus
@onready var ready_up: Control = $ReadyUp

@onready var back_btn = $Back

var bubble_aktualny_skin : int = 0
var bubble_max_skin : int = 1

var dolphine_aktualny_skin : int = 0
var dolphine_max_skin : int = 1

func _ready() -> void:
	back_btn.popped.connect(_on_back_pressed)

func _on_level1_pressed() -> void:
	Global.choosedLevel = LEVEL_1
	ready_up.sprawdz_czy_start()

func _on_level2_pressed() -> void:
	Global.choosedLevel = LEVEL_2
	ready_up.sprawdz_czy_start()
	
func _on_level3_pressed() -> void:
	#Global.choosedLevel = LEVEL_3
	ready_up.sprawdz_czy_start()

func _on_back_pressed() -> void:
	closed.emit()
	visible = false


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
