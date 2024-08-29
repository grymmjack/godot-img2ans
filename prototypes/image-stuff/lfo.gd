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

var value:float

func _init() -> void:
	print("LFO Constructor")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	print("LFO Ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = (Time.get_ticks_msec() + delta) * 0.0001
	oscillate.emit(oscillator(value))


func oscillator(value:float) -> float:
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
			return value
	

func sine() -> float:
	return float(sin(2 * PI * frequency * value))


func triangle() -> float:
	return float(2 * abs(2*((value * frequency) - int(value * frequency + 0.5))) - 1)


func square() -> float:
	if (value * frequency - int(value * frequency)) < 0.5:
		return float(1.0)
	else:
		return float(-1.0)


func saw_up() -> float:
	return float(2 * ((value * frequency) - int(value * frequency)) - 1)


func saw_down() -> float:
	return float(1 - 2 * ((value * frequency) - int(value * frequency)))


func noise() -> float:
	return rng.randf_range(0.0, 1.0)
