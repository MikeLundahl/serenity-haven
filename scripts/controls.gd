class_name Controls
extends Node

# THIS IS GENERIC CONTROLS AND NOT PLAYER CONTROLS

@onready var root_sceen: Node3D = get_parent()
@onready var animation: AnimationPlayer = root_sceen.get_node("AnimationPlayer")

var is_quitting: bool = false

func _ready() -> void:
	var animation_connect: int = animation.animation_finished.connect(_on_animation_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		is_quitting = true
		if is_quitting:
			animation.play_backwards("intro")

func _on_animation_finished(anim) -> void:
	if anim == "intro" && is_quitting:
		get_tree().quit()
