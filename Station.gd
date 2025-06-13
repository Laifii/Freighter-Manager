extends Node2D

@export var id: int
@export var stationName: String
@export_enum("Local", "Connector", "Large", "Hub") var stationSize
@export_enum("None", "Player", "United Rail", "Birmingham Express", "Scottish Rail", "London Freighters") var stationOwner
@export var connections: Array
@onready var nameplate = $Sprite2D/Nameplate

var stationValue # value = 500000 * (connections.size() / 2) * company multiplier
var notInContract = true
var holdingItem = false

var contract = {
	available = false,
	active = false,
	current = null,
	
	
}

func _ready():
	if Settings.stationNamesAlwaysVisible: nameplate.visible = true
	StationManager.stations.append(self)
	nameplate.text = stationName


func _on_area_2d_mouse_entered():
	if Settings.stationNamesAlwaysVisible: return
	nameplate.visible = true
	print(nameplate.text)


func _on_area_2d_mouse_exited():
	if Settings.stationNamesAlwaysVisible: return
	nameplate.visible = false
