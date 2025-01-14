extends OptionButton

@export var f : Fractal

func _ready():
	# Make sure selected value matches scene from the start
	selected = f.palette


func _on_item_selected(index):
	f.palette = index as Palette.Enum
