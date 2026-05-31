extends Node2D

var cd_timer: Timer
var pedwin_in_range: bool
var targetedPedwin: PathFollow2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cd_timer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pedwin_in_range = detect_pedwin()
	print("Pedwin in range:" + str(pedwin_in_range))
	if pedwin_in_range == true:
		attack_enemy(targetedPedwin)

func attack_enemy(target):
	if not cd_timer.is_stopped() && pedwin_in_range == true:
		return # We are still on cooldown
	# Do ability stuff here
	print("Attack Pedwin!")
	cd_timer.start()

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
