extends Node2D
var pedwin_prefab: PackedScene = preload("res://Scenes/pedwin.tscn")
@onready var path: Path2D = $Path2D
@onready var button: Button = $StartButton
var pedwin_wave_size: int
var gameManager
# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect (_button_pressed)
	gameManager = get_node("/root/Game/GameManager")
	pedwin_wave_size = gameManager.pedwins_per_wave

func _button_pressed():
	$SpawnTimer.timeout.connect(spawn_enemy)
	$SpawnTimer.start()
	set_pedwin_wave_text(pedwin_wave_size)
	button.disabled = true

func spawn_enemy():
	path.add_child(pedwin_prefab.instantiate())
	pedwin_wave_size -= 1
	set_pedwin_wave_text(pedwin_wave_size)
	if pedwin_wave_size == 0:
		$SpawnTimer.stop()
		set_victory_text()
		play_victory_music()
		
func set_pedwin_wave_text(wave_size_remaining):
	button.text = "Pedwin reinforcements: %d" % wave_size_remaining
	
	
func set_victory_text():
	button.text = "All reinforcements deployed!"
	# Set button to do a different function!
	button.pressed.connect (level_completed)
	button.disabled = false
	
func level_completed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") # TODO: replace with main menu return function
	

func play_victory_music():
	pass
