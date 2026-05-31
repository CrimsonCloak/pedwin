extends TextureProgressBar
@export var pedwin: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pedwin.healthChanged.connect(updateHealth)
	#updateHealth()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateHealth():
	value = pedwin.health * 100 / pedwin.maxHealth
	print("Update health ran! Value: " + str(value) )
	print("Pedwin Health:" + str(pedwin.health))
	print("Pedwin MaxHealth:" + str(pedwin.maxHealth))
