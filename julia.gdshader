shader_type canvas_item;

#include "lib.gdshaderinc"

// TODO: use a controller inside the mandlebrot shader to get a c value for the julia set
uniform vec2 input;

#define LOOPS 100


void fragment() {
	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = vec2(-0.70176, 0.3842);
	vec2 z = UV * vec2(4) - vec2(2);
	
	COLOR = compute_point(z, c, LOOPS);
	
}