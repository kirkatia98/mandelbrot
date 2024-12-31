#define cx_mul(a, b) vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x)
#define cx_div(a, b) vec2(((a.x*b.x+a.y*b.y)/(b.x*b.x+b.y*b.y)),((a.y*b.x-a.x*b.y)/(b.x*b.x+b.y*b.y)))

#define LOOPS  50

#define RED vec4(1, 0, 0, 1);
#define GREEN vec4(0, 1, 0, 1);
#define BLUE vec4(0, 0, 1, 1);


vec2 transform_uv(vec2 uv, vec2 rect_position, vec2 rect_size) {
	return (uv * rect_size) + rect_position;
}

vec4 compute_point(vec2 z, vec2 c) {
	vec2 zp;
	int esc;
	
	// perform at most LOOPS number of steps
	for(int loops = 0; loops < LOOPS; loops++) {
		
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
	
	if(esc == LOOPS) {
		// f(z, c) never escaped
		return vec4(vec3(0), 1);
	} else {
		// bright green means f(z, c) escaped after the largest number of steps
		return vec4(0.0, float(esc)/float(LOOPS), 0.5, 1.0);
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