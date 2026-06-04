extends Node

@onready var audio = get_tree().root.get_node('Game/AudioStreamPlayer')

# Ładujemy oba utwory do pamięci od razu na starcie
var intro_music = preload("res://Assets/Sounds/Choochoo_spedup.mp3")
var loop_music = preload("res://Assets/Sounds/Simple Menu Music.mp3")

func _ready() -> void:
	# Sprawdzamy czy węzeł audio faktycznie istnieje, aby uniknąć crashy
	if audio:
		# Łączymy sygnał zakończenia utworu z naszą funkcją
		audio.finished.connect(_on_audio_finished)
		play_music_queue()
	else:
		push_error("Nie znaleziono węzła AudioStreamPlayer! Sprawdź ścieżkę.")

func play_music_queue() -> void:
	audio.stream = intro_music
	audio.play()

func play_music() -> void:
	audio.stream = loop_music
	audio.play()

# Ta funkcja wywoła się automatycznie w ułamku sekundy, w którym skończy się utwór
func _on_audio_finished() -> void:
	# Jeśli właśnie skończyło grać intro, przełączamy na muzykę z menu
	if audio.stream == intro_music:
		play_music()
