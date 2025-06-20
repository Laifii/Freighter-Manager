extends Control

var linkedStation
var price

func _ready():
	generate_deal()

# generates a deal for a random station that isn't owned by the player
# auction house resets weekly

func generate_deal():
	var stationsAvailableForDeal = []
	for station in StationManager.stationsInContractRange:
		if station.stationOwner != 0 and station.notInDeal: stationsAvailableForDeal.append(station)
	if stationsAvailableForDeal.size() == 0: 
		queue_free()
		return
	linkedStation = stationsAvailableForDeal[randi_range(0, stationsAvailableForDeal.size() - 1)]
	linkedStation.notInDeal = false
	price = int(linkedStation.stationValue * randf_range(0.65, 0.85))
	$Toolbar/InAuctionHouse/Label.text = str("Purchase:\n£", linkedStation.stationValue, "\n£", price)
	$Toolbar/Station/StationSprite.play(linkedStation.sizeList[linkedStation.stationSize])
	$Toolbar/InAuctionHouse/Income.text = str("Income: £", linkedStation.weeklyIncome)
	$Toolbar/Station/Label.text = str(linkedStation.stationName, " - ", linkedStation.sizeList[linkedStation.stationSize])


func _on_purchase_button_pressed():
	if get_tree().get_first_node_in_group("Player").wealth < price: return
	linkedStation.purchase_station(price)
	queue_free()
