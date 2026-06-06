extends Node2D
var pedwin_prefab: PackedScene = preload("res://Scenes/pedwin.tscn")
@onready var path: Path2D = $Path2D
@onready var button: Button = $StartButton
var pedwin_wave_size: int
var game_manager
var victory_conditions_met: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect (_button_pressed)
	game_manager = get_node("/root/Game/GameManager")
	pedwin_wave_size = game_manager.pedwins_per_wave

func _button_pressed():
	$SpawnTimer.timeout.connect(spawn_enemy)
	$SpawnTimer.start()
	set_pedwin_wave_text(pedwin_wave_size)
	button.disabled = true

func _process(delta: float) -> void:
	check_victory_condition()

func spawn_enemy():
	path.add_child(pedwin_prefab.instantiate())
	pedwin_wave_size -= 1
	set_pedwin_wave_text(pedwin_wave_size)
	if pedwin_wave_size == 0:
		$SpawnTimer.stop()
		
		if game_manager.pedwins_alive == 0:
			victory()
			play_victory_music()
		
func set_pedwin_wave_text(wave_size_remaining):
	button.text = "Pedwin reinforcements: %d" % wave_size_remaining
	if pedwin_wave_size == 0:
		button.text = "All reinforcements deployed!"

func check_victory_condition():
	if pedwin_wave_size == 0 && game_manager.pedwins_alive == 0:
		victory_conditions_met = true
	if victory_conditions_met:
		victory()

func victory():
	button.text = "Pedwins defeated!"
	# Set button to do a different function!
	button.pressed.connect (level_completed)
	button.disabled = false
	
func level_completed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") # TODO: replace with main menu return function
	

func play_victory_music():
	pass
