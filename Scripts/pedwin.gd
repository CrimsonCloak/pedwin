extends PathFollow2D
@export var speed: float = 100.0
@export var maxHealth: int = 2
@onready var health: int = maxHealth

signal healthChanged # For later
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	progress += delta * speed
	if progress_ratio >= 1.0:
		queue_free()
		
func update_health():
	var currentHealthPercentage = health / maxHealth
