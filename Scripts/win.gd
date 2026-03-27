extends Control

@onready var game = get_tree().root.get_node('Game')
@onready var win_texture = $WinTexture


func _ready() -> void:
	if Global.dolphin_dead == true or Global.guy_saved == true:
		win_texture.texture = preload("uid://b05n3hoxujrd7")
	if Global.guy_dead == true:
		win_texture.texture = preload("uid://kdoaqnl3fam5")
	$Restart.grab_focus()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	Global.on_restart()
	queue_free()
