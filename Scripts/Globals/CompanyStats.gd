extends Node

var colours = {
	ScottishRail = {inner = Color(1, 1, 1), outer = Color(0.0, 0.369, 0.722)},
	CelticCargo = {inner = Color(0.0, 0.694, 0.251), outer = Color(1.0, 0.898, 0.0)},
	UnitedRail = {inner = Color(0.784, 0.063, 0.18), outer = Color(0.004, 0.029, 0.212)},
	BirminghamExpress = {inner = Color(1.0, 0.898, 0.0), outer = Color(0.863, 0.1, 0.05)},
	LondonFreighters = {inner = Color(1, 0, 0), outer = Color(1, 1, 1)}
}

var companies = {
	Player = {stations = [], trains = [], activeTrains = [], trainStorage = []},
	ScottishRail = {stations = [], trains = [{trainType = "Steam"}, {trainType = "Steam"}, {trainType = "Electric"}, {trainType = "Diesel"}], activeTrains = []},
	UnitedRail = {stations = [], trains = [{trainType = "Steam"}, {trainType = "Electric"}, {trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Diesel"}], activeTrains = []},
	CelticCargo = {stations = [], trains = [{trainType = "Steam"}, {trainType = "Electric"}, {trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Diesel"}], activeTrains = []},
	BirminghamExpress = {stations = [], trains = [{trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Diesel"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}], activeTrains = []},
	LondonFreighters = {stations = [], trains = [{trainType = "Diesel"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}, {trainType = "Bullet"}], activeTrains = []},
}
