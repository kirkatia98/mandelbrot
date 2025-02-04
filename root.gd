extends Control

@onready var override_input : bool = false


func sample_input():

	var center : Vector2 = Vector2(580.0, 650.0)

	var time : float = Time.get_ticks_msec() * 0.0001

	var coords : Vector2 = center + 220.0 * Vector2(cos(time * 5), sin(time * 5)) + 20.0 * Vector2(Vector2(cos(time * 11), sin(time * 13)))

	warp_mouse(coords)


func _input(event):

	if event.is_action_pressed("ui_accept"):
		override_input = !override_input


func _process(_delta):

	if(override_input):

		var mouse_press = InputEventMouseButton.new()
		mouse_press.button_index = MOUSE_BUTTON_RIGHT
		mouse_press.pressed = true

		Input.parse_input_event(mouse_press)

		sample_input()
