extends Node2D


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("BubbleGuy") && Global.has_shield == false):
		print("URATOWANY")
		var guy = get_tree().get_first_node_in_group("BubbleGuy")
		guy.on_got_shield()
		#Global.has_shield = true
		if guy.close_to_death == false: 
			Global.guy_speed -= 100
		else:
			guy.close_to_death = false
			Global.guy_speed -= 200
		queue_free()
