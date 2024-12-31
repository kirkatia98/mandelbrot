@tool
class_name Fractal extends ColorRect

@export var debug : bool = false :
	set(val):
		debug = val
		(material as ShaderMaterial).set_shader_parameter("debug", debug)

@export var pan_speed : float = 0.1
@export var zoom_speed : float = 0.1

@export var rect_position : Vector2 = Vector2(2, 2):
	set(val):
		rect_position = val
		shader_material.set_shader_parameter("rect_position", rect_position)
		update_coords()


@export var rect_size : Vector2 = Vector2(4, 4):
	set(val):
		rect_size = val
		shader_material.set_shader_parameter("rect_size", rect_size)
		update_coords()

@export var shader_material : ShaderMaterial = material as ShaderMaterial

@export var labels : Control
@export var TL : Label
@export var TR : Label
@export var BR : Label
@export var BL : Label


func update_coords():
	var fmt_str = "(%.2f, %-.2f)"

	var x1 = rect_position.x
	var x2 = rect_position.x + rect_size.x
	var y1 = rect_position.y
	var y2 = rect_position.y + rect_size.y

	TL.text = fmt_str % [x1, y1]
	TR.text = fmt_str % [x2, y1]
	BL.text = fmt_str % [x2, y2]
	BR.text = fmt_str % [x2, y2]


# override gui input instead of input so that zoom input only accepted inside the borders
func _gui_input(event):
	if event.is_action_pressed("zoom_in", true):
		var old_center = 0.5 * rect_size + rect_position
		var new_size = rect_size * 0.9
		var new_center = 0.5 * new_size + rect_position
		rect_position += new_center - old_center
		rect_size = new_size


	if event.is_action_pressed("zoom_out", true):
		var old_center = 0.5 * rect_size + rect_position
		var new_size = rect_size / 0.9
		var new_center = 0.5 * new_size + rect_position
		rect_position += new_center - old_center
		rect_size = new_size

func _unhandled_input(_event):
	var input_vector : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	rect_position -= 0.1 * rect_size * input_vector


func _on_focus_entered():
	print("focus")
