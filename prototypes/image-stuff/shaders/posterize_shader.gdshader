shader_type canvas_item;

uniform float levels : hint_range(1.0, 32.0);

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float step_size = 1.0 / float(levels);
    color.rgb = floor(color.rgb / step_size) * step_size;
    COLOR = color;
}
