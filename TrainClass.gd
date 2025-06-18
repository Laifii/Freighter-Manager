class_name Train

var trainType: String
var homeStation: String
var assignedToContract = false

func _init(trainType: String, homeStation: String):
	self.trainType = trainType
	self.homeStation = homeStation
	Companies.companies.player.trains.append(self)
