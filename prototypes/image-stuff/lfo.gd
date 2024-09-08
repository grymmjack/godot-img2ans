@tool
@icon("res://lfo-icon.svg")
class_name LFO
extends Node

signal oscillate(value:float)
# signal lfo_cycle_started
# signal lfo_cycle_completed

enum WAVEFORM { SINE, TRIANGLE, SQUARE, SAW_UP, SAW_DOWN, NOISE }
@export var waveform:WAVEFORM
@export_range(0.01, 100.0) var frequency:float

var rng:RandomNumberGenerator = RandomNumberGenerator.new()

var _time:float
static var _time_cycle:float

func _init() -> void:
	print("LFO Constructor")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	print("LFO Ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_time += (120.0 / 60.0)
	print(_time/_time*delta)
	print(signf(_time/_time*delta))
	oscillate.emit(oscillator(lerp(0.0, _time/4.0, 0.1)))


func oscillator(_time:float) -> float:
	match waveform:
		WAVEFORM.SINE:
			return sine()
		WAVEFORM.TRIANGLE:
			return triangle()
		WAVEFORM.SQUARE:
			return square()
		WAVEFORM.SAW_UP:
			return saw_up()
		WAVEFORM.SAW_DOWN:
			return saw_down()
		WAVEFORM.NOISE:
			return fmod(frequency/100, noise())
		_:
			return _time
	

func sine() -> float:
	return float(sin(2 * PI * frequency * _time))


func triangle() -> float:
	return float(2 * abs(2*((_time * frequency) - int(_time * frequency + 0.5))) - 1)


func square() -> float:
	if (_time * frequency - int(_time * frequency)) < 0.5:
		return float(1.0)
	else:
		return float(-1.0)


func saw_up() -> float:
	return float(2 * ((_time * frequency) - int(_time * frequency)) - 1)


func saw_down() -> float:
	return float(1 - 2 * ((_time * frequency) - int(_time * frequency)))


func noise() -> float:
	return rng.randf_range(0.0, 1.0)
