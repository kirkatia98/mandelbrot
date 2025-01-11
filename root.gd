@tool
extends Control

@export var Mandlebrot : Fractal
@export var Julia : Fractal

@export var pm : PaletteManager

const PALETTE = Palette.Enum


func _ready():
	Mandlebrot.palette_image = pm.get_palette(PALETTE.LAVA_GB)
