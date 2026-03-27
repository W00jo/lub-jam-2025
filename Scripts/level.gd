extends Node2D

@onready var camera = $Camera2D
@onready var side = $Side

var speed = 300


func _process(delta: float) -> void:
	camera.position += camera.transform.x * speed * delta
	side.position += side.transform.x * speed * delta
	pass
