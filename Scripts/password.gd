extends Node2D

@onready var label = $Label

var is_strong = false
var text = ""

func _ready():
	randomize()
	
	var strong_passwords = [
		"$uperSecure123", 
		"P@ssw0rd2024", 
		"M1ghtyLock!",
		"Xy7$gT#8nF",
		"B3tter$ecurity",
		"DragonF1re_2025",
		"StrongP@ss!",
		"Saf3tyF1rst#"
	]
	
	var weak_passwords = [
		"12345", 
		"password", 
		"abc",
		"qwerty",
		"iloveyou",
		"admin",
		"letmein",
		"football"
		
	]

	# Randomly pick strong or weak
	if randi() % 2 == 0:
		is_strong = true
		text = strong_passwords[randi() % strong_passwords.size()]
	else:
		is_strong = false
		text = weak_passwords[randi() % weak_passwords.size()]

	label.text = text
