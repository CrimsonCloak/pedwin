extends Node2D

var spodr_cocoon_prefab: PackedScene = preload("res://Scenes/Spodr/spodr_cocoon.tscn")
var game_manager: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_node("/root/Game/GameManager")
	$Area2D.connect("mouse_entered", self.on_mouse_enter)
	$Area2D.connect("mouse_exited", self.on_mouse_exit)
	update_fish_cost_visual()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	update_fish_cost_visual()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $Sprite2D.get_rect().has_point(to_local(event.position)):
				print ("Clicked!")
				spawn_spodr_cocoon()

func on_mouse_enter():
	apply_shader()

func on_mouse_exit():
	unset_shader()

func update_fish_cost_visual():
	$Purchase_UI/FishCounterText.text = str(game_manager.fish_cost_tower)

func apply_shader():
	var shader = load("res://Assets/Shaders/highlight_black.gdshader")
	var material := ShaderMaterial.new()
	material.shader = shader
	$Sprite2D.material = material

func unset_shader():
	$Sprite2D.material.shader = null

func spawn_spodr_cocoon():
	if game_manager.fish_amount >= game_manager.fish_cost_tower:
		game_manager.spend_fish(game_manager.fish_cost_tower)
		game_manager.fish_cost_tower *= 1.5
		# Instantiate a spodr_cocoon on centre of web and delete web area
		var spodr_cocoon = spodr_cocoon_prefab.instantiate()
		self.get_parent().add_child(spodr_cocoon)
		spodr_cocoon.position = Vector2(self.position)
		
		queue_free()
