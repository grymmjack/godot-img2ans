// https://chatgpt.com/share/9663b41b-ed83-46ad-adc7-5ed0a2aeabec
// by: grymmjack (chat gpt-4o) :D

shader_type canvas_item;

uniform float levels : hint_range(1.0, 32.0) = 5.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float step_size = 1.0 / float(levels);
    color.rgb = floor(color.rgb / step_size) * step_size;
    COLOR = color;
}
