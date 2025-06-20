extends Control

var maxDeals = 4
var stationLabel = preload("res://Objects/Station Label.tscn")

func refresh_deals():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("Escape"): visible = false
	if $StationDeals.get_children().size() < maxDeals:
		add_new_contract()

func add_new_contract():
	var deal = stationLabel.instantiate()
	$StationDeals.add_child(deal)

func refresh_contracts():
	for deal in $StationDeals.get_children():
		deal.queue_free()
