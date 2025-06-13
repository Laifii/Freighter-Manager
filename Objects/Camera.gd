extends Camera2D

var camZoom = {
	states = [Vector2(1, 1), Vector2(2, 2), Vector2(3, 3), Vector2(4, 4), Vector2(6, 6)],
	currentState = 0,
	dragSpeedMultipliers = [1, 2, 3, 4, 5],
	target = Vector2(1, 1),
	uiScales = [Vector2(1, 1), Vector2(0.5, 0.5), Vector2(0.33, 0.33), Vector2(0.25, 0.25), Vector2(0.167, 0.167)],
	uiTarget = Vector2(1, 1)
}
@onready var ui = $UI
@onready var calender = $UI/Calender
var isDragging = false
var lastMousePosition = Vector2.ZERO
var dragSpeed = 0.85


func _input(event):
	if event is not InputEventMouse: return
	if event is InputEventMouseMotion:
		if not isDragging: return
		var mousePosition = get_global_mouse_position()
		var positionDifference = lastMousePosition - mousePosition
		position += positionDifference * dragSpeed
		lastMousePosition = mousePosition
		return
	match event.button_index:
		3:
			isDragging = event.pressed
			if event.pressed:
				lastMousePosition = get_global_mouse_position()
	if not event.is_pressed(): return
	match event.button_index:
		4:
			change_zoom(true)
		5:
			change_zoom(false)

func change_zoom(zoomIn):
	if isDragging: return
	var stateChange = 1 if zoomIn else -1
	camZoom.currentState = camZoom.states.find(camZoom.target) + stateChange
	if camZoom.currentState >= camZoom.states.size() or camZoom.currentState < 0: return
	camZoom.target = camZoom.states[camZoom.currentState]
	camZoom.uiTarget = camZoom.uiScales[camZoom.currentState]

func _physics_process(delta):
	if zoom != camZoom.target: 
		zoom = lerp(zoom, camZoom.target, 0.2)
		ui.scale.x = 1 / zoom.x
		ui.scale.y = 1 / zoom.y
