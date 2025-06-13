extends Control

var time = {
	minute = 0,
	hour = 0,
	day = 31,
	month = 12,
	year = 2025
}
var displayNames = {
	daySuffix = ["st", "nd", "rd", "th"],
	monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
	activeMonth = "January",
	activeDaySuffix = "st"
}
var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
var floatMinutes = 0
var savedTime
var previousPayday = 0
var isPayday = false

func _ready():
	display_date()

func _physics_process(delta):
	print(time)
	floatMinutes += delta * 20
	if Input.is_action_pressed("Fast Forward"): floatMinutes += delta * 100
	time.minute = floor(floatMinutes)
	display_time()
	if floatMinutes > 60:
		time.hour += 1
		floatMinutes = 0
		if time.hour > 23: update_day()
func update_day():
	update_payday()
	time.day += 1
	time.hour = 0
	display_date()
	if time.day > daysInMonth[time.month - 1] - 1: update_month()
func update_month():
	time.month += 1
	time.day = 1
	if time.month != 13: display_date()
	if time.month > 12: update_year()
func update_year():
	time.year += 1
	time.month = 1
	display_date()

func update_payday():
	if time.day == 1 or time.day == previousPayday + 7:
		isPayday = true
		for station in StationManager.stations:
			station.generate_passive_income()
	previousPayday = time.day

func display_time():
	$DateStats/Time.text = str(time.hour, ":", int(time.minute))

func display_date():
	if time.day == 1 or time.day == 21 or time.day == 31: displayNames.activeDaySuffix = displayNames.daySuffix[0]
	elif time.day == 2 or time.day == 22: displayNames.activeDaySuffix = displayNames.daySuffix[1]
	elif time.day == 3 or time.day == 23: displayNames.activeDaySuffix = displayNames.daySuffix[2]
	else: displayNames.activeDaySuffix = displayNames.daySuffix[3]
	displayNames.activeMonth = displayNames.monthNames[time.month - 1]
	print(str(time.day, displayNames.activeDaySuffix, " of ", displayNames.activeMonth, " ", time.year))
	$DateStats/Date.text = str(time.day, displayNames.activeDaySuffix, " of ", displayNames.activeMonth, " ", time.year)
