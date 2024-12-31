shader_type canvas_item;

#include "lib.gdshaderinc"

uniform bool debug;

uniform vec2 rect_position;
uniform vec2 rect_size;

void fragment() {
	vec2 uv = transform_uv(UV, rect_position, rect_size);
	
	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = uv;
	vec2 z = vec2(0);
	
	COLOR = compute_point(z, c);
	
	// If the debug flag is set, overwrite color with a debug function
	if(debug){
		COLOR = debug_lines(uv, COLOR);
	}
}