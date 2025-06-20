extends Node

var wealth = 0
var ownedTrains = []
var ownedStations = []
@onready var camera = $Camera
var contractRangeSizes = [Vector2(1, 1), Vector2(1.5, 1.5), Vector2(2.2, 2.2), Vector2(8, 8)]
var currentContractRange = Vector2(1, 1)
var currentRangeMultiplier = 1

func _ready():
	add_to_group("Player")
	await get_tree().create_timer(0.1).timeout
	check_total_station_count()
	Companies.companies.Player.trains.append(Train.new("Steam", "Dundee"))

func _physics_process(delta):
	
	$Camera/UI/PlayerStats/Wealth.text = str("Wealth: £", wealth)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT): wealth += 100000

func check_total_station_count():
	match ownedStations.size():
		7:
			currentContractRange = contractRangeSizes[1]
			currentRangeMultiplier = 2.5
			change_contract_reach()
		12:
			currentContractRange = contractRangeSizes[2]
			currentRangeMultiplier = 4
			change_contract_reach()
		20:
			currentContractRange = contractRangeSizes[3]
			currentRangeMultiplier = 7
			change_contract_reach()
		

func change_contract_reach():
	var contractRange = get_tree().get_first_node_in_group("ContractRange")
	contractRange.scale = currentContractRange


func _on_contract_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	StationManager.stationsInContractRange.append(area.get_parent())
