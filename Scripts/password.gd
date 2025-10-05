extends Node2D

@onready var label = $Label

var is_strong = false
var text = ""

static var strong_passwords = [
	"$uperSecure123", "P@ssw0rd2024", "M1ghtyLock!", "Xy7$gT#8nF", 
	"B3tter$ecurity", "DragonF1re_2025", "StrongP@ss!", "Saf3tyF1rst#",
	"Secr3tCode2025!", "F@stTrack2024", "R3liable!P@ssw0rd",
	"Unbr3ak@ble2024!", "Gr3atPassw0rd!", "Sh@dowC0de2024!", "Z3roRisk!@2025",
	"F0rtKn0x!Pass", "Titan$hield2025", "Cyb3rW@ll!", "P@ssDef3nder#99",
	"H@rd2Gu3ss!2025", "Crypt0P@ss#88", "Str0ngHold_2024", "Invinc1bleKey!",
	"S@feHarb0r2025", "L0ck&L0ad#77", "IronW@llP@ss!", "Ult1m@teK3y#2025",
	"Sh13ldM@trix2025", "P0w3rC0de!88", "Eagl3Ey3#2024", "Unh@ck@bleX99",
	"S3cur1tyW@ve!", "Tru$tedK3y2025", "N1njaLock#77", "Str1k3F0rce!X",
	"B@stionP@ss2025", "Cyb3rG@rd#66", "Kn1ghtK3y!88", "H@wkSh1eld2025"
]

static var weak_passwords = [
	"12345", "password", "abc", "qwerty", "iloveyou", 
	"admin", "letmein", "football", "123456789", "welcome",
	"monkey", "123123", "qwerty123", "trustno1", "sunshine",
	"0000", "111111", "dragon", "baseball", "asdfgh",
	"love", "princess", "starwars", "pokemon", "pass",
	"hello", "freedom", "whatever", "master", "login",
	"guest", "password1", "batman", "ninja", "1234567",
	"superman", "000000", "iloveu", "654321", "abc123",
	"mypassword", "default", "qazwsx", "computer", "soccer"
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
