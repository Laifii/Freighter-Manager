extends Node

func find_fastest_route(origin, target, secondTarget = null):
	if secondTarget == null: pass
	var currentNode = origin
	for count in StationManager.stations:
		get_connections(currentNode)

func get_connections(currentNode):
	for connection in currentNode.connections.size():
		var currentConnection = currentNode.get_node(currentNode.connections[connection])
		var distanceToConnection = int(floor(currentNode.global_position.distance_to(currentConnection.global_position)))
		print(currentConnection)
		print(distanceToConnection)

# Idea for insentivising: less money the longer it takes
