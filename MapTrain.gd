extends Node2D

var trainPath
var nextNodeInPath 
var speed = 12
@onready var calender = get_tree().get_first_node_in_group("Calender")
@onready var sprite = $Sprite2D
var trainColour: Color
var hoveringOverTrain = false
@onready var trainUI = $TrainUI
@onready var trainTypeLabel = $TrainUI/Size
var trainType
var trainCompany
var linkedContract
var previousPosition
var distanceLeft
var taxLeft
var previousDistanceLeft

var speeds = {
	Steam = 3,
	EarlyElectric = 6,
	Electric  = 9,
	Bullet = 12,
}

func _ready():
	self_modulate = trainColour
	MapTrainManager.activeTrains.append(self)
	previousPosition = global_position

func _physics_process(delta):
	if trainPath == null: return
	move_to_next_station(nextNodeInPath, delta)
	if Input.is_action_just_pressed("Escape"): if trainUI.visible: trainUI.visible = false
	calc_distance_remaining()

func find_next_node_in_path():
	if trainPath.size() == 0: 
		MapTrainManager.activeTrains.erase(self)
		Companies.companies[trainCompany].activeTrains.erase(self)
		if linkedContract != null: linkedContract.arrived_at_destination()
		queue_free()
		return
	if nextNodeInPath != null: global_position = nextNodeInPath.global_position
	nextNodeInPath = trainPath[0]
	trainPath.erase(trainPath[0])
	$Sprite2D.look_at(nextNodeInPath.global_position)

func calc_distance_remaining():
	if linkedContract == null: return
	if distanceLeft == null: 
		distanceLeft = linkedContract.find_route_stats(trainPath)[1]
		previousDistanceLeft = int(distanceLeft)
	var distanceDifference = global_position.distance_to(previousPosition)
	previousPosition = global_position
	distanceLeft -= distanceDifference
	linkedContract.distanceLeft = int(distanceLeft)
	if previousDistanceLeft > linkedContract.distanceLeft: 
		linkedContract.player.wealth -= speed
		previousDistanceLeft = int(distanceLeft)


func set_ui_stats(origin, trainOwner):
	$TrainUI/Nameplate.text = origin
	$TrainUI/Owner.text = trainOwner

func set_train_path(path):
	trainPath = path
	find_next_node_in_path()

func move_to_next_station(target, delta):
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * speed * (delta * calender.timeSpeed[calender.currentSpeed] / 60)

func _unhandled_input(event):
	if not hoveringOverTrain: return
	if event is not InputEventMouseButton: return
	if not event.is_pressed(): return
	if event.button_index != 1: return
	var selfState = $TrainUI.visible
	for train in MapTrainManager.activeTrains:
		if train.trainUI.visible: train.trainUI.visible = false
	$TrainUI.visible = !selfState

func _on_area_2d_mouse_entered():
	hoveringOverTrain = true

func _on_area_2d_mouse_exited():
	hoveringOverTrain = false

func charge_station_tax(tax):
	if linkedContract == null: return
	get_tree().get_first_node_in_group("Player").wealth -= tax
	linkedContract.remainingTax -= tax
