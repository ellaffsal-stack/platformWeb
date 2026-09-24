extends Area2D


var is_here = false
var speed = 4


func _process(delta: float) -> void :
	if is_here:
		position.y += speed
	pass


func _on_body_entered(body: Node2D) -> void :
	if body.is_in_group("player"):
		body.Damage()
	queue_free()
	pass


func _on_area_2d_body_entered(body: Node2D) -> void :
	if body.is_in_group("player"):
		is_here = true
	pass
