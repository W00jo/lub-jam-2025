extends Node2D

@export var fall_speed: float = 350.0  #prędkość spadania obiektu

var is_falling: bool = false # Jeśli aktualnie spada

@onready var killbox: Area2D = $kill_box
@onready var trigger_area = $TriggerArea
@onready var self_destruct_timer = $SelfDestructTimer # Żeby nie spadał nieskończoną ilość czasu
@onready var sfx = $SFX



func _physics_process(delta: float) -> void:
	if is_falling:
		global_position.y += fall_speed * delta
		
# Funkcja wykrywająca ziutka w bąblu
func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("BubbleGuy"):
		print("Wykryty chłop. Leciii...")
		is_falling = true
		self_destruct_timer.start()
		sfx.play()
		
# Funkcja wykrywająca delfina i nabijająca mu guza
func _on_killbox_body_entered(body: Node2D) -> void:
	var dolphin = get_tree().get_first_node_in_group("Dolphin")
	add_to_group("FallingRock")
	if body == dolphin and is_falling == true:
		dolphin.on_bump_kill()
		print("Guzior nabity!")
		
# Funkcja znikająca kamień, po jego upadku
func _on_self_destruct_timer_timeout() -> void:
	queue_free()
