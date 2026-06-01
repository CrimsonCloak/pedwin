extends Node2D
@export var fishAmount: int = 100
@export var pedwinsAlive: int
@export var pedwinsKilled: int = 0
@export var pedwins_per_wave: int = 10
# Called when the node enters the scene tree for the first time.
var levelhud
func _ready() -> void:
	pass # Replace with function body.
	levelhud = get_node("../LevelHud")
	# Set fish_counter to 100
	set_fish_text(fishAmount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count_alive_pedwins()

func count_alive_pedwins():
	pedwinsAlive = get_node("../Path2D").get_child_count()
	set_pedwin_text(pedwinsAlive)
# Functions that write or update UI elements

func set_fish_text(amount: int):
	var fisCounter = levelhud.find_child("FishCounterText")
	fisCounter.text = "Fish: %d" % fishAmount

func set_pedwin_text(amount: int):
	var fisCounter = levelhud.find_child("PedwinRemainingCounterText")
	fisCounter.text = "Pedwins: %d" % pedwinsKilled
	
	
# Functions that edit values for game

func gain_fish(amount: int):
	fishAmount += amount
	set_fish_text(fishAmount)
func spend_fish(amount: int):
	fishAmount -= amount
	set_fish_text(fishAmount)
