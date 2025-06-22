extends Control

var maxDeals = 4
var stationLabel = preload("res://Objects/Station Label.tscn")
@onready var player = get_tree().get_first_node_in_group("Player")
var newDealsAvailable = true

func _ready():
	await get_tree().create_timer(0.01).timeout
	refresh_deals()

func _physics_process(delta):
	if Input.is_action_just_pressed("Escape"): visible = false
	if player.refreshAuctionHouse: 
		refresh_deals()
		player.refreshAuctionHouse = false

func add_new_contract():
	var deal = stationLabel.instantiate()
	$StationDeals.add_child(deal)

func refresh_deals():
	for deal in $StationDeals.get_children():
		deal.linkedStation.notInDeal = true
		deal.queue_free()
	for deal in maxDeals:
		add_new_contract()
	if $StationDeals.get_children().size() > 0 and not visible:
		newDealsAvailable = true

func _on_cancel_button_pressed():
	visible = false
