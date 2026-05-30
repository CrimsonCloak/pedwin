extends Node2D


var pedwin_prefab: PackedScene = preload("res://Scenes/pedwin.tscn")
@onready var path: Path2D = $Path2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.timeout.connect(spawn_enemy)

func spawn_enemy():
	path.add_child(pedwin_prefab.instantiate())
