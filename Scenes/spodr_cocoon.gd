extends Node2D

var cd_timer: Timer
var tower_damage: int = 1
var pedwin_in_range: bool
var cooldown_ready: bool = true
var targetedPedwin: PathFollow2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cd_timer = $Timer
	cd_timer.timeout.connect(reset_cooldown)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pedwin_in_range = detect_pedwin()
	print("Pedwin in range:" + str(pedwin_in_range))
	if pedwin_in_range == true && cooldown_ready == true:
		detect_pedwin()
		attack_enemy(targetedPedwin)
		cooldown_ready = false

func attack_enemy(target):
	print("Attack Pedwin!")
	targetedPedwin.takeDamage(tower_damage)
	cd_timer.start()

func reset_cooldown():
		cooldown_ready = true


func detect_pedwin() -> bool:
	# Detect a collision with a PathFollow2D (AKA Pedwin enemy)
	# Get all bodies inside Area2D
	var bodies = $Area2D.get_overlapping_areas()

	if not bodies.is_empty():
		# Filter them on Pedwins, which are always PathFollow2D.
		print("Penguins in bodies: "+ str(bodies))
		var pedwins: Array[PathFollow2D]
		for body in bodies:
				pedwins.append(body.get_parent())
		print(pedwins)
		# Get the furthest Pedwin along the path, and set it as the targeted Pedwin
		# Loop over pedwins and select the one furthest along the path
		var furthest_pedwin_distance = 0
		for pedwin in pedwins:
			if pedwin.progress > furthest_pedwin_distance:
				furthest_pedwin_distance = pedwin.progress
				targetedPedwin = pedwin
		return true
	return false
	# Return
