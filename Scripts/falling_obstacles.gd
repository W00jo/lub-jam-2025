extends StaticBody2D

@export var fall_speed: float = 500  # Prędkość spadania obiektu

var is_falling: bool = false # Jeśli aktualnie spada
var has_landed: bool = false # Czy już dotknął "Floor"

@onready var killbox = $Killbox
@onready var trigger_area: Area2D = $TriggerArea
@onready var collision_shape = $CollisionObstacle
@onready var sfx = $SFX
@onready var sprite: AnimatedSprite2D = $falling_obstacle_sprite

func _ready():
	# Killbox i Collision_Obstacle domyślnie są wyłączone
	killbox.monitoring = false
	collision_shape.disabled = true

func _physics_process(delta: float) -> void:
	if is_falling:
		global_position.y += fall_speed * delta
		
	if has_landed and collision_shape != null:
		if collision_shape.disabled == true:
			print("enabled collision...")
			collision_shape.disabled = false

# Funkcja wykrywająca graczy; triggeruje spadanie głazu
func _on_trigger_area_body_entered(body: Node2D) -> void:
	trigger_area.disconnect("body_entered", Callable(self, "_on_trigger_area_body_entered")) # Disconnect signal
	
	if body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		print("Wykryty gracza/czy")
		is_falling = true
		killbox.monitoring = true
		sfx.play()
		sprite.play("falling")

func _on_killbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Floor"):
		is_falling = false
		has_landed = true
		_disable_killbox()
	elif body.is_in_group("BubbleGuy") or body.is_in_group("Dolphin"):
		print ("AUĆ")
	
func _disable_killbox():
	sprite.play("down")
	set_deferred("killbox.monitoring", false)
	killbox.collision_layer = 0
	killbox.collision_mask = 0
