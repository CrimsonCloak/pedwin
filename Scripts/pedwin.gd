extends PathFollow2D
@export var speed: float = 100.0
@export var maxHealth: int = 2
@export var health: int
@export var fishValue: int = 10
@export var gameManager = Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = maxHealth
	gameManager = get_node("/root/Game/GameManager")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $Sprite2D.is_pixel_opaque(get_local_mouse_position()):
				takeDamage(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	progress += delta * speed
	if progress_ratio >= 1.0:
		queue_free()

func takeDamage(damage: int) -> void:
	health -= damage
	update_health()
	if health <= 0:
		queue_free()
		gameManager.gain_fish(fishValue)
		gameManager.pedwinsKilled += 1

func update_health():
	$healthBar.value = health
