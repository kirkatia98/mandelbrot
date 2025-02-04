@tool
class_name Fractal extends Control

signal update_labels
signal update_shader
signal update_cursor

enum FractalType { NONE, MANDLEBROT, JULIA }
@export var fractalType: FractalType

@export var palette : Palette.Enum:
	set(val):
		palette = val
		palette_image = pm.textures[val]


@export var pan_speed : float = 0.05
@export var zoom_speed : float = 0.95
@export var margin : int = 25

@export_group("Exported Resources")
@export var pm : PaletteManager
@export var screen : ColorRect
@export var shader_material : ShaderMaterial:
	set(val):
		shader_material = val
		update_shader.emit()


@export_group("Shader Paramaters")
@export var rect_position : Vector2 = Vector2(-2, -2):
	set(val):
		rect_position = val
		shader_material.set_shader_parameter("rect_position", rect_position)
		update_labels.emit()


@export var rect_size : Vector2 = Vector2(4, 4):
	set(val):
		rect_size = val
		shader_material.set_shader_parameter("rect_size", rect_size)
		update_labels.emit()


@export var palette_image : Texture2D:
	set(val):
		palette_image = val
		shader_material.set_shader_parameter("palette_image", val)


@export var debug : bool = false :
	set(val):
		debug = val
		shader_material.set_shader_parameter("debug", debug)


@onready var on_screen : bool = false
@onready var dragging : bool = false
@onready var drag_julia : bool = false

@onready var old_pos : Vector2
@onready var old_mouse : Vector2


@onready var shader_coords : Vector2
@onready var iterations : int
@onready var esc : int

func get_screen_rect() -> Rect2:
	return screen.get_rect()


func mouse_on_screen() -> bool:
	var local_mouse = get_local_mouse_position()
	var screen_rect = get_screen_rect()

	# shrink the actionable area by margin to prevent errant input
	return screen_rect.grow(-margin).has_point(local_mouse)


# convert local coordinates to coordinates used in the shader
func local_to_shader(local : Vector2):
	local /= get_screen_rect().size
	local *= rect_size
	local += rect_position

	return local


func scale_iterations():
	return int(50.0/pow(rect_size.length(), 0.4))


func compute_point(max_loops : int, coord : Vector2):
	var z : Vector2 = Vector2(0.0, 0.0)
	var c : Vector2 = Vector2(0.0, 0.0)

	match(fractalType):
		FractalType.NONE:
			return 0
		FractalType.MANDLEBROT:
			c = coord
		FractalType.JULIA:
			z = coord

	var zp : Vector2
	for loops in range(0, max_loops):
		zp = Vector2( pow(z.x, 2.0) - pow(z.y, 2.0), 2 * z.x * z.y ) + c
		z = zp

		if zp.length() >= 2.0 :
			return loops

	return max_loops

func _process(delta):

	if(!mouse_on_screen() or Engine.is_editor_hint()):
		return

	# smooth panning movement
	var input_vector : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var target_position = rect_position - rect_size * input_vector

	rect_position = lerp(rect_position, target_position, delta)

# the mandlebrot instance emits a signal that the julia instance connects to
func set_cursor(cursor : Vector2):
	#update cursor variable in the julia set
	shader_material.set_shader_parameter("cursor", cursor)


# drag and zoom input using a mouse
func _input(event):

	if(!mouse_on_screen()):
		# stop dragging
		dragging = false
		on_screen = false
		drag_julia = false
		update_labels.emit()
		return

	on_screen = true

	var local_mouse = get_local_mouse_position()
	var screen_rect = get_screen_rect()

	var old_center: Vector2 = 0.5 * rect_size + rect_position

	# save the shader space coordinate, and compute result
	shader_coords = local_to_shader(local_mouse)
	iterations = scale_iterations()
	esc = compute_point(iterations, shader_coords)

	if event is InputEventMouseButton:
		match(event.button_index):

			# scroll events (set size)
			MOUSE_BUTTON_WHEEL_UP:
				rect_size = rect_size * zoom_speed
			MOUSE_BUTTON_WHEEL_DOWN:
				rect_size = rect_size / zoom_speed

	if event is InputEventMouseButton:
		match(event.button_index):

			# scroll event, if dragging update a new drag start position
			MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN:
				rect_position = old_center - 0.5 * rect_size
				if(dragging):
					old_mouse = local_mouse
					old_pos = rect_position

			# start drag event
			MOUSE_BUTTON_LEFT:
				dragging = event.is_pressed()

				# save the drag start position
				if(dragging):
					old_mouse = local_mouse
					old_pos = rect_position

			MOUSE_BUTTON_RIGHT:
				drag_julia = event.is_pressed()

				if drag_julia:
					update_cursor.emit(shader_coords)
				pass


	if event is InputEventMouseMotion:

		# drag event
		if dragging:
			# move rectangle to the old position offset by mouse movement (scaled to the size of the screen)
			rect_position = old_pos - (local_mouse - old_mouse) / screen_rect.size * rect_size

		if drag_julia:
			update_cursor.emit(shader_coords)
