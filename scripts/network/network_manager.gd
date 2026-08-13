class_name NetworkManager
extends Node

signal draw_node(node: NetworkNode)
signal update_node_visual(node: NetworkNode)
signal deleted_node_visual(node: NetworkNode)

var nodes: Dictionary = {
	NetworkTypes.Type.POWER:{},
	NetworkTypes.Type.ETHERNET:{},
	NetworkTypes.Type.AIR:{},
}


func _ready() -> void:
	pass

func add_node(node:NetworkNode)-> void:
	if position_is_occupied(node.position):
		print("Celda ocupada: ", node.position)
		return
		
	nodes[node.network_type][node.position] = node
	find_neighbors(node)
	draw_node.emit(node)
	for neighbor in node.neighbors:
		update_node_visual.emit(neighbor)

func remove_node(position: Vector2i, type: NetworkTypes.Type)->void:
	if not nodes[type].has(position):
		return
	
	var node_to_delete: NetworkNode = nodes[type][position]
	
	# Guardamos los vecinos antes de desconectar
	var neighbors := node_to_delete.neighbors.duplicate()
	
	# Desconectar
	for neighbor in neighbors:
		neighbor.disconnect_node(node_to_delete)
	
	# Eliminar visual
	deleted_node_visual.emit(node_to_delete)
	
	# Eliminar del diccionario
	nodes[type].erase(position)
	
	# Recalcular visual de los vecinos
	for neighbor in neighbors:
		update_node_visual.emit(neighbor)

func find_neighbors(node:NetworkNode)-> void:
	var position_center: Vector2i = Vector2i(node.position.x,node.position.y)
	
	var position_up: Vector2i = Vector2i(position_center.x,position_center.y-1)
	var position_right: Vector2i = Vector2i(position_center.x+1,position_center.y)
	var position_down: Vector2i = Vector2i(position_center.x,position_center.y+1)
	var position_left: Vector2i = Vector2i(position_center.x-1,position_center.y)
	

	if (nodes[node.network_type].has(position_up)) :
		#print("Soy" +str(node.position) + " Tengo un nodo arriba "+ str(position_up))
		node.connect_node(nodes[node.network_type][position_up])
	else:
		node.delete_neighbors_in(position_up)
	
	if(nodes[node.network_type].has(position_right)):
		#print("Soy" +str(node.position) + " Tengo un nodo Derecha "+ str(position_right))
		node.connect_node(nodes[node.network_type][position_right])
	else:
		node.delete_neighbors_in(position_right)
	
	if(nodes[node.network_type].has(position_down)):
		#print("Soy" +str(node.position) + " Tengo un nodo abajo "+ str(position_down))
		node.connect_node(nodes[node.network_type][position_down])
	else:
		node.delete_neighbors_in(position_down)
	
	if(nodes[node.network_type].has(position_left)):
		#print("Soy" +str(node.position) + " Tengo un nodo izquerda "+ str(position_left))
		node.connect_node(nodes[node.network_type][position_left])
	else:
		node.delete_neighbors_in(position_left)


var visited_nodes: Dictionary = {}

func get_network_nodes(type_network: NetworkTypes.Type, position: Vector2i) -> Array[NetworkNode]:
	visited_nodes.clear()
	if !nodes.has(type_network):
		return []
	var network = nodes[type_network]
	if !network.has(position):
		return []
	var start = network[position]
	search_neighbors(start)
	return visited_nodes.keys()

func position_is_occupied(position: Vector2i) -> bool:
	for type in nodes:
		if nodes[type].has(position):
			return true
	
	return false

func search_neighbors(node: NetworkNode):
	visited_nodes[node] = true
	for neighbor in node.neighbors:
		if visited_nodes.has(neighbor):
			continue
		search_neighbors(neighbor)
