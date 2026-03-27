extends Node2D

@onready var collection_area = $CollectionArea

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy"):
		print("Wykryty chłop. Ewww :<")
		var guy = get_tree().get_first_node_in_group("BubbleGuy")
		guy.on_stinky()
		if Global.has_shield == false:
			print("URATOW-  EWWWW!!!")
			guy.on_stinky_shield()
			#Global.has_shield = true
			Global.guy_speed = 380
			queue_free()
	elif body.is_in_group("Dolphin"):
		print("Wykryty delfin. Mniam :3")
		var dolphin = get_tree().get_first_node_in_group("Dolphin")
		dolphin.on_stinky()
	queue_free()
