extends PathFollow2D
@export var speed: float = 100.0
@export var max_health: int = 3
@export var health: int
@export var fish_value: int = 10
@export var game_manager = Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	$healthBar.max_value = max_health
	game_manager = get_node("/root/Game/GameManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	progress += delta * speed
	if progress_ratio >= 1.0:
		game_manager.lose_life()
		queue_free()

func take_damage(damage: int) -> void:
	health -= damage
	update_health()
	if health <= 0:
		queue_free()
		game_manager.gain_fish(fish_value)
		game_manager.pedwins_killed += 1

func update_health():
	$healthBar.value = health
