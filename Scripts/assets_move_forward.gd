extends AnimatedSprite2D

@export var kierunek : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)



func _process(delta: float) -> void:
		position.x -= 100 * delta * kierunek


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("BubbleGuy"):
		set_process(true)
