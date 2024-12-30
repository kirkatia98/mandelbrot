shader_type canvas_item;

#include "lib.gdshaderinc"

#define LOOPS  18

uniform vec2 offset;
uniform vec2 scale;


void fragment() {
	vec2 uv = transform_uv(UV, offset, scale);
	
	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = uv;
	vec2 z = vec2(0);
	
	COLOR = compute_point(z, c, LOOPS);
}