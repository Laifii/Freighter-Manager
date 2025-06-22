extends Control


func _physics_process(delta):
	if Input.is_action_just_pressed("Escape"): visible = false

func _on_cancel_button_pressed():
	visible = false
