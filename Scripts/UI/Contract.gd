extends Control

var contractList = get_parent()
var assignedTrain: Train
var targetOne
var targetTwo
@onready var calender = get_tree().get_first_node_in_group("Calender")
@onready var player = get_tree().get_first_node_in_group("Player")
var distanceLeft: int
var timeLeft
var reward
var upfront
var remainingTax
var cheapestRoute
var fastestRoute
var cheapestCost
var cheapestDistance
var fastestCost
var fastestDistance

func _ready():
	StationManager.refresh_contract_ready_stations()
	targetOne = StationManager.contractReadyStations[randi_range(0, StationManager.contractReadyStations.size() - 1)]
	targetOne.notInContract = false
	StationManager.refresh_contract_ready_stations()
	targetTwo = StationManager.contractReadyStations[randi_range(0, StationManager.contractReadyStations.size() - 1)]
	targetTwo.notInContract = false
	StationManager.refresh_contract_ready_stations()
	$Toolbar/Locations/Label.text = str(targetOne.stationName, "\n-\n", targetTwo.stationName)
	reward = int(randi_range(5000, 20000) * player.currentRangeMultiplier * float(estimate_route_distance()) / 500.0)
	upfront = float(reward) * randf_range(0.05, 0.4)
	reward -= upfront
	$Toolbar/Reward/Label.text = str("Total\n£", int(reward + upfront), "\nUpfront\n£", int(upfront))

func _on_choose_train_button_pressed(): # TODO TODO NEEDS REWORK TO LIST AVAILABLE TRAINS
	var availableTrains = []
	for train in Companies.companies.Player.trains:
		if not train.assignedToContract:
			availableTrains.append(train)
	if availableTrains.size() == 0: return
	assignedTrain = availableTrains[0]
	assignedTrain.assignedToContract = true
	$Toolbar/ChooseTrain.visible = false
	$Toolbar/DurationButtons.visible = true
	cheapestRoute = find_route("Cheapest")
	fastestRoute = find_route("Fastest")
	cheapestCost = find_route_stats(cheapestRoute)[0]
	cheapestDistance = find_route_stats(cheapestRoute)[1]
	fastestCost = find_route_stats(fastestRoute)[0]
	fastestDistance = find_route_stats(fastestRoute)[1]
	$Toolbar/DurationButtons/CheapestRoute/Label.text = str("Distance: ", cheapestDistance, "\nStation Tax: £", cheapestCost)
	$Toolbar/DurationButtons/FastestRoute/Label.text = str("Distance: ", fastestDistance, "\nStation Tax: £", fastestCost)

func arrived_at_destination():
	assignedTrain.assignedToContract = false 
	targetOne.notInContract = true
	targetTwo.notInContract = true
	StationManager.refresh_contract_ready_stations()
	player.wealth += int(reward)
	queue_free()


func _on_cheapest_route_button_pressed():
	assignedTrain.homeStationNode.spawn_train(cheapestRoute, assignedTrain.trainType, self)
	remainingTax = cheapestCost
	init_train_en_route_screen()

func _on_fastest_route_button_pressed():
	assignedTrain.homeStationNode.spawn_train(fastestRoute, assignedTrain.trainType, self)
	remainingTax = fastestCost
	init_train_en_route_screen()

func find_route(method):
	return Dijkstra.find_route(method, assignedTrain.homeStationNode, targetOne, targetTwo, true)

func find_route_stats(route):
	var cost = 0
	var distance = 0
	for station in route.size():
			if station == route.size() - 1: 
				distance += route[station].global_position.distance_to(route[0].global_position)
				if route[station].stationOwner == 0: break
				cost += route[station].stationTax
				break
			distance += route[station].global_position.distance_to(route[station + 1].global_position)
			if route[station].stationOwner > 0: cost += route[station].stationTax
	return [int(cost), int(distance)]

func estimate_route_distance():
	return find_route_stats(Dijkstra.find_route("Fastest", targetOne, targetTwo))[1]

func init_train_en_route_screen():
	$Toolbar/DurationButtons.visible = false
	$Toolbar/TrainEnRoute.visible = true
	$Toolbar/TrainEnRoute/TrainLabel.text = str(assignedTrain.trainType, " Train-", assignedTrain.homeStation)
	$Toolbar/TrainEnRoute/TrainSprite.play(assignedTrain.trainType)
	player.wealth += int(upfront)

func _physics_process(delta):
	if not $Toolbar/TrainEnRoute.visible: return
	$Toolbar/TrainEnRoute/TimeLeft.text = str("Distance Left: ", distanceLeft, " km")
	$Toolbar/TrainEnRoute/TaxLeft.text = str("Remaining Tax: £", remainingTax)
