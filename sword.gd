extends Area2D
	
func _ready() -> void:
	var weaponAnim = %AnimationPlayer
	weaponAnim.play("swing")
	await weaponAnim.animation_finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
