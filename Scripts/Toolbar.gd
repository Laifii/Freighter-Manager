extends Control


func _on_contract_button_pressed():
	var visibleState = $Screens/ContractsScreen.visible
	for screen in $Screens.get_children():
		if screen.visible: screen.visible = false
	$Screens/ContractsScreen.visible = !visibleState
	$Screens/ContractsScreen.pendingFinishedContracts = 0


func _on_auction_house_button_pressed():
	var visibleState = $Screens/AuctionHouseScreen.visible
	for screen in $Screens.get_children():
		if screen.visible: screen.visible = false
	$Screens/AuctionHouseScreen.visible = !visibleState
	$Toolbar/AuctionHouse/Label2.visible = false

func _on_companies_button_pressed():
	var visibleState = $Screens/CompaniesScreen.visible
	for screen in $Screens.get_children():
		if screen.visible: screen.visible = false
	$Screens/CompaniesScreen.visible = !visibleState

func _physics_process(delta):
	$Toolbar/Contracts/Label2.text = str($Screens/ContractsScreen.pendingFinishedContracts)
	if $Screens/ContractsScreen.pendingFinishedContracts == 0: $Toolbar/Contracts/Label2.visible = false
	else: $Toolbar/Contracts/Label2.visible = true
	if $Screens/AuctionHouseScreen.newDealsAvailable: 
		$Toolbar/AuctionHouse/Label2.visible = true
		$Screens/AuctionHouseScreen.newDealsAvailable = false
