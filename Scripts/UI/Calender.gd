extends Control

var time = {
	minute = 59,
	hour = 23,
	day = 0,
	month = 1,
	year = 2025,
}
var displayNames = {
	daySuffix = ["st", "nd", "rd", "th"],
	monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
	activeMonth = "January",
	activeDaySuffix = "st"
}
var minuteFiller = "0"
var hourFiller = "0"
var currentSpeed = 0
var speedBeforePause = 1
var timeSpeed = [0, 60, 360, 1200]

var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
var floatMinutes = 59
var savedTime
var previousPayday = 0
var isPayday = false

func _ready():
	display_date()

func _physics_process(delta):
	if Input.is_action_just_pressed("Pause"): 
		if currentSpeed == 0:
			currentSpeed = speedBeforePause
		else: 
			speedBeforePause = currentSpeed
			currentSpeed = 0
	floatMinutes += delta * timeSpeed[currentSpeed]
	time.minute = floor(floatMinutes)
	display_time()
	if floatMinutes > 60:
		time.hour += 1
		floatMinutes = 0
		if time.hour > 23: update_day()
func update_day():
	time.day += 1
	time.hour = 0
	MapTrainManager.spawn_trains()
	display_date()
	if time.day > daysInMonth[time.month - 1] - 1: update_month()
	update_payday()
func update_month():
	time.month += 1
	time.day = 1
	get_parent().get_parent().get_parent().refreshAuctionHouse = true # this is a silly line, it refers to the player
	if time.month != 13: display_date()
	if time.month > 12: update_year()
func update_year():
	time.year += 1
	time.month = 1
	display_date()

func update_payday():
	if time.day == 1 or time.day == previousPayday + 7: 
		isPayday = true
		previousPayday = time.day
		for station in StationManager.stations:
			station.generate_passive_income()

func display_time():
	minuteFiller = "0" if time.minute < 10 else ""
	hourFiller = "0" if time.hour < 10 else ""
	$DateStats/Time.text = str(hourFiller, time.hour, ":", minuteFiller, int(time.minute))

func display_date():
	if time.day == 1 or time.day == 21 or time.day == 31: displayNames.activeDaySuffix = displayNames.daySuffix[0]
	elif time.day == 2 or time.day == 22: displayNames.activeDaySuffix = displayNames.daySuffix[1]
	elif time.day == 3 or time.day == 23: displayNames.activeDaySuffix = displayNames.daySuffix[2]
	else: displayNames.activeDaySuffix = displayNames.daySuffix[3]
	displayNames.activeMonth = displayNames.monthNames[time.month - 1]
	$DateStats/Date.text = str(time.day, displayNames.activeDaySuffix, " of ", displayNames.activeMonth, " ", time.year)

func display_weekly_income():
	var totalWeeklyIncome = 0
	for station in StationManager.stations:
		if station.stationOwner == 0: totalWeeklyIncome += station.weeklyIncome
	$DateStats/WeeklyIncome.text = str("Weekly Income: £", totalWeeklyIncome)

func _on_speed_button_1_pressed():
	currentSpeed = 1


func _on_speed_button_2_pressed():
	currentSpeed = 2


func _on_speed_button_3_pressed():
	currentSpeed = 3


func _on_pause_button_pressed():
	currentSpeed = 0
