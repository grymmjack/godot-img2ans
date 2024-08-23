extends Node

class_name SAUCE_RECORD

var id: String = "     " # 5 characters
var version: String = "  " # 2 characters
var title: String = " ".rpad(35, " ") # 35 characters
var author: String = " ".rpad(20, " ") # 20 characters
var group: String = " ".rpad(20, " ") # 20 characters
var date: String = " ".rpad(8, " ") # 8 characters
var file_size: int = 0 # Unsigned long (32-bit)
var data_type: int = 0 # Unsigned char (8-bit)
var file_type: int = 0 # Unsigned char (8-bit)
var t_info1: int = 0 # Unsigned short (16-bit)
var t_info2: int = 0 # Unsigned short (16-bit)
var t_info3: int = 0 # Unsigned short (16-bit)
var t_info4: int = 0 # Unsigned short (16-bit)
var comments: int = 0 # Unsigned char (8-bit)
var t_flags: int = 0 # Unsigned char (8-bit)
var t_info_s: String = " ".rpad(22, " ") # 22 characters
