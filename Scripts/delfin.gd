extends CharacterBody2D

@onready var game = get_tree().root.get_node('Game')
@onready var falling_rock = get_tree().get_first_node_in_group("FallingRock")
@onready var stinky_bubble = get_tree().get_first_node_in_group("StinkyBubble")
@onready var anim_tree = $AnimationTree
@onready var sfx = $SFX
@onready var dolphin_sprite = $Sprite2D
@onready var dymek = $DymekMniam
var tween: Tween
var tween_dymek: Tween

func _ready() -> void:
	add_to_group("Dolphin")
	#stinky_bubble.connect("stinky_mniam", on_stinky)

func _process(_delta):
	if game.INPUT_SCHEME == game.INPUT_SCHEMES.KEYBOARD_AND_MOUSE:
		var mouse_position = get_global_mouse_position()
		if mouse_position.x > position.x:
			$Sprite2D.set_flip_h(false)
		elif mouse_position.x < position.x:
			$Sprite2D.set_flip_h(true)
	
	elif game.INPUT_SCHEME == game.INPUT_SCHEMES.GAMEPAD:
		if Input.get_action_strength("aim_right"):
			$Sprite2D.set_flip_h(false)
		elif Input.get_action_strength("aim_left"):
			$Sprite2D.set_flip_h(true)

func _physics_process(_delta: float) -> void:
	var speed = Global.dolphin_speed
	var direction = Input.get_vector("DolphinLeft", "DolphinRight", "DolphinUp", "DolphinDown").normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity = velocity * 0.97
	move_and_slide()
	

func on_bump_kill():
	print("on bump kill")
	anim_tree["parameters/conditions/dead"] = true
	sfx.play()
	await anim_tree.animation_finished
	Global.dolphin_dead = true
	Global.guy_win()

func on_stinky():
	print("mniam :333")
	tween = create_tween()
	tween_dymek = create_tween()
	tween_dymek.tween_property(dymek, "scale", Vector2(1,1), 0.5)
	tween.tween_property(dolphin_sprite, "modulate", Color.DEEP_PINK, 0.5)
	tween.finished.connect(turn_pink)
	tween_dymek.finished.connect(dymek_show)

func turn_pink():
	print("should be pink")
	dolphin_sprite.set_modulate(Color.DEEP_PINK)
	Global.dolphin_speed = 420
	await get_tree().create_timer(4).timeout
	tween = create_tween()
	tween.tween_property(dolphin_sprite, "modulate" , Color.WHITE, 0.5)
	await tween.finished
	dolphin_sprite.set_modulate(Color.WHITE)
	Global.dolphin_speed = 370


func dymek_show():
	print("dymek mniam")
	dymek.set_scale(Vector2(1,1))
	await get_tree().create_timer(1.5).timeout
	tween_dymek = create_tween()
	tween_dymek.tween_property(dymek, "scale", Vector2(0,0), 0.5)
	await tween_dymek.finished
	dymek.set_scale(Vector2(0,0))
