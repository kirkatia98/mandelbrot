@tool
extends MarginContainer

@export var f : Fractal

@export_group("Debug Hints")
@export var MP : Label
@export var MS : Label


func _on_fractal_update_labels():
	var mp_text = ""
	var esc_text = ""

	var iterations : int = f.scale_iterations()

	if not Engine.is_editor_hint() and f.is_node_ready():

		# if in the code, get the local mouse position and scale it to the display size
		var local_mouse = f.get_local_mouse_position()

		var screen_rect = f.get_screen_rect()

		if(screen_rect.has_point(local_mouse)):
			var mouse_position = f.local_to_shader(local_mouse)

			var fmt_str : String = "%.6f, %.6f"
			mp_text = fmt_str % [mouse_position.x, mouse_position.y]

			var esc : int = f.compute_point(iterations, mouse_position)
			esc_text = "%d / " % esc


	MS.text = "Steps:\n%s%d" % [esc_text, iterations]
	MP.text = "Mouse Position:\n" + mp_text
