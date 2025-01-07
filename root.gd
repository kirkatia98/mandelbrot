@tool
extends Control

@export var Mandlebrot : Fractal
@export var Julia : Fractal

@export var palette : Texture2D:
	set(val):
		if Engine.is_editor_hint():
			Mandlebrot.palette_image = val
			Julia.palette_image = val
