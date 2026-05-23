extends Control

# Stan gotowości
var g1_gotowy: bool = false
var g2_gotowy: bool = false
var gra_wystartowala: bool = false #
# Pobieranie węzłów UI
@onready var label_status_g1 = $HBoxContainer/PanelGracz1/LabelGotow1
@onready var label_status_g2 = $HBoxContainer/PanelGracz2/LabelGotow2
@onready var label_glowny_status = $LabelStatus

# Węzły bąbelków
@onready var warstwa_babelkow = $bubbles_transition
@onready var animacja_babelkow = $bubbles_transition/AnimatedSprite2D

func _ready():
	if label_status_g1:
		label_status_g1.text = "Kliknij G, aby być gotowym"
	if label_status_g2:
		label_status_g2.text = "Kliknij ENTER, aby być gotowym"
	if label_glowny_status:
		label_glowny_status.text = "Czekanie na graczy..."
		
	if warstwa_babelkow:
		warstwa_babelkow.visible = false

func _input(event):
	if gra_wystartowala:
		return

	if event.is_action_pressed("g1_gotow"):
		g1_gotowy = !g1_gotowy
		if g1_gotowy:
			if label_status_g1:
				label_status_g1.text = "Gracz 1 GOTOWY!"
				label_status_g1.modulate = Color.GREEN
		else:
			if label_status_g1:
				label_status_g1.text = "Kliknij G, aby być gotowym"
				label_status_g1.modulate = Color.WHITE
		sprawdz_czy_start()

	if event.is_action_pressed("g2_gotow"):
		g2_gotowy = !g2_gotowy
		if g2_gotowy:
			if label_status_g2:
				label_status_g2.text = "Gracz 2 GOTOWY!"
				label_status_g2.modulate = Color.GREEN
		else:
			if label_status_g2:
				label_status_g2.text = "Kliknij ENTER, aby być gotowym"
				label_status_g2.modulate = Color.WHITE
		sprawdz_czy_start()

func sprawdz_czy_start():
	if g1_gotowy and g2_gotowy:
		gra_wystartowala = true 
		odliczanie_i_start()
	else:
		if label_glowny_status:
			label_glowny_status.text = "Czekanie na graczy..."

func odliczanie_i_start():
	for i in [3, 2, 1]:
		if label_glowny_status:
			label_glowny_status.text = "WSZYSCY GOTOWI! START ZA " + str(i) + "..."
		
		await get_tree().create_timer(1.0).timeout
	
	if label_glowny_status:
		label_glowny_status.text = "START!"
	
	if warstwa_babelkow and animacja_babelkow:
		warstwa_babelkow.visible = true
		
		animacja_babelkow.play("default")
		
		# Czekamy aż animacja w pełni się odtworzy
		await animacja_babelkow.animation_finished
		
	# Zmiana sceny
	get_tree().change_scene_to_file("res://game.tscn")
