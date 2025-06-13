extends Node2D

@export var id: int
@export var stationName: String
@export_enum("Local", "Connector", "Large", "Hub") var stationSize
@export_enum("Player", "None", "ScottishRail", "UnitedRail", "BirminghamExpress", "LondonFreighters") var stationOwner
@export var connections: Array
@onready var nameplate = $Sprite2D/Nameplate
@onready var stationUI = $StationUI

var stationValue # value = 500000 * (connections.size() / 2) * company multiplier
var notInContract = true
var holdingItem = false
var seethroughText = false
var hoveringOverStation = false

var ownerList = ["You", "Unowned", "Scottish\nRail", "United\nRail", "Birmingham\nExpress", "London\nFreighters"]

var contract = {
	available = false,
	active = false,
	current = null,
}

func _ready():
	if Settings.stationNamesAlwaysVisible: nameplate.visible = true
	StationManager.stations.append(self)
	nameplate.text = stationName
	$StationUI/Nameplate.text = stationName
	$StationUI/Owner.text = ownerList[stationOwner]
	stationValue = 500000 * (connections.size() / 2) * stationOwner
	if connections.size() / 2 == 0: stationValue = 250000 * stationOwner
	$StationUI/UnownedStation/ValueRect/Value.text = str(stationValue)
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
