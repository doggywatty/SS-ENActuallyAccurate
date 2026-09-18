varying vec2 v_vTexcoord;
varying vec4 v_vColour;
void main() {
	vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
    // Check if the color is white
    if (col.rgb == vec3(1.0, 1.0, 1.0)) {
        col.a = 0.0;
    }
	gl_FragColor = v_vColour * col;
}