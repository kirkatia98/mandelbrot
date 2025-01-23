@tool
extends MarginContainer

@export var f : Fractal

@export_group("Boundary Coordinates")
@export var TL : Label
@export var TR : Label
@export var BR : Label
@export var BL : Label


func _on_fractal_update_labels():
	var fmt_str : String = "(%.2f, %-.2f)"

	var x1: float = f.rect_position.x
	var x2: float = f.rect_position.x + f.rect_size.x
	var y1: float = f.rect_position.y
	var y2: float = f.rect_position.y + f.rect_size.y

	# Set Boundary Coordinates
	TL.text = fmt_str % [x1, y1]
	TR.text = fmt_str % [x2, y1]
	BL.text = fmt_str % [x2, y2]
	BR.text = fmt_str % [x2, y2]
