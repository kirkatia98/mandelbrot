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

		if(f.on_screen):

			var fmt_str : String = "%.6f, %.6f"
			mp_text = fmt_str % [f.shader_coords.x, f.shader_coords.y]

			esc_text = "%d / " % f.esc


	MS.text = "Steps:\n%s%d" % [esc_text, iterations]
	MP.text = "Mouse Position:\n" + mp_text
