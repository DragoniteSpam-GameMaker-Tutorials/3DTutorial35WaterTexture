attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                   // (x,y,z)     unused in this shader.
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec4 in_Colour;                    // (r,g,b,a)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4(in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    vec3 eye_space_normal = (gm_Matrices[MATRIX_WORLD_VIEW] * vec4(in_Normal, 0.0)).xyz;
    vec3 eye_space_camera = vec3(0.0, 0.0, 1.0);
    
    float CdotN = clamp(1.0 + dot(normalize(eye_space_camera), normalize(eye_space_normal)), 0.25, 0.75);
    
    v_vColour = in_Colour;
    v_vColour.a = CdotN;
    v_vTexcoord = in_TextureCoord;
}
