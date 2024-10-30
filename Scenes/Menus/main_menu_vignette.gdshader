shader_type canvas_item;

uniform float outerRadius : hint_range(0.0, 5.0) = 1.0;
uniform float MainAlpha : hint_range(0.0, 1.0) = 1.0;
uniform float red : hint_range(0.0, 1.0, 0.1);
uniform float green : hint_range(0.0, 1.0, 0.1);
uniform float blue : hint_range(0.0, 1.0, 0.1);

void fragment() {
	float x = abs(UV.x-.5)*2.0;
	float y = abs(UV.y-.5)*2.0;
	float v = (sqrt((x*x)+(y*y))/outerRadius);
	COLOR = vec4(red,green,blue,v*MainAlpha);
}