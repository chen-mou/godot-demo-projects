extends Area2D

var dire : Vector2
@export var speed : int
var ack = 20

signal bullet_hit

func _ready() -> void:
	self.rotation = dire.angle()

func _process(delta: float) -> void:
	self.position += dire.normalized() * speed * delta
	if not get_viewport_rect().has_point(global_position):
		queue_free()


func _on_body_entered(_body):
	queue_free()
	bullet_hit.emit()
	_body.hit(ack)
