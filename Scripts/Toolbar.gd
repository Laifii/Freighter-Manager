extends Control


func _on_contract_button_pressed():
	var visibleState = $Screens/ContractsScreen.visible
	for screen in $Screens.get_children():
		if screen.visible: screen.visible = false
	$Screens/ContractsScreen.visible = !visibleState


func _on_auction_house_button_pressed():
	var visibleState = $Screens/AuctionHouseScreen.visible
	for screen in $Screens.get_children():
		if screen.visible: screen.visible = false
	$Screens/AuctionHouseScreen.visible = !visibleState
