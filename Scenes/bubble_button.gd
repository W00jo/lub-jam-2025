extends Button
class_name BubbleButton

signal popped 

@onready var bubble_anim: AnimatedSprite2D = $BubbleButton

var base_y: float
var float_tween: Tween

func _ready() -> void:
	base_y = position.y
	
	bubble_anim.play("idle")
	start_floating()
	
	pressed.connect(_on_button_pressed)
	bubble_anim.animation_finished.connect(_on_animation_finished)

func start_floating() -> void:
	float_tween = create_tween().set_loops()
	
	float_tween.tween_property(self, "position:y", base_y - 10.0, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
		
	float_tween.tween_property(self, "position:y", base_y, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

func _on_button_pressed() -> void:
	disabled = true 
	
	if float_tween:
		float_tween.kill()
		
	bubble_anim.play("pop")

func _on_animation_finished() -> void:
	if bubble_anim.animation == "pop":
		popped.emit()
		bubble_anim.play("idle")
		disabled = false
