/*
	"MipBlur" by @XorDev
	
	A one-pass blur shader that takes advantage of mipmapping.
	Written for my mipmapping tutorial:
	https://mini.gmshaders.com/p/mipmaps
	
	Based on my 1-pass blur:
	https://github.com/XorDev/1PassBlur/blob/main/1PassBlur
*/

//Number of texture samples. Higher = smoother, slower
#define SAMPLES 8.0

//Texel size, blur radius
uniform vec2 u_texel;
uniform float u_radius;

varying vec4 v_color;
varying vec2 v_coord;

void main()
{
	//Initialize blur output color
	vec4 blur = vec4(0);
	//Total weight from all samples
	float total = 0.0;
	
	//First sample offset scale
	float scale = u_radius/sqrt(SAMPLES);
	//Starting sample point
	vec2 point = vec2(scale,0);
	
	//Radius iteration variable
	float rad = 1.0;
	//Golden angle rotation matrix
	mat2 ang = mat2(-0.7373688, -0.6754904, 0.6754904,  -0.7373688);
	
	//Compute Level Of Detail from pixel radius
	//Log(x) is undefined when x <= 0.0!
	float LOD = u_radius>0.0? log2(u_radius) : 0.0;
	
	//Look through all the samples
	for(float i = 0.0;i<SAMPLES;i++)
	{
		//Rotate point direction
		point *= ang;
		//Iterate radius variable. Approximately 1+sqrt(i)
		rad += 1.0/rad;
		
		//Get sample coordinates
		vec2 coord = v_coord + point*(rad-1.0)*u_texel;
		//Set sample weight
		float weight = 1.0/rad;
		//Sample texture
		vec4 samp = texture2D(gm_BaseTexture,coord,LOD);
		
		//Add sample and weight totals
		blur += samp * weight;
		total += weight;
	}
	//Divide the blur total by the weight total
	blur /= total;
	//Output result
	gl_FragColor = v_color * blur;
}