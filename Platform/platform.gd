extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer



func _ready() -> void :
	animation.play("x")
	pass
