extends Node3D

@onready var character = $Girl_tai_chi_anim_mask
@onready var char_animaion: AnimationPlayer = character.get_node("AnimationPlayer")
@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _ready() -> void:
	char_animaion.play_section("tai_chi", 21.2443)
	canvas_layer.show()
