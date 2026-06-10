extends Area2D

var speed = 400
var direction
var projectile_damage: int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += speed * direction * delta

func _on_area2D_entered(area):
	var collision_layer = area.get_collision_layer()
	if collision_layer == 3:
		var targeted_pedwin = area.get_parent()
		targeted_pedwin.take_damage(projectile_damage)
		queue_free()
