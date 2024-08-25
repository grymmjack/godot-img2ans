@tool
extends Sprite2D

# Reference to the material with the shader
#@export var color_reduced_dithered : ShaderMaterial
#@export var colors : int = 4
#@export var dither : int = 4

func _ready():
	#var my_inherited_texture : ImageTexture = await $Posterized.posterized_texture
	#texture = my_inherited_texture
	#color_reduced_dithered.set_shader_parameter("colors", colors)
	#color_reduced_dithered.set_shader_parameter("dither", dither)
	pass

func _process(delta: float) -> void:
	pass
	#color_reduced_dithered.set_shader_parameter("colors", colors)
	#color_reduced_dithered.set_shader_parameter("dither", dither)
	#queue_redraw()
