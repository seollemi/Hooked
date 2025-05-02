extends Node2D

@onready var label = $Label

var is_strong = false
var text = ""

static var strong_passwords = [
	"$uperSecure123", "P@ssw0rd2024", "M1ghtyLock!", "Xy7$gT#8nF", 
	"B3tter$ecurity", "DragonF1re_2025", "StrongP@ss!", "Saf3tyF1rst#",
	"Secr3tCode2025!", "F@stTrack2024", "R3liable!P@ssw0rd",
	"Unbr3ak@ble2024!", "Gr3atPassw0rd!", "Sh@dowC0de2024!", "Z3roRisk!@2025"
]

static var weak_passwords = [
	"12345", "password", "abc", "qwerty", "iloveyou", 
	"admin", "letmein", "football", "123456789", "welcome",
	"monkey", "123123", "qwerty123", "trustno1", "sunshine"
]

func _ready():
	randomize()

	var available_strong = strong_passwords.filter(func(p): return !(p in Passwordtracker.used_passwords))
	var available_weak = weak_passwords.filter(func(p): return !(p in Passwordtracker.used_passwords))

	if available_strong.size() == 0 and available_weak.size() == 0:
		label.text = "No more passwords!"
		return

	if randi() % 2 == 0 and available_strong.size() > 0:
		is_strong = true
		var index = randi() % available_strong.size()
		text = available_strong[index]
	elif available_weak.size() > 0:
		is_strong = false
		var index = randi() % available_weak.size()
		text = available_weak[index]

	# Add the selected password to the used list
	Passwordtracker.used_passwords.append(text)
	label.text = text
