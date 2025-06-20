extends Control

var marketPrice: int
var inAuctionHouse = true
@onready var player = get_tree().get_first_node_in_group("Player")
var activeDiscounts = 1
var baseTrainValue = 250000
@export_enum("Steam", "Electric", "Diesel", "Bullet") var trainType
var trainTypes = ["Steam", "Electric", "Diesel", "Bullet"]
var trainSpeeds = [3, 6, 9, 12]

func _ready():
	if inAuctionHouse: $Toolbar/InAuctionHouse.visible = true
	marketPrice = baseTrainValue * (trainType + 1) * activeDiscounts
	$Toolbar/InAuctionHouse/Label.text = str("Purchase\n£", marketPrice)
	$Toolbar/Train/Label.text = str(trainTypes[trainType], " Train")
	$Toolbar/Train/TrainSprite.play(trainTypes[trainType])
	$Toolbar/Train/Maintenance.text = str("Maintenance Cost: £", trainSpeeds[trainType], "/km")

func _on_purchase_button_pressed():
	if player.wealth < marketPrice: return
	for station in StationManager.stations:
		if station.stationOwner == 0:
			station.trainSelectMode = true
			get_parent().get_parent().visible = false
	player.pendingTrain = Train.new(trainTypes[trainType], "", marketPrice)
