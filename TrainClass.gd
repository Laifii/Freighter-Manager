class_name Train

var trainType: String
var homeStation: String
var assignedToContract = false
var homeStationNode

func _init(trainType: String, homeStation: String):
	self.trainType = trainType
	self.homeStation = homeStation
	Companies.companies.Player.trains.append(self)
	homeStationNode = identify_home_station_node()

func identify_home_station_node():
	for station in StationManager.stations:
		if station.stationName == homeStation:
			return station
