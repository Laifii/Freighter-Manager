extends Control

@onready var redSlider = $PlayerColour/RedSlider
@onready var greenSlider = $PlayerColour/GreenSlider
@onready var blueSlider = $PlayerColour/BlueSlider
@onready var primaryColour = $PlayerColour/PrimaryColour
@onready var secondaryColour = $PlayerColour/SecondaryColour
@onready var primaryColourActive = true

func _physics_process(delta):
	if not visible: return
	if primaryColourActive:
		$PlayerColour/PrimaryColour.color[0] = redSlider.value / 255
		$PlayerColour/PrimaryColour.color[1] = greenSlider.value / 255
		$PlayerColour/PrimaryColour.color[2] = blueSlider.value / 255
	else:
		$PlayerColour/SecondaryColour.color[0] = redSlider.value / 255
		$PlayerColour/SecondaryColour.color[1] = greenSlider.value / 255
		$PlayerColour/SecondaryColour.color[2] = blueSlider.value / 255
	
	if Input.is_action_just_pressed("Escape"): visible = false

func _on_primary_colour_button_pressed():
	if $PlayerColour/SecondaryColour/TextureButton.button_pressed: $PlayerColour/SecondaryColour/TextureButton.button_pressed = false
	else: $PlayerColour/PrimaryColour/TextureButton.button_pressed = true
	primaryColourActive = true
	redSlider.value = $PlayerColour/PrimaryColour.color[0] * 255.0
	greenSlider.value = $PlayerColour/PrimaryColour.color[1] * 255.0
	blueSlider.value = $PlayerColour/PrimaryColour.color[2] * 255.0

func _on_secondary_colour_button_pressed():
	if $PlayerColour/PrimaryColour/TextureButton.button_pressed: $PlayerColour/PrimaryColour/TextureButton.button_pressed = false
	else: $PlayerColour/SecondaryColour/TextureButton.button_pressed = true
	primaryColourActive = false
	redSlider.value = $PlayerColour/SecondaryColour.color[0] * 255.0
	greenSlider.value = $PlayerColour/SecondaryColour.color[1] * 255.0
	blueSlider.value = $PlayerColour/SecondaryColour.color[2] * 255.0

func _on_cancel_button_pressed():
	visible = false
