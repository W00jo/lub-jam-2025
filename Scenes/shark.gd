extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= 500 * delta


func _on_start_move_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		set_process(true)


func _on_dmg_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Dolphin"):
		var dolphin = get_tree().get_first_node_in_group("Dolphin")
		dolphin.on_bump_kill()
	elif body.is_in_group("BubbleGuy"):
		var bubble = get_tree().get_first_node_in_group("BubbleGuy")
		bubble.death()


func _on_stop_move_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		queue_free()
