extends Control
@onready var resume_button: Button = get_node("Panel/GridContainer/Resume")
@onready var restart_button: Button = get_node("Panel/GridContainer/Restart")
@onready var return_button: Button = get_node("Panel/GridContainer/Return")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume_button.pressed.connect(resume_level)
	restart_button.pressed.connect(restart_level)
	return_button.pressed.connect(return_main)
	get_tree().paused = true

func resume_level():
	get_tree().paused = false
	queue_free()

func restart_level():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func return_main():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
