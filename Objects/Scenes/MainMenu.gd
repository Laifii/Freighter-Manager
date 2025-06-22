extends Control

var saveGameExists = false


func _ready():
	if not saveGameExists: $Menu/MainButtons/Continue/ContinueButton.disabled = true

func _on_continue_button_pressed():
	pass # Replace with function body.

func _on_new_game_button_pressed():
	$Menu/NewGameScreen.visible = true

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()


func _on_confirm_new_game_button_pressed():
	Settings.playerPrimaryColour = $Menu/NewGameScreen/PlayerColour/PrimaryColour.color
	Settings.playerSecondaryColour = $Menu/NewGameScreen/PlayerColour/SecondaryColour.color
	Settings.playerCompanyName = $Menu/NewGameScreen/LineEdit.text
	var gameInstance = load("res://Objects/Scenes/Countries/Uk Map.tscn").instantiate()
	for company in Companies.companies:
		Companies.companies[company].activeTrains.clear()
	MapTrainManager.activeTrains.clear()
	queue_free()
	get_tree().root.add_child(gameInstance)
