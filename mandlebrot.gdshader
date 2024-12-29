shader_type canvas_item;

#define cx_add(a, b) vec2(a.x + b.x, a.y + b.y)
#define cx_sub(a, b) vec2(a.x - b.x, a.y - b.y)
#define cx_mul(a, b) vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x)
#define cx_div(a, b) vec2(((a.x*b.x+a.y*b.y)/(b.x*b.x+b.y*b.y)),((a.y*b.x-a.x*b.y)/(b.x*b.x+b.y*b.y)))
#define cx_modulus(a) length(a)
#define cx_conj(a) vec2(a.x,-a.y)
#define cx_arg(a) atan2(a.y,a.x)
#define cx_sin(a) vec2(sin(a.x) * cosh(a.y), cos(a.x) * sinh(a.y))
#define cx_cos(a) vec2(cos(a.x) * cosh(a.y), -sin(a.x) * sinh(a.y))

vec2 cx_sqrt(vec2 a) {
    float r = sqrt(a.x*a.x+a.y*a.y);
    float rpart = sqrt(0.5*(r+a.x));
    float ipart = sqrt(0.5*(r-a.x));
    if (a.y < 0.0) ipart = -ipart;
    return vec2(rpart,ipart);
}

#define LOOPS  18




void fragment() {
	// Center and scale the mandelbrot set, and set the initial conditons for z = 0
	vec2 c = UV * vec2(4) - vec2(2.5, 2.0);
	vec2 z = vec2(0);
	
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