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
var seethroughText = false

var contract = {
	available = false,
	active = false,
	current = null,
}

func _ready():
	if Settings.stationNamesAlwaysVisible: nameplate.visible = true
	StationManager.stations.append(self)
	nameplate.text = stationName
	for station in connections:
		var targetStation = get_node(station)
		var connectorTrack = Line2D.new()
		add_child(connectorTrack)
		connectorTrack.width = 2
		connectorTrack.default_color = Color(0.212, 0.212, 0.212)
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
	
