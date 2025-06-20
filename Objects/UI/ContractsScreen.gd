extends Control

var maxContracts = 12
var contractScene = preload("res://Objects/UI/Contract.tscn")

func _ready():
	await get_tree().create_timer(0.2).timeout
	StationManager.refresh_contract_ready_stations()
	refresh_contracts()
	if $Backboard/RefreshIcon/TextureButton.disabled: $Backboard/RefreshIcon/TextureButton.disabled = false

func _physics_process(delta):
	if Input.is_action_just_pressed("Escape"): visible = false
	if StationManager.contractReadyStations.size() < 2: return
	if $GridContainer.get_children().size() < maxContracts:
		add_new_contract()

func add_new_contract():
	var contract = contractScene.instantiate()
	$GridContainer.add_child(contract)

func refresh_contracts():
	for contract in $GridContainer.get_children():
		if contract.assignedTrain == null: 
			contract.targetOne.notInContract = true
			contract.targetTwo.notInContract = true
			contract.queue_free()
	StationManager.refresh_contract_ready_stations()

func _on_refresh_button_pressed():
	StationManager.refresh_contract_ready_stations()
	refresh_contracts()
	$Backboard/RefreshIcon/TextureButton.disabled = true
	await get_tree().create_timer(600).timeout
	$Backboard/RefreshIcon/TextureButton.disabled = false


func _on_cancel_button_pressed():
	visible = false
