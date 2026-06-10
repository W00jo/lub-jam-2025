extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func shake(moc):
	material.set_shader_parameter("hit_effect",moc)
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(material, "shader_parameter/hit_effect", 0, 0.5)
	
func flashbang(color):
	material.set_shader_parameter("hit_effect",1)
	material.set_shader_parameter("blink_color", color)
	material.set_shader_parameter("blink_intensity", 0.2)
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(material, "shader_parameter/hit_effect", 0, 0.5)
	tween.tween_property(material,"shader_parameter/blink_intensity",0, 0.5)

func flash(color1):
	material.set_shader_parameter("blink_color", color1)
	material.set_shader_parameter("blink_intensity", 0.2)
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(material,"shader_parameter/blink_intensity",0, 0.5)
