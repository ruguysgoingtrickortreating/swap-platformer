shader_type canvas_item;

uniform vec2 resolution;

void fragment()
{
vec2 p = -1.0 + 2.0 * UV.xy / resolution.xy;
vec2 uv;

float a = atan(p.y,p.x);
float r = sqrt(dot(p,p));

uv.x = 0.1/r;
uv.y = a/(3.1416);

vec3 col = texture(TEXTURE,uv).xyz;

COLOR = vec4(col,1.0);
}