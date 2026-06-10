extends Sprite2D

func _ready() -> void:
	var rand_scale = randf_range(0.05,0.15)
	var rand_pos = randf_range(-50,50)
	scale = Vector2(rand_scale,rand_scale)
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self,"position",Vector2(global_position.x+rand_pos,global_position.y+rand_pos),1)
	tween.tween_property(self,"modulate",Color(0,0,0,0),1)
	await tween.finished
	queue_free()
