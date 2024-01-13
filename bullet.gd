extends Area2D

const SPEED = 750
const RANGE = 1500
var distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	distance += SPEED * delta
	if distance > RANGE:
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
