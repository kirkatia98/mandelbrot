@tool
class_name PaletteManager extends Resource

@export var textures : Array[ImageTexture]
@export var names : Array[String]

@export var num : int

static func test():
	print("test")

func get_palette(p : Palette.Enum ) -> Texture2D:

	return textures[p]
