@tool
extends Control


@export var Mandlebrot : Fractal
@export var Julia : Fractal

@export var palette_image : CompressedTexture2D:
	set(val):
		palette_image = val

		if Engine.is_editor_hint():
			Mandlebrot.palette_image = val
			Julia.palette_image = val
