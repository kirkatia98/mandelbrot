@tool
extends MarginContainer

@export var f : Fractal

@export_group("Debug Hints")
@export var MP : Label
@export var MS : Label


func _on_fractal_update_labels():
	var fmt_str : String = "%.10f, %.10f"

	MS.text = "Steps:\n%d" % f.scale_iterations()

	var mp_text = "(_, _)"
	if not Engine.is_editor_hint():

		# if in the code, get the local mouse position and scale it to the display size
		var local_mouse = f.get_local_mouse_position()

		var screen_rect = f.get_screen_rect()

		if(screen_rect.has_point(local_mouse)):
			var mouse_position = f.local_to_shader(local_mouse)
			mp_text = fmt_str % [mouse_position.x, mouse_position.y]

	MP.text = "Mouse Position:\n" + mp_text
