extends Node
class_name Sauce

# Define Sauce and SaucePacket structs
var SaucePacket = preload("res://sauce_packet.gd")
var SauceRecord = preload("res://sauce_record.gd")

# Initialize shared variables
var sauce_data_type = ["None", "Character", "Bitmap", "Vector", "Audio", "BinaryText", "XBin", "Archive", "Executable"]
var sauce_character_types = ["ASCII", "ANSI", "ANSIMation", "RIP script", "PCBoard", "Avatar", "HTML", "Source", "TundraDraw"]
var sauce_bitmap_types = ["GIF", "PCX", "LBM/IFF", "TGA", "FLI", "FLC", "BMP", "GL", "DL", "WPG", "PNG", "JPG/JPeg", "MPG", "AVI"]
var sauce_vector_types = ["DXF", "DWG", "WPG", "3DS"]
var sauce_audio_types = ["MOD", "669", "STM", "S3M", "MTM", "FAR", "ULT", "AMF", "DMF", "OKT", "ROL", "CMF", "MID", "SADT", "VOC", "WAV", "SMP8", "SMP8S", "SMP16", "SMP16S", "PATCH8", "PATCH16", "XM", "HSC", "IT"]
var sauce_archive_types = ["ZIP", "ARJ", "LZH", "ARC", "TAR", "ZOO", "RAR", "UC2", "PAK", "SQZ"]

var sauce_record = SauceRecord.new()
var sauce_packet = SaucePacket.new()

# Initialize SaucePacket
func init_packet():
	sauce_record = SauceRecord.new()
	sauce_packet = SaucePacket.new()

# Fill the SaucePacket with data
func fill_packet():
	sauce_packet.data_type = sauce_data_type[sauce_record.data_type]

	match sauce_packet.data_type:
		"None":
			sauce_packet.file_type = "None"
		"Character":
			sauce_packet.file_type = sauce_character_types[sauce_record.file_type]
			match sauce_packet.file_type:
				"ASCII", "ANSI", "PCBoard", "Avatar", "TundraDraw":
					sauce_packet.character_width = sauce_record.t_info1
					sauce_packet.number_of_lines = sauce_record.t_info2
					sauce_packet.font_name = sauce_record.t_info_s
					parse_tflags()
				"ANSIMation":
					sauce_packet.character_width = sauce_record.t_info1
					sauce_packet.character_screen_height = sauce_record.t_info2
					sauce_packet.font_name = sauce_record.t_info_s
					parse_tflags()
				"RIP script":
					sauce_packet.pixel_width = sauce_record.t_info1
					sauce_packet.pixel_height = sauce_record.t_info2
					sauce_packet.number_of_colors = sauce_record.t_info3
		"Bitmap":
			sauce_packet.file_type = sauce_bitmap_types[sauce_record.file_type]
			sauce_packet.pixel_width = sauce_record.t_info1
			sauce_packet.pixel_height = sauce_record.t_info2
			sauce_packet.pixel_depth = sauce_record.t_info3
		"Vector":
			sauce_packet.file_type = sauce_vector_types[sauce_record.file_type]
		"Audio":
			sauce_packet.file_type = sauce_audio_types[sauce_record.file_type]
			match sauce_packet.file_type:
				"SMP8", "SMP8S", "SMP16", "SMP16S":
					sauce_packet.sample_rate = sauce_record.t_info1
		"BinaryText":
			sauce_packet.file_type = "BinaryText"
			sauce_packet.font_name = sauce_record.t_info_s
			parse_tflags()
		"XBin":
			sauce_packet.file_type = "XBin"
			sauce_packet.character_width = sauce_record.t_info1
			sauce_packet.number_of_lines = sauce_record.t_info2
		"Archive":
			sauce_packet.file_type = sauce_archive_types[sauce_record.file_type]
		"Executable":
			sauce_packet.file_type = "Executable"

# Print the SaucePacket
func print_packet():
	print("Sauce ID: ", sauce_record.id)
	print("Sauce Version: ", sauce_record.version)
	print("Title: ", sauce_record.title)
	print("Author: ", sauce_record.author)
	print("Group: ", sauce_record.group)
	print("Date: ", sauce_record.date)
	print("FileSize: ", sauce_record.file_size)
	print("DataType: ", sauce_record.data_type, "(", sauce_data_type[sauce_record.data_type], ")")
	print("FileType: ", sauce_record.file_type)

	match sauce_data_type[sauce_record.data_type]:
		"None":
			print("No Data Type Detected")
		"Character":
			print("Character Data Type Detected: ", sauce_character_types[sauce_record.file_type])
			match sauce_character_types[sauce_record.file_type]:
				"ASCII", "ANSI", "PCBoard", "Avatar", "TundraDraw":
					print("Character Width: ", sauce_packet.character_width)
					print("Number of Lines: ", sauce_packet.number_of_lines)
					print("Font Name: ", sauce_packet.font_name)
					print("iCE Colors: ", sauce_packet.ice_colors)
					print("Letter Spacing: ", sauce_packet.letter_spacing)
					print("Aspect Ratio: ", sauce_packet.aspect_ratio)
				"ANSIMation":
					print("Character Width: ", sauce_packet.character_width)
					print("Character Screen Height: ", sauce_record.t_info2)
					print("Font Name: ", sauce_packet.font_name)
					print("iCE Colors: ", sauce_packet.ice_colors)
					print("Letter Spacing: ", sauce_packet.letter_spacing)
					print("Aspect Ratio: ", sauce_packet.aspect_ratio)
				"RIP script":
					print("Pixel Width: ", sauce_packet.pixel_width)
					print("Pixel Height: ", sauce_packet.pixel_height)
					print("# Colors: ", sauce_packet.number_of_colors)
		"Bitmap":
			print("Bitmap Data Type Detected: ", sauce_bitmap_types[sauce_record.file_type])
			print("Pixel Width: ", sauce_packet.pixel_width)
			print("Pixel Height: ", sauce_packet.pixel_height)
			print("Pixel Depth: ", sauce_packet.pixel_depth)
		"Vector":
			print("Vector Data Type Detected: ", sauce_vector_types[sauce_record.file_type])
		"Audio":
			print("Audio Data Type Detected: ", sauce_audio_types[sauce_record.file_type])
			match sauce_audio_types[sauce_record.file_type]:
				"SMP8", "SMP8S", "SMP16", "SMP16S":
					print("Sample Rate: ", sauce_packet.sample_rate)
		"BinaryText":
			print("Binary Text Detected: BIN / RAW")
			print("Font Name: ", sauce_packet.font_name)
		"XBin":
			print("XBin Data Type Detected.")
			print("Character Width: ", sauce_packet.character_width)
			print("Number of Lines: ", sauce_packet.number_of_lines)
		"Archive":
			print("Archive Data Type Detected: ", sauce_archive_types[sauce_record.file_type])
		"Executable":
			print("Executable Detected.")

	if sauce_record.comments > 0:
		print("Comments: ", sauce_packet.comments)

# Get Sauce record from file Sauce header
func get_record(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if FileAccess.file_exists(file_path):
		var file_size = file.get_len()

		file.seek(file_size - 128)
		sauce_record = file.get_var()

		if sauce_record.id == "SAUCE":
			if sauce_record.comments > 0:
				var comment_id = ""
				file.seek(file_size - 128 - (sauce_record.comments * 64) - 5)
				comment_id = file.get_var()
				if comment_id == "COMNT":
					for i in range(sauce_record.comments, 0, -1):
						var comment = file.get_buffer(64).get_string_from_utf8()
						sauce_packet.comments += comment + "\n"

		file.close()

# Parse Sauce record TFlags field to determine iCE Colors, Letter Spacing, and Aspect Ratio
func parse_tflags():
	sauce_packet.ice_colors = "ON" if sauce_record.t_flags & 1 > 0 else "OFF"

	if sauce_record.t_flags & 2 == 0 and sauce_record.t_flags & 4 == 0:
		sauce_packet.letter_spacing = "Legacy / No preference"
	elif sauce_record.t_flags & 2 == 0 and sauce_record.t_flags & 4 > 0:
		sauce_packet.letter_spacing = "8px font / 9px line-spacing"
	elif sauce_record.t_flags & 2 > 0 and sauce_record.t_flags & 4 == 0:
		sauce_packet.letter_spacing = "9px font / 9px line-spacing"
	elif sauce_record.t_flags & 2 > 0 and sauce_record.t_flags & 4 > 0:
		sauce_packet.letter_spacing = "8px font / 8px line-spacing"

	if sauce_record.t_flags & 8 == 0 and sauce_record.t_flags & 16 == 0:
		sauce_packet.aspect_ratio = "Legacy / No preference"
	elif sauce_record.t_flags & 8 == 0 and sauce_record.t_flags & 16 > 0:
		sauce_packet.aspect_ratio = "1:1.35"
	elif sauce_record.t_flags & 8 > 0 and sauce_record.t_flags & 16 == 0:
		sauce_packet.aspect_ratio = "1:1.2"
	elif sauce_record.t_flags & 8 > 0 and sauce_record.t_flags & 16 > 0:
		sauce_packet.aspect_ratio = "Custom"
