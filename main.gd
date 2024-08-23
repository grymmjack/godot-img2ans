extends Node

const E  = 27  # ESCAPE - The ANSI escape code
const B  = 219 #'█' BLOCK CHARACTER - Full block foreground
const FT = 223 #'▀' # HALF BLOCK Top FG Bottom BG
const FB = 220 #'▄' # HALF BLOCK Top BG Bottom FG

var sauce = preload("res://sauce.gd")

# ANSI color codes mapping
var ansi_map = [
	{ "rgbc": Color("#000000"), "fg_code": "0;30", "bg_code": "40" },   # BLACK
	{ "rgbc": Color("#0000AA"), "fg_code": "0;34", "bg_code": "44" },   # BLUE
	{ "rgbc": Color("#00AA00"), "fg_code": "0;32", "bg_code": "42" },   # GREEN
	{ "rgbc": Color("#00AAAA"), "fg_code": "0;36", "bg_code": "46" },   # CYAN
	{ "rgbc": Color("#AA0000"), "fg_code": "0;31", "bg_code": "41" },   # RED
	{ "rgbc": Color("#AA00AA"), "fg_code": "0;35", "bg_code": "45" },   # PURPLE
	{ "rgbc": Color("#AA5500"), "fg_code": "0;33", "bg_code": "43" },   # BROWN
	{ "rgbc": Color("#AAAAAA"), "fg_code": "0;37", "bg_code": "47" },   # WHITE
	{ "rgbc": Color("#555555"), "fg_code": "1;30", "bg_code": "5;40" }, # BRIGHT BLACK
	{ "rgbc": Color("#5555FF"), "fg_code": "1;34", "bg_code": "5;44" }, # BRIGHT BLUE
	{ "rgbc": Color("#55FF55"), "fg_code": "1;32", "bg_code": "5;42" }, # BRIGHT GREEN
	{ "rgbc": Color("#55FFFF"), "fg_code": "1;36", "bg_code": "5;46" }, # BRIGHT CYAN
	{ "rgbc": Color("#FF5555"), "fg_code": "1;31", "bg_code": "5;41" }, # BRIGHT RED
	{ "rgbc": Color("#FF55FF"), "fg_code": "1;35", "bg_code": "5;45" }, # BRIGHT PURPLE
	{ "rgbc": Color("#FFFF55"), "fg_code": "1;33", "bg_code": "5;43" }, # BRIGHT YELLOW
	{ "rgbc": Color("#FFFFFF"), "fg_code": "1;37", "bg_code": "5;47" }  # BRIGHT WHITE
]

func _ready():
	pass
	
func _on_file_dialog_file_selected(path: String) -> void:
	var img = Image.new()
	if img.load(path) != OK:
		return

	var src_w = img.get_width()
	var src_h = img.get_height()
	var ans = ""
	var forward_z = 0
	
	for y in range(0, src_h, 2):
		for x in range(src_w):
			var top_color    = img.get_pixel(x, y)
			var bottom_color = img.get_pixel(x, y + 1) if y + 1 < src_h else Color("#000000")
			var fg_code = ansi_map[0]["fg_code"]
			var bg_code = ansi_map[0]["bg_code"]
			var character = FT
			for z in range(ansi_map.size()):
				if top_color == ansi_map[z]["rgbc"]:
					fg_code = ansi_map[z]["fg_code"]
					forward_z = z
					break
			for z in range(ansi_map.size()):
				if bottom_color == ansi_map[z]["rgbc"]:
					bg_code = ansi_map[z]["bg_code"]
					forward_z = z
					break

			if fg_code != bg_code:
				if bottom_color == ansi_map[forward_z]["rgbc"]:
					character = FT
				else:
					character = FB
						
			ans += String.chr(E) + "[0m" + String.chr(E) + "[" + fg_code + ";" + bg_code + "m" + String.chr(character)

	var file = FileAccess.open(path + "-25-OPT.ans", FileAccess.WRITE)
	
	var char_array = ans.split()
	for char in char_array:
		file.store_8(char.unicode_at(0))
	file.close()

	# Assuming SAUCE.InitPacket is called during _init() to initialize the packets
	var slash = "/"
	if OS.get_name() == "Windows":
		slash = "\\"
	var filename = path + "-25-OPT.ans"
	var s = filename.substr(filename.rfind(slash) + 1, filename.length())
	var sauce_record:SAUCE_RECORD = SAUCE_RECORD.new()
	sauce_record.id = "SAUCE"
	sauce_record.version = "00"
	sauce_record.title = s.substr(0, min(s.length(), 35))  # Sauce title is max 35 chars
	sauce_record.author = "grymmjack"
	sauce_record.group = "MiSTiGRiS"
	sauce_record.date = "20231231"  # YYMMDD format
	sauce_record.file_size = file.get_length() - 1  # Size in bytes minus 1
	sauce_record.data_type = 1  # Character
	sauce_record.file_type = 1  # ANSI
	sauce_record.t_info1 = src_w  # Character width
	sauce_record.t_info2 = src_h / 2  # Number of lines, halved
	sauce_record.t_info3 = 0
	sauce_record.t_info4 = 0
	sauce_record.comments = 0
	sauce_record.t_flags = 3  # 8px iCE Colors
	sauce_record.t_info_s = "IBM VGA"  # Font name

	# Fill the sauce packet based on the filled sauce record
	var sauce:Sauce = Sauce.new()
	sauce.fill_packet()
	# Writing to the file
	#var file_sauced = FileAccess.open(filename + "-25-OPT.ans", FileAccess.WRITE_READ)
	file.seek(file.get_length() - 1)  # Move to the end of the file
	var sauce_string:String = "SAUCE" + str(sauce_record.version) + str(sauce_record.title) + str(sauce_record.author) + \
						str(sauce_record.group) + str(sauce_record.date) + str(sauce_record.file_size) + str(sauce_record.data_type) + \
						str(sauce_record.file_type) + str(sauce_record.t_info1) + str(sauce_record.t_info2) + \
						str(sauce_record.t_info3) + str(sauce_record.t_info4) + str(sauce_record.comments) + \
						str(sauce_record.t_flags) + str(sauce_record.t_info_s)
						
	var sauce_char_array = sauce_string.split()
	for char in sauce_char_array:
		file.store_8(char.unicode_at(0))
	file.close()
	
	print("ANSI art saved to: " + path + "-25-OPT.ans")
