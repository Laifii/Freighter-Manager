extends Control

var time = {
	minute = 0,
	hour = 0,
	day = 1,
	month = 1,
	year = 2025
}
var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
var floatMinutes = 0
var savedTime

func _ready():
	pass

func _physics_process(delta):
	print(time)
	floatMinutes += delta * 10
	if Input.is_action_pressed("Fast Forward"): floatMinutes += delta * 50
	time.minute = floor(floatMinutes)
	if floatMinutes > 60:
		time.hour += 1
		floatMinutes = 0
		if time.hour > 24: update_day()
func update_day():
	time.day += 1
	time.hour = 0
	if time.day > daysInMonth[time.month - 1]: update_month()
func update_month():
	time.month += 1
	time.day = 1
	if time.month > 12: update_year()
func update_year():
	time.year += 1
	time.month = 1
