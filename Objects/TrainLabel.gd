extends Control

var inAuctionHouse = true

func _ready():
	if inAuctionHouse: $Toolbar/InAuctionHouse.visible = true
