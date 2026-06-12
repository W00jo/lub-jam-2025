extends Node2D

var direction : float = 0

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	position.x += 100 * delta
	position.y += direction * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy"):
		print("Wykryty chłop. Ewww :<")
		var guy = get_tree().get_first_node_in_group("BubbleGuy")
		guy.on_stinky()
		if Global.has_shield == false:
			print("URATOW-  EWWWW!!!")
			guy.on_stinky_shield()
			#Global.has_shield = true
			#Global.guy_speed -= 100
			queue_free()
	elif body.is_in_group("Dolphin"):
		print("Wykryty delfin. Mniam :3")
		var dolphin = get_tree().get_first_node_in_group("Dolphin")
		dolphin.on_stinky()
	queue_free()


func _on_change_timeout() -> void:
	direction = randf_range(-100,100)


func _on_for_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		set_physics_process(true)
		$change.start()
