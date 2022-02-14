shader_type canvas_item;

uniform float outlineSize = 0.2;
uniform vec4 outlineColor : hint_color = vec4(1., .0, .0, 1.);

void fragment(){
	vec2 size = outlineSize * 1. / vec2(textureSize(TEXTURE, 0).xy);
	float maxAlpha = .0;
	for(float x = -1.; x <= 1.; x += 1.){
		for(float y = -1.; y <= 1.0; y += 1.){
			vec2 uv = UV + normalize(vec2(x, y)) * size;
			maxAlpha = max(maxAlpha, texture(TEXTURE, uv).a);
		}
	}
	vec4 origin = texture(TEXTURE, UV);
	COLOR.rgb = mix(outlineColor.rgb, origin.rgb, origin.a);
	COLOR.a = .0;
	if(maxAlpha == 1.0 && origin.a == 0.0)
	{
		COLOR.a = 1.0;
	}
}