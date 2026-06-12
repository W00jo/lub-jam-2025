extends Control

# Stan gotowości
var g1_gotowy: bool = false
var g2_gotowy: bool = false
var gra_wystartowala: bool = false #
# Pobieranie węzłów UI

@onready var label_status_g1: Label = $Ready/PanelGracz1/LabelGotow1
@onready var label_status_g2: Label = $Ready/PanelGracz2/LabelGotow2
@onready var label_glowny_status = $LabelStatus
@onready var choose_level: Control = $".."


func _ready():
	if label_status_g1:
		label_status_g1.text = "Kliknij E, aby być gotowym"
	if label_status_g2:
		label_status_g2.text = "Kliknij ENTER, aby być gotowym"
	if label_glowny_status:
		label_glowny_status.text = "Czekanie na graczy..."


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("BubbleReady"):
		g1_gotowy = !g1_gotowy
		if g1_gotowy:
			if label_status_g1:
				label_status_g1.text = "-----Gracz 1 GOTOWY!----"
				label_status_g1.modulate = Color.GREEN
		else:
			if label_status_g1:
				label_status_g1.text = "Kliknij E, aby być gotowym"
				label_status_g1.modulate = Color.WHITE
		sprawdz_czy_start()


	if event.is_action_pressed("DolphinReady"):
		g2_gotowy = !g2_gotowy
		if g2_gotowy:
			if label_status_g2:
				label_status_g2.text = "------Gracz 2 GOTOWY!------"
				label_status_g2.modulate = Color.GREEN
		else:
			if label_status_g2: 
				label_status_g2.text = "Kliknij ENTER, aby być gotowym"
				label_status_g2.modulate = Color.WHITE
		sprawdz_czy_start()

func sprawdz_czy_start():
	if g1_gotowy and g2_gotowy:
		if Global.choosedLevel != null:
			gra_wystartowala = true 
			odliczanie_i_start()
		else:
			label_glowny_status.text = "Wybierz Level..."
	else:
		label_glowny_status.text = "Czekanie na graczy..."

func odliczanie_i_start():
	if Global.choosedLevel != null:
		for i in [3, 2, 1]:
			label_glowny_status.text = "WSZYSCY GOTOWI! START ZA " + str(i) + "..."
			await get_tree().create_timer(1.0).timeout
			label_glowny_status.text = "START!"
			if g1_gotowy == false or g2_gotowy == false:
				label_glowny_status.text = "Czekanie na graczy..."
				return
		label_status_g2.text = "Kliknij ENTER, aby być gotowym"
		label_status_g2.modulate = Color.WHITE
		label_status_g1.text = "Kliknij E, aby być gotowym"
		label_status_g1.modulate = Color.WHITE
		label_glowny_status.text = "Czekanie na graczy..."
		g1_gotowy = false
		g2_gotowy = false
		choose_level.game_start()
