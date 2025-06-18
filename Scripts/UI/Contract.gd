extends Control

var contractList = get_parent()
var assignedTrain: Train
var targetOne
var targetTwo
@onready var calender = get_tree().get_first_node_in_group("Calender")

func _ready():
	await get_tree().create_timer(0.3).timeout
	StationManager.refresh_contract_ready_stations()
	targetOne = StationManager.contractReadyStations[randi_range(0, StationManager.contractReadyStations.size())]
	targetOne.notInContract = false
	StationManager.refresh_contract_ready_stations()
	targetTwo = StationManager.contractReadyStations[randi_range(0, StationManager.contractReadyStations.size())]
	targetTwo.notInContract = false
	StationManager.refresh_contract_ready_stations()
	$Toolbar/Locations/Label.text = str(targetOne.stationName, "\n-\n", targetTwo.stationName)

func format_time_remaining(seconds: float):
	if seconds <= 0:
		arrived_at_destination()
		return
	var gameTimeSeconds = seconds * calender.timeSpeed[calender.currentSpeed]
	
	var minutes: int = floor(gameTimeSeconds / 60.0)
	var hours: int = floor(minutes / 60.0)
	var days: int = floor(hours / 24.0)
	
	var label = $Toolbar/TrainEnRoute/TimeLeft
	if days > 0:
		label.text = str(int(days), "d ", int(hours % 24), "h")
	elif hours > 0:
		label.text = str(int(hours), "h ", int(minutes % 60), "m")
	else:
		label.text = str(int(minutes), "m ", int(int(gameTimeSeconds) % 60), "s")


func _on_choose_train_button_pressed(): # TODO TODO NEEDS REWORK TO LIST AVAILABLE TRAINS
	assignedTrain = Companies.companies.Player.trains[0]
	assignedTrain.assignedToContract = true
	$Toolbar/ChooseTrain.visible = false
	$Toolbar/DurationButtons.visible = true

func arrived_at_destination():
	print("arrived at destination")
	assignedTrain.assignedToContract = false
	targetOne.notInContract = true
	targetTwo.notInContract = true
	StationManager.refresh_contract_ready_stations()


func _on_cheapest_route_button_pressed():
	assignedTrain.homeStationNode.spawn_train(Dijkstra.find_route("Cheapest", assignedTrain.homeStationNode, targetOne, targetTwo, true), assignedTrain.trainType, self)
	init_train_en_route_screen()

func _on_fastest_route_button_pressed():
	assignedTrain.homeStationNode.spawn_train(Dijkstra.find_route("Fastest", assignedTrain.homeStationNode, targetOne, targetTwo, true), assignedTrain.trainType, self)
	init_train_en_route_screen()

func init_train_en_route_screen():
	$Toolbar/DurationButtons.visible = false
	$Toolbar/TrainEnRoute.visible = true
	$Toolbar/TrainEnRoute/TrainSprite.play(assignedTrain.trainType)
