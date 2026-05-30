extends Node2D


var pedwin_prefab: PackedScene = preload("res://Scenes/pedwin.tscn")
@onready var path: Path2D = $Path2D
@onready var button: Button = $StartButton

# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect (_button_pressed)

func _button_pressed():
	$SpawnTimer.timeout.connect(spawn_enemy)
	$SpawnTimer.start()
	button.queue_free()

func spawn_enemy():
	path.add_child(pedwin_prefab.instantiate())

	
