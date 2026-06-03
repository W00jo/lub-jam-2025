extends Node2D

@onready var camera: PathFollow2D = $PathForCamera/FollowPath
@onready var camera_speed_up: Area2D = $PathForCamera/FollowPath/Camera2D/camera_speed_up

var speed_up : float = 1   #Jak zbliży się do prawej cześci ekranu, ekran przyspiesza, 
						   #wartość podstawowa, zmienia się dopiero niżej


func _ready() -> void:
	var tween = get_tree().create_tween()     #Zwolnienie kamery na początku by odrazu nie zapierdalało
	tween.tween_property(camera,"progress", 70,3).set_ease(Tween.EASE_IN)
	add_to_group("Level")

func _process(delta: float) -> void:
	
	camera.progress += Global.camera_speed * speed_up * delta


func _on_camera_speed_up_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		speed_up += 0.2


func _on_camera_speed_up_body_exited(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		speed_up -= 0.2
