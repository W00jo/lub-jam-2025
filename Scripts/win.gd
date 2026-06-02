extends Control

@onready var game = get_tree().root.get_node('Game')
@onready var win_texture = $WinTexture
@onready var punktacja: Label = $VBoxContainer/punktacja

func _ready() -> void:
	punktacja.text = "Dolphine ma " + str(Global.dolphin_score) + str(Global.bubble_score) + " : ma Bubble"
	if Global.dolphin_dead == true or Global.guy_saved == true:
		win_texture.texture = preload("res://Assets/Sprites/Menu/win_bubble_guy.png")
	if Global.guy_dead == true:
		win_texture.texture = preload("res://Assets/Sprites/Menu/win_dolphin.png")
	$VBoxContainer/Restart.grab_focus()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	Global.on_restart()
	queue_free()


func _on_menu_pressed() -> void:
	get_tree().get_first_node_in_group("Level").queue_free()
	$"../../MenuLayer/Menu".visible = true
	queue_free()
	
