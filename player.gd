extends CharacterBody2D

signal health_depleted

@export var speed: int = 300
@export var health: float = 100.0
@export var damage_rate: float = 10.0
@export var killCount = 0
var canAttack = true
var test = 0


func _process(delta: float) -> void:
	%KillCount.set("text", "Kills: " + str(killCount))

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("attack"):
		if canAttack: 
			%WeaponCooldown.start()
			print("Before attack: ", test)
			const WEAPON = preload("res://sword.tscn")
			var new_weapon = WEAPON.instantiate()
			%WeaponAnchor.add_child(new_weapon)
			print("After attack: ", test)
			new_weapon.global_position = %WeaponAnchor.global_position
			new_weapon.look_at(new_weapon.get_global_mouse_position())
			new_weapon.set_rotation_degrees(new_weapon.get_rotation_degrees() + 90)
			canAttack = false
		

	
	if velocity.length() > 0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= damage_rate * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
		

func _on_weapon_cooldown_timeout() -> void:
	if canAttack == false: 
		canAttack = true
