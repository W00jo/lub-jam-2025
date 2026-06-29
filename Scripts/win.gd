extends Control

@onready var game = get_tree().root.get_node('Game')
@onready var punktacja: Label = $punktacja
@onready var w_delfin: Label = $WygranyDelfin
@onready var w_ziutek: Label = $WygranyZiutek
@onready var dolphine: Sprite2D = $WygranyDelfin/dolphine
@onready var bubble: Sprite2D = $WygranyZiutek/bubble

func _ready() -> void:
	punktacja.text = "Dolphin : " + str(Global.save_data.dolphin_score) + " 
	Bubble : " + str(Global.save_data.bubble_score)
	if Global.dolphin_dead == true or Global.guy_saved == true:
		w_delfin.visible = false
		w_ziutek.visible = true
		bubble.texture = Global.bubble_skin
		
	if Global.guy_dead == true:
		w_delfin.visible = true
		w_ziutek.visible = false
		dolphine.texture = Global.dolphine_skin
		
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
	
