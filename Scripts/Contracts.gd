class_name Contract

var station
var requestedItem
var reward
var stationsWithItem = []

func _init(station, item, reward, stationCount = randi_range(1, 5)):
	self.station = station
	self.requestedItem = item
	self.reward = reward
	for count in stationCount:
		var randStation = StationManager.contractReadyStations[randi_range(0, StationManager.contractReadyStations.size())]
		stationsWithItem.append(randStation)
