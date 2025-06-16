class_name Contract

var finalStation
var firstStation
var requestedItem
var reward
var timeLeft

func _init(finalStation, firstStation, reward):
	self.finalStation = finalStation
	self.firstStation = firstStation
	self.reward = reward

func create_random_contract():
	finalStation = StationManager.stationsInContractRange[randi_range(0, StationManager.contractReadyStations.size())]
	StationManager.refresh_contract_ready_stations()
	firstStation = StationManager.stationsInContractRange[randi_range(0, StationManager.contractReadyStations.size())]
	StationManager.refresh_contract_ready_stations()

func create_contract():
	pass
