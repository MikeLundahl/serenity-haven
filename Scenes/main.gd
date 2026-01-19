extends Node3D

@onready var character = $Girl_tai_chi_anim_mask
@onready var char_animaion: AnimationPlayer = character.get_node("AnimationPlayer")
@onready var animation: AnimationPlayer = get_node("AnimationPlayer")
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var pause: CanvasLayer = $Pause

var is_quitting: bool = false

func _ready() -> void:
	char_animaion.play_section("tai_chi", 21.2443)
	canvas_layer.show()
	
	var animation_connect: int = animation.animation_finished.connect(_on_animation_finished)
	if animation_connect != 0:
		push_error("Error animation_connect: ", str(animation_connect))
	
	var quit_update_connect: int = pause.quit_update.connect(_on_quit_update)
	if quit_update_connect != 0:
		push_error("Error quit_update_connect: ", str(quit_update_connect))

func _on_quit_update() -> void:
	is_quitting = true
	animation.play_backwards("intro")

func _on_animation_finished(anim) -> void:
	if anim == "intro" && is_quitting:
		get_tree().quit()
