extends Area2D
	

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	set_rotation_degrees(get_rotation_degrees() + 90)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		print("Enemy Hit!")
