shader_type canvas_item;

#define cx_mul(a, b) vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x)
#define cx_div(a, b) vec2(((a.x*b.x+a.y*b.y)/(b.x*b.x+b.y*b.y)),((a.y*b.x-a.x*b.y)/(b.x*b.x+b.y*b.y)))

#define LOOPS 100


void fragment() {
	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = vec2(-0.70176, 0.3842);
	vec2 z = UV * vec2(4) - vec2(2);
	
	
	vec2 zp;
	int esc;
	
	for(int loops = 0; loops < LOOPS; loops++){
		zp = cx_mul(z, z) + c;
		z = zp;
		
		// compute if it's escaped
		if(length(zp) >= 4.0){
			esc = loops;
			break;
		}
	}
	
	
	if(esc == LOOPS)
	{
		COLOR = vec4(vec3(0), 1);
	} else
	{
		COLOR = vec4(0.0, float(esc)/float(LOOPS), 0.5, 1.0);
	}
}