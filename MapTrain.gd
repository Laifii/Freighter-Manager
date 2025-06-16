extends Node2D

var trainPath
var nextNodeInPath 
var speed = 10
@onready var calender = get_tree().get_first_node_in_group("Calender")
@onready var sprite = $Sprite2D
var trainColour: Color

func _ready():
	self_modulate = trainColour

func _physics_process(delta):
	if trainPath == null: return
	move_to_next_station(nextNodeInPath, delta)

func find_next_node_in_path():
	if trainPath.size() == 0: 
		queue_free()
		return
	if nextNodeInPath != null: global_position = nextNodeInPath.global_position
	nextNodeInPath = trainPath[0]
	trainPath.erase(trainPath[0])
	look_at(nextNodeInPath.global_position)

func set_train_path(path):
	trainPath = path
	find_next_node_in_path()

func move_to_next_station(target, delta):
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * speed * (delta * calender.timeSpeed[calender.currentSpeed] / 60)
