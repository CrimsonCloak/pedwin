extends HBoxContainer

@onready var start_button = $"Start Button"
@onready var quit_button = $"Quit Button"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.pressed.connect(start_game)
	quit_button.pressed.connect(quit_game)
func start_game():
	get_tree().change_scene_to_file("res://Scenes/Levels/demogame.tscn")
	
func quit_game():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
