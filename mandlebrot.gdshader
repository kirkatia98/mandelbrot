shader_type canvas_item;

#include "lib.gdshaderinc"

#define LOOPS  18


void fragment() {
	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = UV * vec2(4) - vec2(2.5, 2.0);
	vec2 z = vec2(0);
	
	COLOR = compute_point(z, c, LOOPS);
}