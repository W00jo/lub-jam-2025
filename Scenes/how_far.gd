extends Path2D

@onready var znaczek: Sprite2D = $PathFollow2D/znaczek
@onready var path: PathFollow2D = $PathFollow2D
@onready var follow_path: PathFollow2D = $"../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	path.progress_ratio = follow_path.progress_ratio
