extends Control

@export var companyName: String
@export var internalName: String
var companyMainColour: Color
var companySecondaryColour: Color
@export var weeklyValue: int
var stationCount
var trainCount
var disabled = false

func _ready():
	await get_tree().create_timer(0.1).timeout
	trainCount = Companies.companies[internalName].trains.size()
	companyMainColour = Companies.colours[internalName].inner
	companySecondaryColour = Companies.colours[internalName].outer
	$Toolbar/Name/Label.text = companyName
	$Toolbar/Trains/Label.text = str("Train\nCount\n", trainCount)
	$Toolbar/AcquisitionValue/Label.text = str("Acquisition Value:\n£", weeklyValue)
	$Toolbar.color = companyMainColour
	$Toolbar/Name.color = companyMainColour
	$Toolbar/Trains.color = companyMainColour
	$Toolbar/Stations.color = companyMainColour
	$Toolbar/Outline.color = companySecondaryColour
	$Toolbar/Trains/Outline.color = companySecondaryColour
	$Toolbar/Stations/Outline.color = companySecondaryColour
	$Toolbar/Name/Outline.color = companySecondaryColour
	$Toolbar/AcquisitionValue.color = companyMainColour
	$Toolbar/AcquisitionValue/Outline.color = companySecondaryColour
	
	var newLabelSettings = LabelSettings.new()
	newLabelSettings.font = load("res://Assets/Fonts/dogicabold.ttf")
	newLabelSettings.font_size = 8
	newLabelSettings.font_color = companySecondaryColour
	$Toolbar/Name/Label.label_settings = newLabelSettings
	$Toolbar/Trains/Label.label_settings = newLabelSettings
	$Toolbar/Stations/Label.label_settings = newLabelSettings
	$Toolbar/AcquisitionValue/Label.label_settings = newLabelSettings

func _physics_process(delta):
	if disabled: return
	var stations = []
	for station in Companies.companies[internalName].stations:
		stations.append(station.stationName)
	$Toolbar/Stations/Label.text = str("Stations:\n")
	for station in stations:
		$Toolbar/Stations/Label.text += str(", ", station) if station != stations[0] else station
	if stations == []: 
		disabled = true
		$Toolbar/Stations/Label.text = "Fully Acquired"
		$Toolbar/Trains/Label.text = "Fully Acquired"
		get_tree().get_first_node_in_group("Calender").additionalIncome += weeklyValue
		get_tree().get_first_node_in_group("Calender").display_weekly_income()
