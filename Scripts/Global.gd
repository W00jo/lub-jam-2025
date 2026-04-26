extends Node

@onready var win = preload("res://Scenes/win.tscn")
@onready var win_layer = get_tree().root.get_node('Game/WinLayer')
@onready var game = get_tree().root.get_node('Game')
@onready var level = preload("res://Scenes/level.tscn")

var has_bullet: bool = false

var has_shield: bool = true

var guy_dead: bool = false
var dolphin_dead: bool = false

var guy_speed = 380
var dolphin_speed = 370

var guy_saved = false


func dolphin_win():
	if get_tree().paused == false:
		get_tree().paused = true
		var splash_win = win.instantiate()
		win_layer.add_child(splash_win)
		Audio.game_music = preload("res://Assets/Sounds/Dolfinus wygrywa dźwięk.mp3")
		Audio.play_music()
	
func guy_win():
	if get_tree().paused == false:
		get_tree().paused = true
		var splash_win = win.instantiate()
		win_layer.add_child(splash_win)
		splash_win.get_node('Restart').grab_focus()
		Audio.game_music = preload("res://Assets/Sounds/Bubbloczłek Wygrywa.mp3")
		Audio.play_music()
	
func on_restart():
	get_tree().get_first_node_in_group("Level").queue_free()
	var reloaded_level = level.instantiate()
	reloaded_level.add_to_group("Level")
	game.add_child(reloaded_level)
	Audio.game_music = preload("res://Assets/Sounds/Banger.mp3")
	Audio.play_music()
	has_bullet = true
	has_shield = true
	guy_dead = false
	dolphin_dead = false
	guy_speed = 380
	dolphin_speed = 370
