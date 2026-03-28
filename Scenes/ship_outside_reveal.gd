extends Sprite2D

func _on_ship_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color(0,0,0,0),1)
