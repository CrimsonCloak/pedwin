extends Node2D
var pedwin_prefab: PackedScene = preload("res://Scenes/pedwin.tscn")
@onready var path: Path2D = $Path2D
@onready var button: Button = $StartButton
@onready var wave_info
var pedwin_wave_size: int
var game_manager
var victory_conditions_met: bool
const WAVE_INFO_FILE = "res://Scenes/Levels/Leveldata/demolevel_waves.json"
var wave_data_dict

# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect (_button_pressed)
	game_manager = get_node("/root/Game/GameManager")
	pedwin_wave_size = game_manager.pedwins_per_wave
	read_wave_data()
	calculate_wave_amount()
func _button_pressed():
	$SpawnTimer.timeout.connect(spawn_enemy)
	$SpawnTimer.start()
	set_pedwin_wave_text(pedwin_wave_size)
	button.disabled = true

func _process(delta: float) -> void:
	if !victory_conditions_met:
		check_victory_condition()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		game_manager.pause_menu()

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
		victory()

func victory():
	button.text = "Pedwins defeated!"
	# Set button to do a different function!
	button.pressed.connect (level_completed)
	button.disabled = false

func level_completed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") # TODO: replace with main menu return function
	
func read_wave_data():
		var wave_info_file = FileAccess.open(WAVE_INFO_FILE,FileAccess.READ)
		var json = JSON.new()
		var parse_result = json.parse(wave_info_file.get_as_text())
		print(parse_result)
		if parse_result != OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", wave_info_file.get_as_text(), " at line ", json.get_error_line())
		else:
			var json_data: Dictionary = json.data
			wave_data_dict = json_data


func calculate_wave_amount():
	
	# Count waves
	var wave_count = wave_data_dict.size()
	print("Wave count is: " + str(wave_count))
	
	print(wave_data_dict["wave1"].get(0).get("pedwin"))
	print(wave_data_dict["wave2"].get(0).get("pedwin"))
	
	# Loop over every wave
	# Loop over every enemies object
	# Spawn the given Pedwin
	
func play_victory_music():
	pass
