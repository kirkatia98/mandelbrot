shader_type canvas_item;

#include "lib.gdshaderinc"

uniform vec2 cursor;

uniform bool debug;

uniform vec2 rect_position = vec2(-2);
uniform vec2 rect_size = vec2(4);

uniform sampler2D palette_image;

void fragment() {
	vec2 uv = transform_uv(UV, rect_position, rect_size);

	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = uv;
	vec2 z = vec2(0);

	int iterations = scale_iterations(rect_size);

	vec4 result = compute_point(z, c, iterations);

	COLOR = compute_color(result, palette_image);


	// If the debug flag is set, overwrite color with a debug function
	if(debug){
		COLOR = debug_lines(uv, COLOR);
	}
}