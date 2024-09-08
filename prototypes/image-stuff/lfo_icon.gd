@tool
extends Sprite2D

@onready var lfo = $LFO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("LFO Icon Ready")
	lfo.connect("oscillate", self._on_lfo_oscillate)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass


func _on_lfo_oscillate(value: float) -> void:
	print("on LFO: " + str(value))
	#position.x = cos(PI*value) * 250
	position.y = value * 100
