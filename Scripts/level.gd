extends Node2D

@onready var camera = $Camera2D
@onready var camera_speed_up: Area2D = $Camera2D/camera_speed_up
var speed_up : float = 1   #Jak zbliży się do prawej cześci ekranu, ekran przyspiesza, 
						   #wartość podstawowa, zmienia się dopiero niżej

var speed = 300

func _ready() -> void:
	var tween = get_tree().create_tween()     #Zwolnienie kamery na początku by odrazu nie zapierdalało
	tween.tween_property(camera,"position", Vector2(1500,540),3).set_ease(Tween.EASE_IN)

func _process(delta: float) -> void:
	camera.position += camera.transform.x * speed * speed_up * delta


func _on_camera_speed_up_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		speed_up += 0.2


func _on_camera_speed_up_body_exited(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		speed_up -= 0.2
