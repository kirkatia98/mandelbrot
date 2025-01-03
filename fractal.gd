@tool
class_name Fractal extends ColorRect

@export var debug : bool = false :
	set(val):
		debug = val
		(material as ShaderMaterial).set_shader_parameter("debug", debug)

@export var pan_speed : float = 0.1
@export var zoom_speed : float = 0.9
@export var margin : int = 25


@export_group("Shader Paramaters")
@export var rect_position : Vector2 = Vector2(-2, -2):
	set(val):
		rect_position = val
		shader_material.set_shader_parameter("rect_position", rect_position)
		update_labels()

@export var rect_size : Vector2 = Vector2(4, 4):
	set(val):
		rect_size = val
		shader_material.set_shader_parameter("rect_size", rect_size)
		update_labels()


@export var shader_material : ShaderMaterial = material as ShaderMaterial

@export var palette_image : Texture2D:
	set(val):
		palette_image = val
		shader_material.set_shader_parameter("palette_image", val)


@export_group("Boundary Coordinates")
@export var TL : Label
@export var TR : Label
@export var BR : Label
@export var BL : Label

@export_group("Debug Hints")
@export var RP : Label
@export var RS : Label
@export var MP : Label
@export var ST : Label


@onready var dragging : bool = false

@onready var old_pos : Vector2
@onready var old_mouse : Vector2


func update_labels():
	var fmt_str : String = "(%.3f, %-.3f)"
	var fmt_str_long : String = "%.10f, %.10f"

	var x1: float = rect_position.x
	var x2: float = rect_position.x + rect_size.x
	var y1: float = rect_position.y
	var y2: float = rect_position.y + rect_size.y

	# Set Boundary Coordinates
	TL.text = fmt_str % [x1, y1]
	TR.text = fmt_str % [x2, y1]
	BL.text = fmt_str % [x2, y2]
	BR.text = fmt_str % [x2, y2]


	# Set Debug Hints
	RP.text = "Rect Position:\n" + fmt_str_long % [rect_position.x, rect_position.y]
	RS.text = "Rect Size\n" + fmt_str_long % [rect_size.x, rect_size.y]
	ST.text = "Steps:\n%d" % scale_iterations()


	var mp_text = "(_, _)"
	if not Engine.is_editor_hint():

		# if in the code, get the local mouse position and scale it to the display size
		var local_mouse = get_local_mouse_position()
		var global_mouse = get_global_mouse_position()

		if(get_rect().has_point(global_mouse)):
			var mouse_position = local_to_shader(local_mouse)
			mp_text = fmt_str_long % [mouse_position.x, mouse_position.y]

	MP.text = "Mouse Position:\n" + mp_text


# convert local coordinates to coordinates used in the shader
func local_to_shader(local : Vector2):
	local /= get_rect().size
	local *= rect_size
	local += rect_position

	return local


func compute_point():
	pass


func scale_iterations():
	return int(50.0/pow(rect_size.length(), 0.4))


func _input(event):
	var local_mouse = get_local_mouse_position()
	var global_mouse = get_global_mouse_position()

	var screen_rect = get_rect()

	# shrink the actionable area by margin to prevent errant input
	if(!screen_rect.grow(-margin).has_point(global_mouse)):
		# not my event
		dragging = false
		return

	var old_center: Vector2 = 0.5 * rect_size + rect_position

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


	if event is InputEventMouseMotion and dragging:
		# drag event
		# move rectangle to the old position offset by mouse movement (scaled to the size of the screen)
		rect_position = old_pos - (local_mouse - old_mouse) / screen_rect.size * rect_size


	# faster movement
	var input_vector : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	rect_position -= pan_speed * rect_size * input_vector
