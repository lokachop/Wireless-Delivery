uniform float noisemult;
uniform float graymult;
uniform float randseed;

// https://stackoverflow.com/questions/4200224/random-noise-functions-for-glsl
float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 12.233))) * (43758.5453 * randseed));
}


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
	vec4 texturecolor = Texel(tex, texture_coords);
	float gray = (texturecolor.r + texturecolor.g + texturecolor.b) / 3.0;

	float final_gray = mix(gray, rand(screen_coords), noisemult);

	return vec4(
		mix(texturecolor.r, final_gray, graymult),
		mix(texturecolor.g, final_gray, graymult),
		mix(texturecolor.b, final_gray, graymult),
		texturecolor.a) * color;
}