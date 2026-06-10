extends Node2D
@export var fish_amount: int = 100
@export var pedwins_alive: int
@export var pedwins_killed: int = 0
@export var pedwins_per_wave: int = 10
@export var fish_cost_tower: int = 50
var royalty_total: int = 3
# Called when the node enters the scene tree for the first time.
var levelhud
var gameover_screen
func _ready() -> void:
	levelhud = get_node("../LevelHud")
	gameover_screen = get_node("../GameOverScreen")
	# Set fish_counter to 100
	set_fish_text(fish_amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count_alive_pedwins()

func count_alive_pedwins():
	pedwins_alive = get_node("../Path2D").get_child_count()
	set_pedwin_text(pedwins_alive)

# Functions that write or update UI elements

func set_fish_text(amount: int):
	var fish_counter = levelhud.find_child("FishCounterText")
	fish_counter.text = "Fish: %d" % fish_amount

func set_pedwin_text(amount: int):
	var pedwin_counter = levelhud.find_child("PedwinRemainingCounterText")
	pedwin_counter.text = "Pedwins: %d" % pedwins_killed

func lose_life():
	var royalty_healthbar = levelhud.find_child("UI_pedwin_royalty")
	royalty_healthbar.get_child(0).queue_free()
	royalty_total -= 1
	if royalty_total == 0:
		get_tree().paused = true
		get_parent().get_node("StartButton").queue_free()
		gameover_screen.popup_game_over()
		print(gameover_screen.get_child(0))
		
# Functions that edit values for game

func gain_fish(amount: int):
	fish_amount += amount
	set_fish_text(fish_amount)
func spend_fish(amount: int):
	fish_amount -= amount
	set_fish_text(fish_amount)
