extends Node2D

@export var id: int
@export var stationName: String
@export_enum("Local", "Connector", "Large", "Hub") var stationSize
@export_enum("None", "Player", "United Rail", "Birmingham Express", "Scottish Rail", "London Freighters") var stationOwner
@export var connections: Array

var stationValue # value = 500000 * (connections.size() / 2) * company multiplier
var notInContract = true
var holdingItem = false

var contract = {
	available = false,
	active = false,
	current = null,
	
	
}

func _ready():
	StationManager.stations.append(self)
