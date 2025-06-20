extends Control

var maxDeals = 4
var stationLabel = preload("res://Objects/Station Label.tscn")
@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	if Input.is_action_just_pressed("Escape"): visible = false
	if $StationDeals.get_children().size() < maxDeals:
		add_new_contract()
	if player.refreshAuctionHouse: 
		refresh_deals()
		player.refreshAuctionHouse = false

func add_new_contract():
	var deal = stationLabel.instantiate()
	$StationDeals.add_child(deal)

func refresh_deals():
	for deal in $StationDeals.get_children():
		deal.queue_free()

func _on_cancel_button_pressed():
	visible = false
