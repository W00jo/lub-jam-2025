extends Node2D

@onready var camera: PathFollow2D = $PathForCamera/FollowPath
@onready var camera_speed_up: Area2D = $PathForCamera/FollowPath/Camera2D/camera_speed_up
@onready var player_slowdown: Area2D = $PathForCamera/FollowPath/Camera2D/player_slowdown

var speed_up : float = 1   #Jak zbliży się do prawej cześci ekranu, ekran przyspiesza, 
						   #wartość podstawowa, zmienia się dopiero niżej
@onready var debugger: Label = $PathForCamera/FollowPath/Camera2D/Label


func _ready() -> void:
	Audio.game_music = preload("res://Assets/Sounds/Banger.mp3")
	Audio.play_music()
	var tween = get_tree().create_tween()     #Zwolnienie kamery na początku by odrazu nie zapierdalało
	tween.tween_property(camera,"progress", 70,3).set_ease(Tween.EASE_IN)
	add_to_group("Level")

func _process(delta: float) -> void:
	camera.progress += Global.camera_speed * speed_up * delta
	debugger.text = "Guy" + str(Global.guy_speed) +"
	" + "Dolphin" + str(Global.dolphin_speed) +"
	" + "camera" + str(speed_up)


func _on_camera_speed_up_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		speed_up += 0.2


func _on_camera_speed_up_body_exited(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		speed_up -= 0.2


func _on_player_slowdown_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy"):
		Global.guy_speed -= 300
		await get_tree().create_timer(1).timeout
		Global.guy_speed += 300
	elif body.is_in_group("Dolphin"):
		Global.dolphin_speed -= 300
		await get_tree().create_timer(1).timeout
		Global.dolphin_speed += 300
