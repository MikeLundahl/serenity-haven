class_name Controls
extends Node

# THIS IS GENERIC CONTROLS AND NOT PLAYER CONTROLS

@onready var root_scene: Node3D = get_parent()
@onready var wip_stripes: Node3D = root_scene.get_node_or_null("WIP_stripes")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("wip_restricted_toggle"):
		if wip_stripes != null:
			wip_stripes.visible = !wip_stripes.visible
