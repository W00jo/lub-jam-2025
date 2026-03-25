extends Sprite2D
var ruch = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if ruch == true:
		position.x -= 1
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("BubbleGuy"):
		ruch = true
