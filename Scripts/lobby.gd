extends Control

var g1_gotowy: bool = false
var g2_gotowy: bool = false
var odliczanie_trwa: bool = false 

@onready var label_status_g1: Label = $Ready/PanelGracz1/LabelGotow1
@onready var label_status_g2: Label = $Ready/PanelGracz2/LabelGotow2
@onready var label_glowny_status: Label = $LabelStatus
@onready var choose_level: Control = $".."

var e_ready: String = "Press E when Ready"
var enter_ready: String = "Press ENTER when Ready"
var czekaj: String = "Waiting for Players..."


func _ready() -> void:
	reset_status()

func reset_status() -> void:
	g1_gotowy = false
	g2_gotowy = false
	odliczanie_trwa = false
	
	if label_status_g1:
		label_status_g1.text = e_ready
		label_status_g1.modulate = Color.WHITE
	if label_status_g2:
		label_status_g2.text = enter_ready
		label_status_g2.modulate = Color.WHITE
	if label_glowny_status:
		label_glowny_status.text = czekaj

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("BubbleReady"):
		g1_gotowy = !g1_gotowy
		if g1_gotowy:
			label_status_g1.text = "---Player 1 READY!---"
			label_status_g1.modulate = Color.GREEN
		else:
			label_status_g1.text = e_ready
			label_status_g1.modulate = Color.WHITE
		sprawdz_czy_start()

	if event.is_action_pressed("DolphinReady"):
		g2_gotowy = !g2_gotowy
		if g2_gotowy:
			label_status_g2.text = "-----Player 2 READY!-----"
			label_status_g2.modulate = Color.GREEN
		else:
			label_status_g2.text = enter_ready
			label_status_g2.modulate = Color.WHITE
		sprawdz_czy_start()

func sprawdz_czy_start() -> void:
	if g1_gotowy and g2_gotowy:
		if Global.choosedLevel != null:
			odliczanie_i_start()
		else:
			label_glowny_status.text = "Select a Level..."
	else:
		odliczanie_trwa = false 
		label_glowny_status.text = czekaj

func odliczanie_i_start() -> void:
	if odliczanie_trwa: 
		return 
		
	odliczanie_trwa = true
	
	for i in [3, 2, 1]:
		# BARDZO WAŻNE: Przerywamy odliczanie, jeśli ktoś anulował!
		if not (g1_gotowy and g2_gotowy) or not odliczanie_trwa:
			label_glowny_status.text = czekaj
			return
			
		label_glowny_status.text = "EVERYONE IS READY! STARTING IN " + str(i) + "..."
		await get_tree().create_timer(1.0).timeout
		
	# Bezpieczny start
	if g1_gotowy and g2_gotowy:
		label_glowny_status.text = "START!"
		reset_status() 
		
		if choose_level.has_method("game_start"): 
			choose_level.game_start()
