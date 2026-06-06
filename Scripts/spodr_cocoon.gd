extends Node2D
@onready var tower_projectile = preload("res://Scenes/Spodr/spodr_projectile.tscn")
var cd_timer: Timer
var pedwin_in_range: bool
var cooldown_ready: bool = true
var targeted_pedwin: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cd_timer = $Timer
	cd_timer.timeout.connect(reset_cooldown)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pedwin_in_range = detect_pedwin()
	if pedwin_in_range == true && cooldown_ready == true:
		detect_pedwin()
		attack_enemy(targeted_pedwin)
		cooldown_ready = false

func attack_enemy(target):
	attack_animation(target)
	cd_timer.start()

func reset_cooldown():
		cooldown_ready = true
func attack_animation(target):
	# Shoot a projectile towards the pedwin
	var projectile_instance = tower_projectile.instantiate()
	projectile_instance.direction = position.direction_to(targeted_pedwin.position)
	add_child(projectile_instance)
	#print("Projectile deployed")
func detect_pedwin() -> bool:
	# Detect a collision with a PathFollow2D (AKA Pedwin enemy)
	# Get all bodies inside Area2D
	var bodies = $Area2D.get_overlapping_areas()

	if not bodies.is_empty() && contains_pedwin(bodies):
		# Filter them on Pedwins
		var pedwins: Array[PathFollow2D]
		for body in bodies:
			if body.get_parent() is PathFollow2D:
				pedwins.append(body.get_parent())
		# Get the furthest Pedwin along the path, and set it as the targeted Pedwin
		# Loop over pedwins and select the one furthest along the path
		var furthest_pedwin_distance = 0
		for pedwin in pedwins:
			if pedwin.progress > furthest_pedwin_distance:
				furthest_pedwin_distance = pedwin.progress
				targeted_pedwin = pedwin
		return true
	return false
	# Return

func contains_pedwin(arrayOfAreas) -> bool:
	var pedwin_present = false
	for area in arrayOfAreas:
		if area.get_parent() is PathFollow2D:
			pedwin_present = true
	return pedwin_present
