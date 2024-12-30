@tool
class_name Fractal extends ColorRect

enum Type {MANDLEBROT, JULIA}


@export var zoom_offset : Vector2 = Vector2(2, 2):
	set(val):
		zoom_offset = val
		(material as ShaderMaterial).set_shader_parameter("offset", zoom_offset)


@export var zoom_scale : Vector2 = Vector2(4, 4):
	set(val):
		zoom_scale = val
		(material as ShaderMaterial).set_shader_parameter("scale", zoom_scale)




@onready var shader_material : ShaderMaterial = material as ShaderMaterial





# override gui input instead of input so that zoom input only accepted inside the borders
func _gui_input(event):
	if event.is_action_pressed("zoom_in", true):

		zoom_scale += Vector2(0.1, 0.1)

	if event.is_action_pressed("zoom_out", true):

		zoom_scale -= Vector2(0.1, 0.1)
