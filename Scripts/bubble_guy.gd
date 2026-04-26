extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var shield_bubble = get_tree().get_first_node_in_group("ShieldBubble")
@onready var short_on_air = $ShortOnAir
@onready var die_no_air = $DieNoAir
@onready var sfx = $SFX
@onready var guy_sprite = $Guy
@onready var dymek = $DymekEw
var tween: Tween
var tween_dymek: Tween

func _ready() -> void:
	add_to_group("BubbleGuy")
	#shield_bubble.connect("got_shield", on_got_shield)
	anim_tree["parameters/conditions/Idle"] = true


func _physics_process(_delta: float) -> void:
	var speed = Global.guy_speed
	var direction = Input.get_vector("BubbleLeft", "BubbleRight", "BubbleUp", "BubbleDown").normalized()
	if direction:
		anim_tree["parameters/conditions/Idle"] = false
		anim_tree["parameters/conditions/Swim"] = true
		velocity = direction * speed
	else:
		anim_tree["parameters/conditions/Swim"] = false
		anim_tree["parameters/conditions/Idle"] = true
		velocity = velocity * 0.97
	move_and_slide()

	
func _on_shield_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		anim_tree["parameters/conditions/Break_Bubble"] = true
		sfx.play()
		await get_tree().create_timer(1).timeout
		short_on_air.start()
		print("Wykryty chłop. KŁUJ")
		Global.has_shield = false
		Global.guy_speed = 250
		await get_tree().create_timer(0.5).timeout
		anim_tree["parameters/conditions/Break_Bubble"] = false

func on_got_shield():
	Global.has_shield = true
	anim_tree["parameters/conditions/Get_Bubble"] = true
	short_on_air.stop()
	die_no_air.stop()
	await get_tree().create_timer(0.5).timeout
	anim_tree["parameters/conditions/Get_Bubble"] = false

func _on_short_on_air_timeout() -> void:
	Global.guy_speed = 420
	anim_tree["parameters/conditions/Close_To_Death"] = true
	die_no_air.start()

func _on_die_no_air_timeout() -> void:
	anim_tree["parameters/conditions/Death_NoAir"] = true
	await anim_tree.animation_finished
	Global.guy_dead = true
	Global.dolphin_win()
 

func _on_body_area_area_entered(area: Area2D) -> void:
	if Global.has_shield == false:
		if area.is_in_group("Bullet"):
			anim_tree["parameters/conditions/Death"] = true
			await anim_tree.animation_finished
			Global.guy_dead = true
			Global.dolphin_win()

func on_stinky():
	print("stinkyyyyy")
	tween = create_tween()
	tween_dymek = create_tween()
	tween_dymek.tween_property(dymek, "scale", Vector2(1.5, 1.5), 0.5)
	tween.tween_property(guy_sprite, "modulate", Color.WEB_GREEN, 0.5)
	tween.finished.connect(turn_green)
	tween_dymek.finished.connect(dymek_show)


func turn_green():
	print("should be green")
	guy_sprite.set_modulate(Color.WEB_GREEN)
	Global.guy_speed = 280
	await get_tree().create_timer(4).timeout
	tween = create_tween()
	tween.tween_property(guy_sprite, "modulate" , Color.WHITE, 0.5)
	await tween.finished
	guy_sprite.set_modulate(Color.WHITE)
	Global.guy_speed = 380


func dymek_show():
	print("dymek eww")
	dymek.set_scale(Vector2(1.5, 1.5))
	await get_tree().create_timer(1.5).timeout
	tween_dymek = create_tween()
	tween_dymek.tween_property(dymek, "scale", Vector2(0,0), 0.5)
	await tween_dymek.finished
	dymek.set_scale(Vector2(0,0))
	

func on_stinky_shield():
	on_got_shield()
	
func bubble_win(upright):
	var x = global_position.x
	var y = global_position.y
	if upright == 0: #Sprawdza w którą strone wędka zwycieska patrzy i daje animacje bublowy w która strone ma lecieć
	
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(x+1500,y+50), 1)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(x+1500,y+50), 1)
	set_process(false)
