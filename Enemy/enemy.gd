extends CharacterBody2D

var speed = 160
var gravity = 12
var dir = -1
@onready var animation: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void :

	if is_on_wall() or not $RayCast2D.is_colliding():
		dir *= -1
		$Sprite2D.flip_h = dir < 0

	velocity.x = speed * dir


	if not is_on_floor():
		velocity.y += gravity

		animation.play("jump")
	else:
		animation.play("run")

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void :
	if body.is_in_group("player"):
		body.Damage()


func _on_die_body_entered(body: Node2D) -> void :
	if body.is_in_group("player"):
		queue_free()
