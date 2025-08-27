extends Area2D


func _process(delta: float) -> void:
	var mouse_pose = get_viewport().get_mouse_position()
	if mouse_pose != null:
		self.position = mouse_pose
