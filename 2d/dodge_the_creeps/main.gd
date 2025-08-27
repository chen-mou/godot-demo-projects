extends Node

@export var mob_scene: PackedScene
@export var bullet_scene: PackedScene
var score
var point

var can_shoot = false

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$ShootTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$Point.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	can_shoot = false
	


func new_game():
	get_tree().call_group(&"mobs", &"queue_free")
	score = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Point.show()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
	can_shoot = true

func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node(^"MobPath/MobSpawnLocation")
	mob_spawn_location.progress = randi()

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _process(delta: float):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var player_point = get_node(^"Player/BulletPoint")
		shoot(get_viewport().get_mouse_position(), player_point.global_position)
	
func _ready() -> void:
	$Point.hide()


func shoot(point_position:Vector2, player_position: Vector2):
	if !can_shoot:
		return
	can_shoot = false
	var bullet = bullet_scene.instantiate()
	bullet.position = player_position
	bullet.dire = (point_position - player_position).normalized()
	add_child(bullet)
	$ShootTimer.start()


func _on_shoot_timer_timeout() -> void:
	can_shoot = true # Replace with function body.
