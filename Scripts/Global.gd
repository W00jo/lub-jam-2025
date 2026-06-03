extends Node

@onready var win = preload("res://Scenes/win.tscn")
@onready var win_layer = get_tree().root.get_node('Game/WinLayer')


@onready var game = get_tree().root.get_node('Game')
@onready var level = preload("res://Scenes/level1.tscn")

var has_bullet: bool = false

var has_shield: bool = true

var guy_dead: bool = false
var dolphin_dead: bool = false

var guy_speed = 380
var dolphin_speed = 370
var camera_speed = 200


var guy_saved = false




var choosedLevel

var save_data:SaveData

func _ready() -> void:
	save_data = SaveData.load_or_create()
	
func dolphin_win():
	if get_tree().paused == false:
		get_tree().paused = true
		save_data.dolphin_score += 1
		save_data.save()
		var splash_win = win.instantiate()
		win_layer.add_child(splash_win)
		Audio.game_music = preload("res://Assets/Sounds/Dolfinus wygrywa dźwięk.mp3")
		Audio.play_music()
	
func guy_win():
	if get_tree().paused == false:
		get_tree().paused = true
		save_data.bubble_score += 1
		save_data.save()
		var splash_win = win.instantiate()
		win_layer.add_child(splash_win)
		Audio.game_music = preload("res://Assets/Sounds/Bubbloczłek Wygrywa.mp3")
		Audio.play_music()


func on_restart():
	get_tree().get_first_node_in_group("Level").queue_free() 
	var reloaded_level = choosedLevel.instantiate()
	#reloaded_level.add_to_group("Level")
	game.add_child(reloaded_level)
	game.move_child(reloaded_level,0)
	get_tree().paused = false
	
	
	Audio.game_music = preload("res://Assets/Sounds/Banger.mp3")
	Audio.play_music()
	has_bullet = true
	has_shield = true
	guy_dead = false
	dolphin_dead = false
	guy_speed = 380
	dolphin_speed = 370
