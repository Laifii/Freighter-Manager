class_name Train

var trainType: String
var homeStation: String
var assignedToContract = false
var homeStationNode
var salePrice: int

func _init(trainType: String, homeStation: String, salePrice: int = 0):
	self.trainType = trainType
	self.homeStation = homeStation
	self.salePrice = salePrice
	homeStationNode = identify_home_station_node()

func identify_home_station_node():
	for station in StationManager.stations:
		if station.stationName == homeStation:
			return station
