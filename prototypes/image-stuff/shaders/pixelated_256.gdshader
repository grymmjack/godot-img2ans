shader_type canvas_item;

uniform float cellSize : hint_range(0, 256) = 0;
uniform float resX : hint_range(2, 256) = 32;
uniform float resY : hint_range(2, 256) = 32;

// 0.100392156862 is the cube root of 255
uniform vec3 rgb255 = vec3(0.100392156862, 0.100392156862, 0.100392156862);

void fragment() {
	float uvX = UV.x - mod(UV.x * float(resX), 1) / float(resX);
	float uvY = UV.y - mod(UV.y * float(resY), 1) / float(resY);

	if (cellSize > 0.0) {
		uvX = UV.x - mod(UV.x * float(cellSize), 1) / float(cellSize);
		uvY = UV.y - mod(UV.y * float(cellSize), 1) / float(cellSize);
	}

	vec2 grid_uv = vec2(uvX, uvY);

	vec4 col = texture(TEXTURE, grid_uv);

	if(col.r < 1.0 && col.g < 1.0 && col.b < 1.0) {
		vec3 remainder = mod(col.rgb, rgb255);
		col.rgb = col.rgb - remainder;
	}

	COLOR = col;
}