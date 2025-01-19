@tool
extends ColorRect

@export var f : Fractal


func _on_fractal_update_shader():
	material = f.shader_material


func _on_resized():
	var aspect_ratio : float = size.x / size.y

	var old_center: Vector2 = 0.5 * f.rect_size + f.rect_position

	# scale x by the aspect ratio
	f.rect_size.x = f.rect_size.y * aspect_ratio

	# re-center
	f.rect_position = old_center - 0.5 * f.rect_size
