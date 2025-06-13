extends Camera2D

var camZoom = {
	states = [Vector2(1, 1), Vector2(2, 2), Vector2(4, 4), Vector2(6, 6), Vector2(7, 7)],
	target = Vector2(1, 1)
}
var dragScreen = false

func _input(event):
	if event is not InputEventMouseButton: return
	match event.button_index:
		3:
			dragScreen = true if event.is_pressed() else false
	if not event.is_pressed(): return
	match event.button_index:
		4:
			change_zoom(true)
		5:
			change_zoom(false)

func change_zoom(zoomIn):
	var stateChange = 1 if zoomIn else -1
	var newZoomState = camZoom.states.find(camZoom.target) + stateChange
	if newZoomState >= camZoom.states.size() or newZoomState < 0: return
	print(newZoomState)
	camZoom.target = camZoom.states[newZoomState]

func _physics_process(delta):
	if zoom != camZoom.target: 
		zoom = lerp(zoom, camZoom.target, 0.2)
