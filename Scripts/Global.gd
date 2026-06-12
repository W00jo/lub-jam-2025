extends Node

@onready var win = preload("res://Scenes/win.tscn")
@onready var win_layer = get_tree().root.get_node('Game/WinLayer')


@onready var game = get_tree().root.get_node('Game')
@onready var level = preload("res://Scenes/level1.tscn")


###Bubble Skins
const BUBBLE_BLACK = preload("res://Assets/Sprites/Characters/Bubble_guy/bubble_black.png")
const BUBBLE_NORMAL = preload("res://Assets/Sprites/Characters/Bubble_guy/bubble_normal.png")

###Dolphine Skins
const DOLPHINE_NORMAL = preload("res://Assets/Sprites/Characters/Dolphin/dolphine_normal.png")
const DOLPHINE_GAY = preload("res://Assets/Sprites/Characters/Dolphin/dolphine_gay.png")

#Nowe skiny dodajemy do tego aaraya
var bubble_skins_aaray = [BUBBLE_NORMAL, BUBBLE_BLACK]
var dolphine_skins_aaray = [DOLPHINE_NORMAL, DOLPHINE_GAY]

var bubble_skin = BUBBLE_NORMAL

var dolphine_skin = DOLPHINE_NORMAL
var dolphine_arm_skin = DOLPHINE_NORMAL

#skins

var has_bullet: bool = false

var has_shield: bool = true

var guy_dead: bool = false
var dolphin_dead: bool = false

# Trzeba pamietac o zmianie w dwoch miejscach
# TODO: Dodać zmienną która jest bazowa predkoscia, a potem zmienna ktora jest bazowa predkosc + modyfiaktor
var base_guy_speed = 450
var base_dolphine_speed = 450
var base_camera_speed = 340

var guy_speed = 450
var dolphin_speed = 450
var camera_speed = 340

#Stare wartości = 380,370,200

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
	guy_speed = base_guy_speed
	dolphin_speed = base_dolphine_speed
	camera_speed = base_camera_speed
