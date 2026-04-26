extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_pocztek_animacji_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("BubbleGuy"):
		animation_player.play("Zrzut")


func _on_win_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("BubbleGuy"):
		animation_player.play("Wciag")
		guy_up()
		await animation_player.animation_finished
		Global.guy_saved = true
		Global.guy_win()

func guy_up():
	var bubble_guy = get_tree().get_first_node_in_group("BubbleGuy")
	bubble_guy.bubble_win(rotation)
