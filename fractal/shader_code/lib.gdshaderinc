#define cx_mul(a, b) vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x)
#define cx_div(a, b) vec2(((a.x*b.x+a.y*b.y)/(b.x*b.x+b.y*b.y)),((a.y*b.x-a.x*b.y)/(b.x*b.x+b.y*b.y)))

#define RED vec4(1, 0, 0, 1);
#define GREEN vec4(0, 1, 0, 1);
#define BLUE vec4(0, 0, 1, 1);


vec2 transform_uv(vec2 uv, vec2 rect_position, vec2 rect_size) {
	return (uv * rect_size) + rect_position;
}

int scale_iterations(vec2 rect_size){
	return int(50.0/pow(length(rect_size), 0.4));
}

vec4 compute_point(vec2 z, vec2 c, int iterations) {
	vec2 zp;
	int esc = iterations;

	// perform at most iterations number of steps
	for(int loops = 0; loops < iterations; loops++) {

		// z' = z^2 + c
		zp = cx_mul(z, z) + c;
		z = zp;

		// f(z, c) has escaped if | z_n | > 2.0
		if(length(zp) >= 2.0){

			// save how many steps it took to escape
			esc = loops;
			break;
		}
	}

	return vec4(zp, float(esc), float(iterations) );
}

float tone( float x, float k )
{
    return x*(k+1.0)/(1.0+k*x);
}

vec4 compute_color(vec4 m, sampler2D palette_image){

	int color_count = textureSize(palette_image, 0).x - 1;

	float iterations = m.w;
	float esc_time = m.z;

	float esc_strength = tone(esc_time/iterations, 3.0);

	float c_ind = esc_strength * float(color_count);

	vec3 color1 = texelFetch(palette_image, ivec2(int(c_ind), 0), 0).rgb;
	vec3 color2 = texelFetch(palette_image, ivec2(int(c_ind) + 1, 0), 0).rgb;

	if(m.z != m.w) {
		return vec4(mix(color1, color2, fract(c_ind)), 1.0);
	} else {
		// f(z, c) never escaped
		return vec4(vec3(0), 1);
	}
}

const float EPSILON = 0.005;
bool is_equal_approx(float a, float b) {
   	// a - b <= EPSILON
	return a <= EPSILON + b && a >= b - EPSILON;
}


vec4 debug_lines(vec2 uv, vec4 color) {
	// x and y axis
	if(is_equal_approx(uv.x, 0) || is_equal_approx(uv.y, 0)){
		return RED;
	}
	// circle of radius 2
	if(is_equal_approx(length(uv), 2.0)){
		return GREEN;
	}
	return color;
}