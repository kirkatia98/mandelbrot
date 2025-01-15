@tool
extends ColorRect

@export var f : Fractal


func _on_fractal_update_shader():
	material = f.shader_material
