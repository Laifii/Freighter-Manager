extends Node

var companies = {
	Player = {stations = [], trains = [], activeTrains = [], trainStorage = []},
	ScottishRail = {stations = [], trains = [{trainType = "Steam"}, {trainType = "Steam"}, {trainType = "Electric"}, {trainType = "Diesel"}], activeTrains = []},
	UnitedRail = {stations = [], trains = [{trainType = "Steam"}, {trainType = "Electric"}, {trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Diesel"}], activeTrains = []},
	CelticCargo = {stations = [], trains = [{trainType = "Steam"}, {trainType = "Electric"}, {trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Diesel"}], activeTrains = []},
	BirminghamExpress = {stations = [], trains = [{trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}], activeTrains = []},
	LondonFreighters = {stations = [], trains = [{trainType = "Diesel"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}], activeTrains = []},
}
