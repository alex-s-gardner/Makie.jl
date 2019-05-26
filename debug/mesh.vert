#version 300 es
precision mediump int;
precision mediump float;
precision mediump sampler2D;
precision mediump sampler3D;

// Instance inputs: 
in vec3 position;
vec3 get_position(){return position;}
in vec4 color;
vec4 get_color(){return color;}
in vec3 normals;
vec3 get_normals(){return normals;}

// Uniforms: 
uniform bool uniform_color;
bool get_uniform_color(){return uniform_color;}
uniform vec2 texturecoordinates;
vec2 get_texturecoordinates(){return texturecoordinates;}
uniform bool shading;
bool get_shading(){return shading;}



out vec2 frag_uv;
out vec3 frag_normal;
out vec3 frag_position;
out vec4 frag_color;
out vec3 frag_lightdir;

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;

vec3 tovec3(vec2 v){return vec3(v, 0.0);}
vec3 tovec3(vec3 v){return v;}

vec4 tovec4(vec3 v){return vec4(v, 1.0);}
vec4 tovec4(vec4 v){return v;}

void main(){
    // get_* gets the global inputs (uniform, sampler, vertex array)
    // those functions will get inserted by the shader creation pipeline
    vec3 vertex_position = tovec3(get_position());
    vec3 lightpos = vec3(20,20,20);
    frag_normal = get_normals();
    vec4 position_world = modelMatrix * vec4(vertex_position, 1);
    frag_lightdir = normalize(lightpos - position_world.xyz);
    // direction to camera
    frag_position = -position_world.xyz;
    frag_uv = get_texturecoordinates();
    frag_uv = vec2(1.0 - frag_uv.y, frag_uv.x);
    frag_color = tovec4(get_color());

    // screen space coordinates of the vertex
    gl_Position = projectionMatrix * viewMatrix * position_world;
}

