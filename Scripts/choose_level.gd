extends Control

const LEVEL_1 = preload("uid://dycaivlgy07q")
const LEVEL_2 = preload("uid://b8cumjm4mkugu")

@onready var menu: Control = $".."

@onready var grandpa = $"../../.." #ustawia gre ponad menu
@onready var score: Label = $score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _on_level1_pressed() -> void:
	Global.choosedLevel = LEVEL_1

func _on_level2_pressed() -> void:
	Global.choosedLevel = LEVEL_2

func _on_back_pressed() -> void:
	visible = false

func _on_play_pressed() -> void:
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
