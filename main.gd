extends Node2D

func _input(event):
	if event.is_action_pressed("exit"):
		print("ESC = quitting!")
		get_tree().quit()
	if event.is_action_pressed("show_window"):
		print("Showing window with hotkey")
		get_node("./win").show()
	if event.is_action_pressed("hide_window"):
		print("Hiding window with hotkey")
		get_node("./win").hide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
