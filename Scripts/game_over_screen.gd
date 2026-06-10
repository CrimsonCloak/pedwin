extends Control
@onready var retry_button: Button = get_node("Panel/CanvasLayer/RetryButton")
@onready var main_menu_button: Button = get_node("Panel/CanvasLayer/MainMenuButton")
@onready var canvas: CanvasLayer = get_node("Panel/CanvasLayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	retry_button.pressed.connect(restart_level)
	main_menu_button.pressed.connect(return_to_main)

func restart_level():
	print("Restarting level")
	get_tree().paused = false
	get_tree().reload_current_scene()

func return_to_main():
	print("Returning to main menu")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
