class_name Fractal extends SubViewportContainer

@export var zoom_center : Vector2 = Vector2(2.0, 2.0)
@export var zoom_amount : Vector2 = Vector2(4.0, 4.0)

@onready var color_rect : ColorRect = $SubViewport/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	#color_rect.material.set_shader_parameter("zoom_center", Vector2(3, 2))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# override gui input instead of input so that zoom input only accepted inside the borders
func _gui_input(event):
	if event.is_action_pressed("zoom_in", true):
		print(name + " zoom in")

		zoom_amount += Vector2(0.1, 0.1)

	if event.is_action_pressed("zoom_out", true):
		print(name + " zoom out")

		zoom_amount += Vector2(0.1, 0.1)
