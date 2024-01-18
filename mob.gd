extends CharacterBody2D

@export var health = 3
@onready var player = get_node("/root/Game/Player")
@onready var playerAnim = get_node("/root/Game/Player/HappyBoo/AnimationPlayer")
#@onready var shotInterval = get_node("/root/Game/Player/Gun/ShotInterval")
var speed = 150

func _ready():
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	if health == 0:
		queue_free()
		player.killCount += 1
		
		##Gun stuff
		#if player.killCount % 1 == 0:
			#if shotInterval.get_wait_time() > 0.1:
				#shotInterval.set_wait_time(shotInterval.get_wait_time() / 4 * 3)
			#if playerAnim.get_speed_scale() < 2:
				#playerAnim.set_speed_scale(playerAnim.get_speed_scale() * 5 / 4)
		#if player.killCount % 2 == 0:
			#const GUN = preload("res://gun.tscn")
			#var new_gun = GUN.instantiate()
			#player.add_child(new_gun)
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
