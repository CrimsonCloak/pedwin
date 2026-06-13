extends Control
@onready var return_button: Button = get_node("Return button")
@onready var level1_button: Button = get_node("Panel/HBoxContainer/Level1/StartLevel")
@onready var level2_button: Button = get_node("Panel/HBoxContainer/Level2/StartLevel")
@onready var level3_button: Button = get_node("Panel/HBoxContainer/Level3/StartLevel")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return_button.pressed.connect(return_main)
	level1_button.pressed.connect(start_level1)
	level2_button.pressed.connect(start_level2)
	level3_button.pressed.connect(start_level3)

func return_main():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func start_level1():
	get_tree().change_scene_to_file("res://Scenes/Levels/demogame.tscn")

func start_level2():
	get_tree().change_scene_to_file("res://Scenes/Levels/demogame.tscn")

func start_level3():
	get_tree().change_scene_to_file("res://Scenes/Levels/demogame.tscn")
