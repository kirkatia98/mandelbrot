extends OptionButton

@export var f : Fractal

func _ready():
	# Make sure selected value matches scene from the start
	selected = f.palette

	for i in range(f.pm.num):

		# scale up the BUTTON's copy of the texture
		get_item_icon(i).set_size_override(Vector2i(128, 32))



func _on_item_selected(index):
	f.palette = index as Palette.Enum
