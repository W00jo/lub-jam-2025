extends Node2D

var boost_dolphin : Node2D
var boost_bubble : Node2D

var boost_bolphine_bool : bool = false
var boost_bubble_bool : bool = false


func _ready() -> void:
	#set_physics_process(false)
	pass

func _physics_process(delta: float) -> void:
	if boost_bolphine_bool == true:
		var push_dir = (boost_dolphin.global_position - global_position).normalized()
		boost_dolphin.velocity += push_dir * 1100 * delta
		
	if boost_bubble_bool == true:
		var push_dir = (boost_bubble.global_position - global_position).normalized()
		boost_bubble.velocity += push_dir * 1600 * delta


func _on_magnes_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy"):
		boost_bubble_bool = true
		boost_bubble = body
		set_physics_process(true)
		#atraction_buble = true
	elif body.is_in_group("Dolphin"):
		boost_bolphine_bool = true
		boost_dolphin = body
		set_physics_process(true)
		
func _on_magnes_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy"):
		boost_bubble_bool = false
	elif body.is_in_group("Dolphin"):
		boost_bolphine_bool = false
		
	if boost_bolphine_bool == false and boost_bubble_bool == false:
		set_physics_process(false)
