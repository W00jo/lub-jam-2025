extends ParallaxBackground

@onready var cave: ParallaxLayer = $cave
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(cave, "rotation", deg_to_rad(5), 5.0)
	timer.wait_time = 30


func _on_timer_2_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(cave, "rotation", deg_to_rad(0), 10.0)
	tween.tween_property(cave, "rotation", deg_to_rad(-10), 3.0)
