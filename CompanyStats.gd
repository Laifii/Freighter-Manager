extends Node

var companies = {
	Player = {stations = [], trains = [], activeTrains = []},
	ScottishRail = {stations = [], trains = [{trainType = "Steam"}, {trainType = "Steam"}, {trainType = "EarlyElectric"}, {trainType = "Electric"}], activeTrains = []},
	UnitedRail = {stations = [], trains = [{trainType = "Steam"}, {trainType = "EarlyElectric"}, {trainType = "Electric"}, {trainType = "Electric"}, {trainType = "Electric"}], activeTrains = []},
	CelticCargo = {stations = [], trains = [{trainType = "Steam"}, {trainType = "EarlyElectric"}, {trainType = "Electric"}, {trainType = "Electric"}, {trainType = "Electric"}], activeTrains = []},
	BirminghamExpress = {stations = [], trains = [{trainType = "Electric"}, {trainType = "Electric"}, {trainType = "Electric"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}], activeTrains = []},
	LondonFreighters = {stations = [], trains = [{trainType = "Electric"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}], activeTrains = []},
}
