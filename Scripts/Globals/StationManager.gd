extends Node

# It may not seem like it but this is one of the most important scripts in the game
var stations = []
var stationsInContractRange = []
var contractReadyStations = []

func refresh_contract_ready_stations():
	contractReadyStations.clear()
	for station in stationsInContractRange:
		if station.notInContract: contractReadyStations.append(station)
