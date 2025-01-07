@tool
extends MarginContainer

@export var f : Fractal

@export_group("Debug Hints")
@export var RP : Label
@export var RS : Label
@export var MP : Label
@export var ES : Label
@export var MS : Label


func update_labels():
	var fmt_str : String = "%.10f, %.10f"

	# Set Debug Hints
	RP.text = "Rect Position:\n" + fmt_str % [f.rect_position.x, f.rect_position.y]
	RS.text = "Rect Size\n" + fmt_str % [f.rect_size.x, f.rect_size.y]
	ES.text = "Steps:\n_"
	MS.text = "Steps:\n%d" % f.scale_iterations()



	var mp_text = "(_, _)"
	if not Engine.is_editor_hint():

		# if in the code, get the local mouse position and scale it to the display size
		var local_mouse = f.get_local_mouse_position()
		var global_mouse = f.get_global_mouse_position()

		var screen_rect = f.get_rect()

		if(screen_rect.has_point(global_mouse)):
			var mouse_position = f.local_to_shader(local_mouse)
			mp_text = fmt_str % [mouse_position.x, mouse_position.y]

	MP.text = "Mouse Position:\n" + mp_text
