@tool
class_name Fractal extends ColorRect


@export var pan_speed : float = 0.1
@export var zoom_speed : float = 0.1


@export var rect_position : Vector2 = Vector2(2, 2):
	set(val):
		rect_position = val
		(material as ShaderMaterial).set_shader_parameter("rect_position", rect_position)


@export var rect_size : Vector2 = Vector2(4, 4):
	set(val):
		rect_size = val
		(material as ShaderMaterial).set_shader_parameter("rect_size", rect_size)

@onready var shader_material : ShaderMaterial = material as ShaderMaterial


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
