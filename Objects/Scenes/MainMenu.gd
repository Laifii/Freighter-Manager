extends Control

var saveGameExists = false


func _ready():
	if not saveGameExists: $MainButtons/Continue/ContinueButton.disabled = true

func _on_continue_button_pressed():
	pass # Replace with function body.

func _on_new_game_button_pressed():
	$NewGameScreen.visible = true

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()


func _on_confirm_new_game_button_pressed():
	Settings.playerPrimaryColour = $NewGameScreen/PlayerColour/PrimaryColour.color
	Settings.playerSecondaryColour = $NewGameScreen/PlayerColour/SecondaryColour.color
	Settings.playerCompanyName = $NewGameScreen/LineEdit.text
	var gameInstance = load("res://Objects/Scenes/Countries/Uk Map.tscn").instantiate()
	queue_free()
	get_tree().root.add_child(gameInstance)
