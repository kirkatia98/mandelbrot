@tool
extends MarginContainer

@export var f : Fractal

@export_group("Description")
@export var Name : Label
@export var Cursor : Label

func _on_fractal_update_labels():

	Name.text = Fractal.FractalType.keys()[f.fractalType]

	match(f.fractalType):
		Fractal.FractalType.JULIA:
			Cursor.text = "(%.2f, %-.2f)" % [f.cursor.x, f.cursor.y]
