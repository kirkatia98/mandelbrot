
class_name PaletteManager extends Resource

@export var textures : Dictionary
@export var num : int

const PALETTE = Palette.Enum


func get_palette(p : PALETTE ) -> Texture2D:
	var name : String = PALETTE.find_key(p)

	return textures[name]
