extends Node

var unvisitedNodes := []
var distances := {}
var previousNodes := {}

func find_route(method: String, origin: Node, target: Node, secondTarget: Node = null, playerTrain = false):
	var pathToFirstTarget = _find_target(origin, target, method, playerTrain)
	var pathBack = _find_target(target, origin, method, playerTrain)
	if secondTarget != null: 
		var pathToSecondTarget = _find_target(target, secondTarget, method, playerTrain)
		pathBack = _find_target(secondTarget, origin, method, playerTrain)
		return pathToFirstTarget + pathToSecondTarget.slice(1) + pathBack.slice(1)
	
	return pathToFirstTarget + pathBack

func _find_target(origin: Node, target: Node, method: String, playerTrain):
	_init_algorithm(origin)
	while unvisitedNodes.size() > 0:
		var currentNode = _get_closest_node() if method == "Fastest" else _get_cheapest_node(playerTrain)
		if currentNode == target:
			return _find_path(target)
			
		unvisitedNodes.erase(currentNode)
		
		if method == "Fastest": _update_neighbours_distance(currentNode) 
		else: _update_neighbours_cost(currentNode, playerTrain)

func _init_algorithm(startNode: Node):
	unvisitedNodes.clear()
	distances.clear()
	previousNodes.clear()
	
	for station in StationManager.stations:
		unvisitedNodes.append(station)
		distances[station] = INF if station != startNode else 0
		previousNodes[station] = null

func _update_neighbours_distance(node: Node):
	for neighbor in node.connections:
		var neighborNode = node.get_node(neighbor)
		var distance = int(floor(node.global_position.distance_to(neighborNode.global_position)))
		
		var totalDistance = distances[node] + distance
		
		if totalDistance < distances[neighborNode]:
			distances[neighborNode] = totalDistance
			previousNodes[neighborNode] = node

func _update_neighbours_cost(node: Node, playerTrain):
	for neighbor in node.connections:
		var neighborNode = node.get_node(neighbor)
		var cost = neighborNode.stationTax 
		if playerTrain: if neighborNode.stationOwner == 0: cost = 0
		
		var totalCost = distances[node] + cost
		
		if totalCost < distances[neighborNode]:
			distances[neighborNode] = totalCost
			previousNodes[neighborNode] = node

func _get_cheapest_node(playerTrain):
	var lowestCost = INF
	var lowestNode = null
	
	for node in unvisitedNodes:
		if distances[node] < lowestCost:
			lowestCost = distances[node]
			lowestNode = node
			
	return lowestNode

func _get_closest_node():
	var lowestDistance = INF
	var lowestNode = null
	
	for node in unvisitedNodes:
		if distances[node] < lowestDistance:
			lowestDistance = distances[node]
			lowestNode = node
			
	return lowestNode

func _find_path(endNode: Node):
	var path = []
	var currentNode = endNode
	
	while currentNode != null:
		path.push_front(currentNode)
		currentNode = previousNodes[currentNode]
		
	return path
