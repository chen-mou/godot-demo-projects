extends RigidBody2D

@export var origin_hp = 100
var hp


func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	$HPBackground.rotation = -self.rotation
	$HPBackground.global_position = self.global_position - Vector2(0, 20)
	hp = origin_hp

func _process(delta: float) -> void:
	if hp != origin_hp:
		var hp_node = get_node(^"HPBackground/HP")
		hp_node.show()
		hp_node.scale.x = float(hp) / origin_hp
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
		
func hit(val:int):
	hp -= val
	if hp <= 0:
		queue_free()
		
