extends Area2D

@onready var test = get_parent().get_parent().test
	
func _ready() -> void:
	var weaponAnim = %AnimationPlayer
	get_parent().get_parent().test += 1
	if test % 2 == 0:
		weaponAnim.play("swing")
	else:
		weaponAnim.play("stab")
	await weaponAnim.animation_finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
