#define cx_mul(a, b) vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x)
#define cx_div(a, b) vec2(((a.x*b.x+a.y*b.y)/(b.x*b.x+b.y*b.y)),((a.y*b.x-a.x*b.y)/(b.x*b.x+b.y*b.y)))


vec2 transform_uv(vec2 uv, vec2 offset, vec2 scale) {
	return (uv * scale) - offset;
}

vec4 compute_point(vec2 z, vec2 c, int LOOPS) {
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