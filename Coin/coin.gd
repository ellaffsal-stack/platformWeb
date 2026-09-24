extends Area2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var coin_sound: AudioStreamPlayer = $"Coin Sound"
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void :
	animation.play("move")

func _on_body_entered(body: Node2D) -> void :
	if body.is_in_group("player"):

		Global.coin += 1
		visible = false
		collision_shape.set_deferred("disabled", true)
		coin_sound.play()
		await coin_sound.finished

		queue_free()
