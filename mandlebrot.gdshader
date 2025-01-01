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
	
	int iterations = scale_iterations(rect_size);
	
	COLOR = compute_point(z, c, iterations);
	
	// If the debug flag is set, overwrite color with a debug function
	if(debug){
		COLOR = debug_lines(uv, COLOR);
	}
}