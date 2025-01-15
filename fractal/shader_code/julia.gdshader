shader_type canvas_item;

#include "lib.gdshaderinc"

// TODO: use a controller inside the mandlebrot shader to get a c value for the julia set
uniform vec2 cursor;

uniform bool debug;

uniform vec2 rect_position = vec2(-2);
uniform vec2 rect_size = vec2(4);

uniform sampler2D palette_image;

void fragment() {
	vec2 uv = transform_uv(UV, rect_position, rect_size);

	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = vec2(-0.70176, 0.3842);
	vec2 z = uv;

	int iterations = scale_iterations(rect_size);

	vec4 result = compute_point(z, c, iterations);

	COLOR = compute_color(result, palette_image);

	if(debug){
		COLOR = debug_lines(uv, COLOR);
	}

}