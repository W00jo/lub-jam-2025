extends Node2D


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("BubbleGuy") && Global.has_shield == false):
		print("URATOWANY")
		var guy = get_tree().get_first_node_in_group("BubbleGuy")
		guy.on_got_shield()
		#Global.has_shield = true
		Global.guy_speed = 380
		queue_free()
