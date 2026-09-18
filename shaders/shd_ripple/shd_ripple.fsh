varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;
uniform float amplitude;
#define SCALE 0.03
#define SPEED 4.0
void main()
{
	vec2 tx = v_vTexcoord;
	vec2 vv = -1.0 + (2.0 * tx);
	float len = length(vv);
	vec2 uv = tx + ((vv / len) * cos(len * 12.0 - time * SPEED) * (SCALE * amplitude));
	
	gl_FragColor = texture2D(gm_BaseTexture, uv);
}