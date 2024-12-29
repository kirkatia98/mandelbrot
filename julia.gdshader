shader_type canvas_item;

#include "lib.gdshaderinc"

#define LOOPS 100

// TODO: use a controller inside the mandlebrot shader to get a c value for the julia set
uniform vec2 cursor;
uniform int test = 1;

uniform vec2 zoom_center = vec2(2);
uniform vec2 zoom_amount = vec2(4);

void fragment() {
	vec2 uv = UV * zoom_amount - zoom_center;

	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = vec2(-0.70176, 0.3842);
	vec2 z = uv;

	COLOR = compute_point(z, c, LOOPS * test);

}