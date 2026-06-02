extends Control

const LEVEL_1 = preload("uid://dycaivlgy07q")
const LEVEL_2 = preload("uid://b8cumjm4mkugu")

@onready var menu: Control = $".."

@onready var grandpa = $"../../.." #ustawia gre ponad menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_level1_pressed() -> void:
	Global.choosedLevel = LEVEL_1

func _on_level2_pressed() -> void:
	Global.choosedLevel = LEVEL_2

func _on_back_pressed() -> void:
	visible = false

func _on_play_pressed() -> void:
	#get_tree().change_scene_to_file(Global.choosedLevel)
	
	var map = Global.choosedLevel.instantiate()
	grandpa.add_child(map)
	grandpa.move_child(map,0)
	visible = false
	menu.visible = false
	get_tree().paused = false
