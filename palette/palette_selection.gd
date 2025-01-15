extends OptionButton

@export var f : Fractal

func _ready():
	# Make sure selected value matches scene from the start
	selected = f.palette

	for i in range(f.pm.num):

		# Image texture allows overriding texture size,
		# so replace BUTTON's copy of the texture
		var img : Image = get_item_icon(i).get_image()
		var txt : ImageTexture = ImageTexture.create_from_image(img)

		txt.set_size_override(Vector2i(128, 32))
		set_item_icon(i, txt)


func _on_item_selected(index):
	f.palette = index as Palette.Enum
