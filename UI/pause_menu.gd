extends CanvasLayer



func _ready() -> void :
	pass



func _process(delta: float) -> void :
	pass

func _input(event: InputEvent) -> void :
	if event.is_action_pressed("ui_cancel"):
		_visible()

	pass


func _on_resume_pressed() -> void :
	_visible()
	pass

func _visible():
	visible = !visible
	get_tree().paused = !get_tree().paused
	pass


func _on_exit_pressed() -> void :
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu/MainMenu.tscn")
	pass
