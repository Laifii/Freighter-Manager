extends Node

var activeTrains = []

var trainTypeList = ["Steam", "Early Electric", "Electric", "Bullet"]

func spawn_trains():
	for company in Companies.companies:
		var listOfTrainTypes = []
		var listOfActiveTrainTypes = []
		var availableTrainTypes = []
		for train in Companies.companies[company].trains:
			listOfTrainTypes.append(train.trainType)
		for train in Companies.companies[company].activeTrains:
			listOfActiveTrainTypes.append(train.trainType.text)
		if listOfActiveTrainTypes.size() == 0: availableTrainTypes = listOfTrainTypes
		for trainType in listOfActiveTrainTypes: 
			var erasedTrain = false
			for train in listOfTrainTypes:
				if train == trainType:
					erasedTrain = true
					listOfTrainTypes.erase(train)
					break
			if not erasedTrain: availableTrainTypes.append(trainType)
		for trainType in availableTrainTypes:
			generate_random_train(Companies.companies[company].stations[randi_range(0, Companies.companies[company].stations.size() - 1)], trainType)

func generate_random_train(station, trainType):
	var firstTarget = StationManager.stations[randi_range(0, StationManager.stations.size() - 1)]
	var secondTarget = StationManager.stations[randi_range(0, StationManager.stations.size() - 1)]
	var fastestRoute = Dijkstra.find_route("Fastest", station, firstTarget, secondTarget)
	var cheapestRoute = Dijkstra.find_route("Cheapest", station, firstTarget, secondTarget)
	station.spawn_train(fastestRoute if randi_range(0,1) == 1 else cheapestRoute, trainType)
