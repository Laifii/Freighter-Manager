extends Node

var stations = []
var stationsInContractRange = []
var contractReadyStations = []

func refresh_contract_ready_stations():
	contractReadyStations.clear()
	for station in stationsInContractRange:
		if station.notInContract: contractReadyStations.append(station)
