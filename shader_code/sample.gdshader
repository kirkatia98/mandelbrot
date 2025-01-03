shader_type canvas_item;

uniform vec2 cursor;

uniform bool debug;

uniform vec2 rect_position;
uniform vec2 rect_size;

uniform sampler2D palette_image;

void fragment() {
	COLOR = vec4(UV.xy, 0.0, 1.0);
}
