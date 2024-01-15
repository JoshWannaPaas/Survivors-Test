extends CharacterBody2D

signal health_depleted

@export var speed: int = 300
@export var health: float = 100.0
@export var damage_rate: float = 10.0
@export var killCount = 0
@onready var weapon = %Weapon
@onready var weaponAnim = get_node("/root/Game/Player/Weapon/Sword/AnimationPlayer")

func _process(delta: float) -> void:
	%KillCount.set("text", "Kills: " + str(killCount))

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("attack"):
		weapon.visible = true
		weaponAnim.play("swing")
		await weaponAnim.animation_finished
		weapon.visible = false
	
	if velocity.length() > 0:
		#get_node("HappyBoo").play_walk_animation()
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= damage_rate * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
		
	
