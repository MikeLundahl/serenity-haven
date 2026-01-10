extends Control


@onready var Current_FPS = $Current_FPS
@onready var fade = $Fade / Fade_screen
@onready var cam_pos = $"../Scenes/Cameras/Camera_1_place"


var screen_size


func _ready() -> void :
	var max_fps = 60
	Engine.max_fps = DisplayServer.screen_get_refresh_rate()
	if max_fps < 0:
		max_fps = 60.0


func _process(_delta):
	Current_FPS.text = str(Engine.get_frames_per_second()) + "/" + str(Engine.max_fps)


func _unhandled_input(event: InputEvent) -> void :
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:

			set_process_unhandled_input(false)

			screen_size = get_viewport_rect().size
			fade.size = screen_size
			fade.show()
			var tween: = create_tween()
			tween.tween_property(fade, "modulate:a", 1.0, 1.5).from(0.0)



			await tween.finished
			get_tree().quit()


	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F11:
			if DisplayServer.window_get_mode() == 0:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
