#define Transparent vec4(.0,.0,.0,.0) 
#define Tolerance 0.004 
//If you feel like your colors should be matching but aren't, increase this number a bit.
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
// Retro Palette Shader Variables.
uniform sampler2D u_palTexture;
uniform vec4 u_Uvs;
uniform float u_paletteId;
uniform vec2 u_pixelSize;
// Pattern Shader Variables.
// A bool, 0 if we just want a recolor, 1 if we're using a pattern.
uniform int pattern_enabled;
uniform vec2 u_dest_texelDimension;
uniform vec4 u_src_spriteDimension;
uniform sampler2D u_loop_texture;
uniform float u_color_array[2]; // Used to determine which 2 color indices are our sprites to pattern over.
vec4 findAltColor(vec4 inCol, vec2 corner) {
    if(inCol.a == 0.) return Transparent;
    
    float dist;
    vec2 testPos;
    vec4 leftCol;
	
    for(float i = corner.y; i < u_Uvs.w; i+=u_pixelSize.y ) {
		testPos = vec2(corner.x,i);
		leftCol = texture2D(u_palTexture, testPos);
        
		dist = distance(leftCol, inCol);
		if(dist < Tolerance) {
			testPos = vec2(corner.x + u_pixelSize.x * floor(u_paletteId + 1.0), i);
			vec4 paletteColor = mix(texture2D(u_palTexture, vec2(testPos.x - u_pixelSize.x, testPos.y)), texture2D(u_palTexture, testPos), fract(u_paletteId));
			
			if (pattern_enabled == 1) { // Pattern Shader. Special thanks to @mimpy from the Gamemaker Discord
				for (int j = 0; j < 2; j += 1) { 
					if (u_color_array[j] == floor((i - corner.y) * (1.0 / u_pixelSize.y))) {	
						
                    	vec2 origin_dist_coord = mod((v_vPosition.xy - u_src_spriteDimension.xy) / u_src_spriteDimension.zw, 1.0);
						vec4 patcol = texture2D(u_loop_texture, origin_dist_coord);
                        // Blend pattern with the palette color
                        vec3 mixedCol = mix(patcol.rgb, paletteColor.rgb, paletteColor.a);
                        paletteColor = vec4(mixedCol, patcol.a);
                        
					}
				}
			}
			
			return paletteColor;
		}
    }
    return inCol;
}
void main() {
	vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
	DoAlphaTest( col );
	col = findAltColor(col, u_Uvs.xy);
	gl_FragColor = v_vColour * col;
}