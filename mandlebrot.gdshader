shader_type canvas_item;

#include "lib.gdshaderinc"

#define LOOPS  18

uniform int test = 1;

uniform vec2 zoom_center = vec2(2.5, 2.0);
uniform vec2 zoom_amount = vec2(4);


void fragment() {
	vec2 uv = UV * zoom_amount - zoom_center;
	
	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = uv;
	vec2 z = vec2(0);
	
	COLOR = compute_point(z, c, LOOPS  * test);
}