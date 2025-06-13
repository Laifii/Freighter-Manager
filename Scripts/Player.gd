extends Node

var wealth = 0
var ownedTrains = []
var ownedStations = []
@onready var camera = $Camera

func _ready():
	add_to_group("Player")

func _physics_process(delta):
	$Camera/UI/Wealth.text = str("Wealth: ", wealth)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT): wealth += 100000
