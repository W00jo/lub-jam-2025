extends Node2D

var speed = 800

func _process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_life_time_timeout() -> void:
	queue_free()
