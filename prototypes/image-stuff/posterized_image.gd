@tool
extends Sprite2D

# Reference to the material with the shader
#@export var posterize_material : ShaderMaterial
#@export_range(3.0, 255.0, 1.0, "levels") var levels: int
#@export var posterized_texture : ImageTexture

#signal posterize_changed

func _ready():
	## Wait until the frame has finished before getting the texture.
	#await RenderingServer.frame_post_draw
	## You can get the image after this.
	## Retrieve the captured Image using get_image().
	#var img = get_viewport().get_texture().get_image()
	## Convert Image to ImageTexture.
	#var tex = ImageTexture.create_from_image(img)
	#posterized_texture = tex
	pass
