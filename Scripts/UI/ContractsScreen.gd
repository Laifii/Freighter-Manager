extends Control

var maxContracts = 4
var contractScene = preload("res://Objects/UI/Contract.tscn")
var pendingFinishedContracts = 0

func _ready():
	await get_tree().create_timer(0.1).timeout
	refresh_contracts()
	if $Backboard/RefreshIcon/TextureButton.disabled: $Backboard/RefreshIcon/TextureButton.disabled = false

func _physics_process(delta):
	if Input.is_action_just_pressed("Escape"): visible = false
	if StationManager.stationsInContractRange.size() < 2: return
	if $GridContainer.get_children().size() < maxContracts:
		add_new_contract()
	maxContracts = get_tree().get_first_node_in_group("Player").currentContractLimit
	

func add_new_contract():
	var contract = contractScene.instantiate()
	$GridContainer.add_child(contract)

func refresh_contracts():
	for contract in $GridContainer.get_children():
		if contract.assignedTrain == null: 
			contract.queue_free()

func _on_refresh_button_pressed():
	refresh_contracts()
	$Backboard/RefreshIcon/TextureButton.disabled = true
	await get_tree().create_timer(120).timeout
	$Backboard/RefreshIcon/TextureButton.disabled = false


func _on_cancel_button_pressed():
	visible = false
