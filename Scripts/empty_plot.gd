extends Node2D

var spodr_cocoon_prefab: PackedScene = preload("res://Scenes/spodr_cocoon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $Sprite2D.get_rect().has_point(to_local(event.position)):
				print ("Clicked!")
				spawn_spodr_cocoon()
				
func spawn_spodr_cocoon():
	# Instantiate a spodr_cocoon on centre of web and delete web area
	var spodr_cocoon = spodr_cocoon_prefab.instantiate()
	self.get_parent().add_child(spodr_cocoon)
	spodr_cocoon.position = Vector2(self.position)
	queue_free()
	
	
