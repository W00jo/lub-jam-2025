extends Node2D


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Dolphin"):
		Global.has_bullet = true
		queue_free()
