extends Node2D

@export var id: int
@export var stationName: String
@export_enum("Local", "Connector", "Large", "Hub", "Capital") var stationSize
@export_enum("Player", "None", "ScottishRail", "UnitedRail", "BirminghamExpress", "LondonFreighters") var stationOwner
@export var connections: Array
@onready var nameplate = $Nameplate
@onready var stationUI = $StationUI
@onready var player = get_tree().get_first_node_in_group("Player")

var priceToUpgrade = [250000, 500000, 1000000, 2500000]
var stationValue 
var weeklyIncome
var notInContract = true
var holdingItem = false
var seethroughText = false
var hoveringOverStation = false
var companyColours = {
	Player = {inner = Color(0.83, 0.001, 0.83), outer = Color(1, 1, 1)},
	None = {inner = Color(0.8, 0.8, 0.8), outer = Color(0.355, 0.355, 0.355)},
	ScottishRail = {inner = Color(1, 1, 1), outer = Color(0.0, 0.369, 0.722)},
	UnitedRail = {inner = Color(0.784, 0.063, 0.18), outer = Color(0.004, 0.129, 0.412)},
	BirminghamExpress = {inner = Color(1.0, 0.898, 0.0), outer = Color(0.863, 0.141, 0.122)},
	LondonFreighters = {inner = Color(1, 0, 0), outer = Color(1, 1, 1)}
}

var sizeList = ["Local", "Connector", "Large", "Hub", "Capital"]
var stationTax 
var companyList = ["Player", "None", "ScottishRail", "UnitedRail", "BirminghamExpress", "LondonFreighters"]
var visualOwnerList = ["You", "Unowned", "Scottish\nRail", "United\nRail", "Birmingham\nExpress", "London\nFreighters"]

var contract = {
	available = false,
	active = false,
	current = null,
}

func _ready():
	if Settings.stationNamesAlwaysVisible: nameplate.visible = true
	StationManager.stations.append(self)
	set_station_stats()
	initialise_tracks()
	if stationOwner == 0: 
		$StationUI/UnownedStation.visible = false
		$StationUI/OwnedStation.visible = true
	player.camera.calender.display_weekly_income()

func initialise_tracks():
	for station in connections:
		var targetStation = get_node(station)
		var connectorTrack = Line2D.new()
		add_child(connectorTrack)
		connectorTrack.width = 2
		connectorTrack.default_color = Color(0.589, 0.589, 0.589)
		connectorTrack.global_position = Vector2.ZERO
		connectorTrack.add_point(position)
		connectorTrack.add_point(targetStation.position)
		connectorTrack.z_index = -100

func initialise_new_track(targetStation):
	var connectorTrack = Line2D.new()
	add_child(connectorTrack)
	connectorTrack.width = 2
	connectorTrack.default_color = Color(0.589, 0.589, 0.589)
	connectorTrack.global_position = Vector2.ZERO
	connectorTrack.add_point(position)
	connectorTrack.add_point(targetStation.position)
	connectorTrack.z_index = -100

func set_station_stats():
	nameplate.text = stationName
	$StationUI/Nameplate.text = stationName
	$StationUI/Size.text = sizeList[stationSize]
	$StationUI/Owner.text = visualOwnerList[stationOwner]
	stationValue = 500000 * (connections.size() / 2) * stationOwner
	if connections.size() / 2 == 0: stationValue = 250000 * stationOwner
	weeklyIncome = 10000 * connections.size() * (stationSize + 1)
	$StationUI/Income.text = str("Income:\n", weeklyIncome, " / Week")
	$StationUI/UnownedStation/ValueRect/Value.text = str("£", stationValue)
	if stationSize == 4: 
		$StationUI/OwnedStation/UpgradeRect/Price/TextureButton.visible = false
		$StationUI/OwnedStation/UpgradeRect/Price.text = "Maximum Size"
	else: $StationUI/OwnedStation/UpgradeRect/Price.text = str(priceToUpgrade[stationSize])
	stationTax = 500 * (stationSize + 1)
	$StationColourInner.self_modulate = companyColours[companyList[stationOwner]]["inner"]
	$StationColourInner/StationColourOuter.self_modulate = companyColours[companyList[stationOwner]]["outer"]
	$StationColourInner.scale = Vector2(stationSize + 1, stationSize + 1)

func _on_area_2d_mouse_entered():
	if not Settings.stationNamesAlwaysVisible: nameplate.visible = true
	seethroughText = true

func _on_area_2d_mouse_exited():
	if not Settings.stationNamesAlwaysVisible: nameplate.visible = false
	seethroughText = false

func _physics_process(delta):
	if seethroughText and nameplate.modulate[3] > 0.35:
		nameplate.modulate[3] = lerp(nameplate.modulate[3], 0.3, 0.2)
	elif not seethroughText and nameplate.modulate[3] < 1:
		nameplate.modulate[3] = lerp(nameplate.modulate[3], 1.0, 0.2)
	if Input.is_action_just_pressed("Escape"): if $StationUI.visible: $StationUI.visible = false

func _unhandled_input(event):
	if not hoveringOverStation: return
	if event is not InputEventMouseButton: return
	if not event.is_pressed(): return
	if event.button_index != 1: return
	var selfState = $StationUI.visible
	for station in StationManager.stations:
		if station.stationUI.visible: station.stationUI.visible = false
	$StationUI.visible = !selfState

func _on_station_button_mouse_entered():
	hoveringOverStation = true

func _on_station_button_mouse_exited():
	hoveringOverStation = false

func _on_purchase_button_pressed():
	if player.wealth > stationValue:
		player.wealth -= stationValue
		stationOwner = 0
		set_station_stats()
		$StationUI/UnownedStation.visible = false
		$StationUI/OwnedStation.visible = true

func upgrade_station():
	if player.wealth < priceToUpgrade[stationSize]: return
	stationSize += 1
	set_station_stats()
	player.camera.calender.display_weekly_income()

func generate_passive_income():
	if not stationOwner == 0: return
	if player.camera.calender.isPayday:
		player.wealth += weeklyIncome


func _on_upgrade_button_pressed():
	upgrade_station()
