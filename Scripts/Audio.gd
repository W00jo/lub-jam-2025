extends Node


@onready var audio = get_tree().root.get_node('Game/AudioStreamPlayer')
@onready var game_music = preload("res://Assets/Sounds/Choochoo_spedup.mp3")

func _ready() -> void:
	play_music_queue()

func play_music_queue():
	audio.stream = game_music
	audio.play()
	await get_tree().create_timer(3.5).timeout
	game_music = preload("res://Assets/Sounds/Simple Menu Music.mp3")
	audio.stream = game_music
	audio.play()

func play_music():
	audio.stream = game_music
	audio.play()
