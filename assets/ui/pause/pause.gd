extends CanvasLayer

signal quit_update

func _ready() -> void:
	hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_continue_pressed()

func _on_continue_pressed() -> void:
	visible = !visible

func _on_visibility_changed() -> void:
	get_tree().paused = visible
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		return
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quit_pressed() -> void:
	_on_continue_pressed()
	quit_update.emit()
