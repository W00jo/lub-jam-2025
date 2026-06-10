extends StaticBody2D

@export var fall_speed: float = 700  # Prędkość spadania obiektu


@onready var trigger_area: Area2D = $TriggerArea
@onready var collision_shape = $CollisionObstacle
@onready var sfx = $SFX
@onready var sprite: AnimatedSprite2D = $falling_obstacle_sprite

@onready var shake: ColorRect = $"../../../PathForCamera/FollowPath/Camera2D/Shake"

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	global_position.y += fall_speed * delta


# Funkcja wykrywająca graczy; triggeruje spadanie głazu
func _on_trigger_area_body_entered(body: Node2D) -> void:
	#trigger_area.disconnect("body_entered", Callable(self, "_on_trigger_area_body_entered")) # Disconnect signal
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		set_physics_process(true)
		sfx.play()
		sprite.play("falling")
		shake.shake(1)


func _on_ground_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Floor"):
		shake.shake(3)
		trigger_area.monitoring = false
		set_physics_process(false)
