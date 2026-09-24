extends CharacterBody2D

var speed = 150
var jump = 240
var gravity = 12


@onready var particles_move: CPUParticles2D = $"particles Nodes/Move Particles"
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player: CharacterBody2D = $"."
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var label_coin: Label = $UI / Label
@onready var damage_sound: AudioStreamPlayer = $"Damage Sound"
@onready var you_died_ui: CanvasLayer = $"UI/You died"
@onready var die_particles: CPUParticles2D = $"particles Nodes/Die Particles"



func _physics_process(delta: float) -> void :

	label_coin.text = str(Global.coin)

	Gravity()
	Move()
	Jump()

	move_and_slide()

	UpdateAnimation()

func Move():
	if Input.is_action_pressed("left"):
		velocity.x = - speed
		sprite_2d.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		sprite_2d.flip_h = false
	else:
		velocity.x = 0

func Gravity():
	if not is_on_floor():
		velocity.y += gravity

func Jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = - jump
		audio_stream_player.play()

func UpdateAnimation():
	if not is_on_floor():
		particles_move.emitting = false
		if animation.current_animation != "jump":
			animation.play("jump")
	else:
		if velocity.x != 0:
			if animation.current_animation != "move":
				animation.play("move")
			particles_move.emitting = true
		else:
			if animation.current_animation != "stand":
				animation.play("stand")
			particles_move.emitting = false


@onready var sprite_health: Sprite2D = $UI / Health / SpriteHealth

var health = 3


func Damage():

	health -= 1

	velocity.y -= 200
	damage_sound.play()
	Color_Damage()

	match health:
		3:
			sprite_health.frame = 0
		2:
			sprite_health.frame = 1
		1:
			sprite_health.frame = 2
		0:
			sprite_health.frame = 3

	if health == 0:
		Die()
	pass



func Die():
	you_died_ui.visible = true
	get_tree().paused = true
	die_particles.emitting = true
	pass

func Color_Damage():
	sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.25).timeout
	sprite_2d.modulate = Color.WHITE

	pass


func _on_try_again_pressed() -> void :
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass



func _on_exit_pressed() -> void :
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu/MainMenu.tscn")
	pass
